<#
#># Class Details:  https://msdn.microsoft.com/en-us/library/system.windows.forms.openfiledialog(v=vs.110).aspx 

Function DecompileFileCHM {

	[CmdletBinding()]

	Param (

		[String]$Destination = "DeCompiledCHM",
		[String]$FileCHM

	)

	$PathHHexe = 'C:\Windows\hh.exe'

	If(-not (Test-Path $Destination)) {

		Write-host "Destination folder doesn't exist" -ForegroundColor Red
		Write-host "Create destination path: " ($Destination) -ForegroundColor Yellow

		Try {

			New-Item -ItemType Directory -Force -Path $Destination
			Write-host "Folder " ($Destination) "created!" -ForegroundColor Green

		}

		Catch {

			Write-Host "Error calling 'Function DecompileFileCHM'. Message: +
			$($_.Exception.Message) + $($_.ScriptStackTrace)"
	
		# End Catch
		}

		Finally {}
	}

	ElseIf(-not (Test-Path $FileCHM)) {

		Write-host "- Target file" $FileCHM "not found." + "`n" + "- Please make sure you're entering the full path and file name" -ForegroundColor Red

	}

	Else {

		Start-Process -FilePath $PathHHexe -ArgumentList "-decompile $Destination $FileCHM"
		$FilesAndFolder = Get-ChildItem $Destination -Recurse| Group-Object PSIsContainer

		$FolderCount = ($FilesAndFolder| Where-Object{$_.name -eq $True}).count
		$FileCount = ($FilesAndFolder| Where-Object{$_.name -eq $False}).count
		
		Write-host "De-Compiled into $(If($FolderCount -gt 0){ $FolderCount } Else{ 0 }) Folders and $(If($FileCount){ $FileCount } Else{ 0 }) Files to Destination $Destination" -ForegroundColor Yellow

	}

}

# Get the ID and security principal of the current user account
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the administrator role
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

$myScriptPath = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition) + "\"
Write-Host "Contenuto variabile del mio script path: " $myScriptPath

If ((Test-Path -Path "HkLM:\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine") -eq $True) {

	$PS5version = (Get-ItemProperty -Path HkLM:\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine -Name 'PowerShellVersion').PowerShellVersion

}

ElseIf ((Test-Path -Path "HkLM:\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine") -eq $False) {

	$PS5version = ""

}

If ((Test-Path -Path "HkLM:\SOFTWARE\Microsoft\PowerShellCore\InstalledVersions\31ab5147-9a97-4452-8443-d9709f0516e1") -eq $True) {

	$PS7version = (Get-ItemProperty -Path HkLM:\SOFTWARE\Microsoft\PowerShellCore\InstalledVersions\31ab5147-9a97-4452-8443-d9709f0516e1 -Name 'SemanticVersion').SemanticVersion

}

ElseIf ((Test-Path -Path "HkLM:\SOFTWARE\Microsoft\PowerShellCore\InstalledVersions\31ab5147-9a97-4452-8443-d9709f0516e1") -eq $False) {

	$PS7version = ""

}

If (($PS5version -gt 5) -And ($PS7version -eq "")) {
	# Ok PS 5, No PS 7. Using PS 5
	Write-Host "No PowerShell 7 in the system. Start powershell.exe"
	$PowerShellExe = "powershell.exe"
}

ElseIf (($PS5version -gt 5) -And ($PS7version -gt 7)) {
	# Ok PS5, Ok PS 7. Using PS 7
	Write-Host "PowerShell Core present. Start pwsh.exe"
	$PowerShellExe = "pwsh.exe"
}

ElseIf (($PS5version -eq "") -And ($PS7version -gt 7)) {
	# No PS5, Ok PS 7. Using PS 7
	Write-Host "PowerShell Core present. Start pwsh.exe"
	$PowerShellExe = "pwsh.exe"
}
	pause


# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))
   {
   # We are running "as Administrator" - so change the title and background color to indicate this
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
   $Host.UI.RawUI.BackgroundColor = "DarkBlue"
   clear-host
   }
else
   {
   # We are not running "as Administrator" - so relaunch as administrator
   
   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo ($PowerShellExe)

   # Specify the current script path and name as a parameter
   $newProcess.Arguments = ('-NoExit -NoProfile -ExecutionPolicy Bypass -Command `"Set-Location "$myScriptPath"`"')

   # Indicate that the process should be elevated
   $newProcess.WorkingDirectory = ($myScriptPath);
   
   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess)

   # Exit from the current, unelevated, process
   Exit
   }

# Run your code that needs to be elevated here
#Write-Host -NoNewLine "Press any key to continue..."
#$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

	# Load Assembly
	Add-Type -AssemblyName System.Windows.Forms

	# Open Class
	$openFileDialog						= New-Object -TypeName System.Windows.Forms.OpenFileDialog
	$openFileDialog.initialDirectory	= [System.IO.Directory]::GetCurrentDirectory()
	$openFileDialog.Title				= "Select CHM File to decompile."
	$openFileDialog.Filter				= "chm files (*.chm)| *.chm"

	Write-Host "Select a CHM File to decompile... (see FileOpen Dialog)" -ForegroundColor Green
	# Display the Dialog / Wait for user response
	$result = $openFileDialog.ShowDialog()

	# in ISE you may have to alt-tab or minimize ISE to see dialog box
	If($result -eq "OK") {

		Write-Host "File CHM scelto: " -ForegroundColor Green $OpenFileDialog.FileName
		$Dest = "DeCompiledCHM"
		DecompileFileCHM -Destination $Dest -FileCHM ([System.IO.Path]::GetFileName($OpenFileDialog.FileName))

	}

	Else {

		Write-Host "Import CHM File Cancelled!" -ForegroundColor Yellow

	}

	Pause
