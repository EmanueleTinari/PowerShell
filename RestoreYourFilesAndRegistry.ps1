Function RestoreFilesFromXML
{
    [void](New-PSDrive -Name HKCR -PSProvider registry -root HKEY_CLASSES_ROOT) # Allows access to registry HKEY_CLASSES_ROOT
    if ((Test-Path -path "C:\MATS\{4757C19B-4CE3-418C-91D2-E15E938091FB}\\FileBackupTemplate.xml")) 
    { 
        $xml =[xml] (get-content "C:\MATS\{4757C19B-4CE3-418C-91D2-E15E938091FB}\\FileBackupTemplate.xml")
        $root =$xml.FileBackup.File
        foreach ($XMLItems in $xml.FileBackup.File)
        {    
            if (!(Test-Path $XMLItems.FileBackupLocation))
            {
                if (!(Test-Path -path $XMLItems.FileBackupLocation.substring(0,($XMLItems.FileBackupLocation.LastIndexOf("\"))))) 
                    { 
                         [void](New-Item $XMLItems.FileBackupLocation.substring(0,($XMLItems.FileBackupLocation.LastIndexOf("\"))) -type directory) #Create the backup directories ready to copy the files into then
                    }
                Copy-Item $XMLItems.FileDestination -Destination ($XMLItems.FileBackupLocation) -ErrorAction SilentlyContinue #copy files to the backup folder
            }
        }
    }
}

Function RestoreRegistryFiles
{
    [void](New-PSDrive -Name HKCR -PSProvider registry -root HKEY_CLASSES_ROOT) # Allows access to registry HKEY_CLASSES_ROOT
    if ((Test-Path -path "C:\MATS\{4757C19B-4CE3-418C-91D2-E15E938091FB}\registryBackupTemplate.xml")) 
    { 
        $xml =[xml] (get-content "C:\MATS\{4757C19B-4CE3-418C-91D2-E15E938091FB}\registryBackupTemplate.xml")
        $root =$xml.RegistryBackup.Registry
        foreach ($XMLItems in $xml.RegistryBackup.Registry)
        {    
            if (!(CheckRegistryValueExists -RegRoot $XMLItems.RegistryHive -RegValue $XMLItems.RegistryName))
            {
            if ($XMLItems.RegistryType -eq "MultiString")
            {
            [string[]]$MultiString=$XMLItems.RegistryValue.Split(";")
            new-item -path $XMLItems.RegistryHive -ErrorAction SilentlyContinue | Out-Null 
            New-ItemProperty $XMLItems.RegistryHive $XMLItems.RegistryName -value $MultiString -propertyType $XMLItems.RegistryType
            }
            elseif($XMLItems.RegistryType -eq "Binary")
            {
            new-item -path $XMLItems.RegistryHive                   
            [Byte[]]$ByteArray = @()
            foreach($byte in $XMLItems.RegistryValue.Split(",")){$ByteArray += $byte}
            New-ItemProperty $XMLItems.RegistryHive $XMLItems.RegistryName -value $ByteArray -propertyType $XMLItems.RegistryType
            }
            elseif($XMLItems.RegistryType -eq "Dword")
            {
            $DwordValue =Hex2Dec $XMLItems.RegistryValue
            new-item -path $XMLItems.RegistryHive -ErrorAction SilentlyContinue | Out-Null  
            New-ItemProperty $XMLItems.RegistryHive $XMLItems.RegistryName -value $DwordValue  -propertyType $XMLItems.RegistryType
            }
            else
            {
            ##Main Registry key missing so create here
            new-item -path $XMLItems.RegistryHive -ErrorAction SilentlyContinue | Out-Null  
            New-ItemProperty $XMLItems.RegistryHive $XMLItems.RegistryName -value $XMLItems.RegistryValue -propertyType $XMLItems.RegistryType
            }
            }
         }
    }
}
Function CheckRegistryValueExists
{
Param($RegRoot,$RegValue)
Get-ItemProperty $RegRoot $RegValue -ErrorAction SilentlyContinue | Out-Null  
$?
}
function Hex2Dec
{
param($HEX)
ForEach ($value in $HEX)
{
    [Convert]::ToInt32($value,16)
}
}

function Test-Administrator
{
$user = [Security.Principal.WindowsIdentity]::GetCurrent() 
(New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
$UsersTemp= $Env:temp
Copy-Item  "C:\MATS\{4757C19B-4CE3-418C-91D2-E15E938091FB}\\RestoreYourFilesAndRegistry.ps1" -Destination ($UsersTemp+"\RestoreYourFilesAndRegistry.ps1") -ErrorAction SilentlyContinue
If(Test-Administrator)
{
RestoreRegistryFiles
RestoreFilesFromXML
}
else
{
cls
$ElevatedProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell"    
$ElevatedProcess.Arguments =  ($UsersTemp+"\RestoreYourFilesAndRegistry.ps1")
$ElevatedProcess.Verb = "runas"     
[System.Diagnostics.Process]::Start($ElevatedProcess)     
exit
}
