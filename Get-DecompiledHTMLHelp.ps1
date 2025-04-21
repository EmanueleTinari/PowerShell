<#   
#># Class Details:  https://msdn.microsoft.com/en-us/library/system.windows.forms.openfiledialog(v=vs.110).aspx 
$openFileDialog = New-Object windows.forms.openfiledialog   
    $openFileDialog.initialDirectory = [System.IO.Directory]::GetCurrentDirectory()   
    $openFileDialog.title = "Select PublishSettings Configuration File to Import"   
    $openFileDialog.filter = "chm files (*.chm)| *.chm"   
    $openFileDialog.filter = "PublishSettings Files|*.publishsettings|All Files|*.*" 
    $openFileDialog.ShowHelp = $True   
    Write-Host "Select Downloaded Settings File... (see FileOpen Dialog)" -ForegroundColor Green  
    $result = $openFileDialog.ShowDialog()   # Display the Dialog / Wait for user response 
    # in ISE you may have to alt-tab or minimize ISE to see dialog box 
    $result 
    if($result -eq "OK")    {    
            Write-Host "Selected Downloaded Settings File:"  -ForegroundColor Green  
            $OpenFileDialog.filename   
            # $OpenFileDialog.CheckFileExists 
             
            # Import-AzurePublishSettingsFile -PublishSettingsFile $openFileDialog.filename  
            # Unremark the above line if you actually want to perform an import of a publish settings file  
            Write-Host "Import Settings File Imported!" -ForegroundColor Green 
        } 
        else { Write-Host "Import Settings File Cancelled!" -ForegroundColor Yellow} 
    
Function Get-DecompiledHTMLHelp
{
    [cmdletbinding()]
    param(
            [String] $Destination, [String]$Filename
    )

    $EXE = 'C:\Windows\hh.exe'

    If(-not (Test-Path $destination))
    {
        "Destination folder doesn't exist"
    }
    elseIf(-not (Test-Path $Filename))
    {
        "Target .chm file not found, please make sure you're entering the full path and file name"
    }
    else
    {
        Start-Process -FilePath $EXE -ArgumentList "-decompile $Destination $Filename"
        $FilesAndFolder = Get-ChildItem $Destination -Recurse| group psiscontainer

        $FolderCount = ($Filesandfolder| ?{$_.name -eq $true}).count
        $FileCount = ($Filesandfolder| ?{$_.name -eq $False}).count
        
        Write-host "Decompiled into $(if($Foldercount -gt 0){$Foldercount}else{0}) Folders and $(if($FileCount){$FileCount}else{0}) Files to Destination $Destination" -ForegroundColor Yellow
    }
    
}