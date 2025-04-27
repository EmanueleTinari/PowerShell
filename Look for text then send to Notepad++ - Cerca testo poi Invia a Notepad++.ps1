Clear-Host

$PercorsoFile = "D:\Documenti\Desktop\Moduli Excel\"

$FiltroFile = "*.bas"

#$StringaDaCercare = " As Workbook"
#$StringaDaCercare = "HWnd"
#$StringaDaCercare = "StringaRipeti"
#$StringaDaCercare = "Free"
#$StringaDaCercare = "Sleep"
$StringaDaCercare = "If EsisteRiferimento"

$Comando = "C:\notepad++.exe"

$Slash = (0x002F -as [char])

#Write-Host $PercorsoFile
#Write-Host $FiltroFile
#Write-Host $StringaDaCercare
#Write-Host $Comando
#Write-Host $Slash

$files = Get-ChildItem $PercorsoFile -Recurse -Include $FiltroFile | Select-String $StringaDaCercare | Select-Object Filename
#Write-Host "Trovati " $files.Count " file"

# Iterate through each item in the array
Foreach ($item in $files)
	{
		# Output the current item
		$FileCorrente = $item.Filename
		Write-Host $FileCorrente
		#$Parametri = " " + $PercorsoFile + $FileCorrente
		#Write-Host $Parametri
		
		#$ComandoCompleto = $Comando + $Parametri
		#& $ComandoCompleto
		#powershell.exe $Comando
		#$bytes = [System.Text.Encoding]::Unicode.GetBytes($ComandoCompleto)
		#$encodedCommand = [Convert]::ToBase64String($bytes)
		#powershell.exe -EncodedCommand $encodedCommand
		#Start-Sleep -Seconds 2
		#Break
	}