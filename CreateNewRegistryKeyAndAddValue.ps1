# Svuota lo schermo.
Clear-Host
# Nella Var mette il valore attuale del colore del testo.
$color = $Host.UI.RawUI.ForegroundColor

# Nella Var è contenuta la Chiave da modificare o creare.
$chiave = ".frm"

# Test per verificare se la Chiave esiste.
if (Test-Path -Path Registry::HKEY_CLASSES_ROOT\$chiave) {
	# Testo inviato alla consolle in verde.
	$Host.UI.RawUI.ForegroundColor = 10
	# La Chiave esiste.
  	Write-Output "$chiave esiste."
	# Ferma l'esecuzione.	
	pause
	# Svuota lo schermo.
	Clear-Host
	# Ripristino il colore originale del testo.
	$Host.UI.RawUI.ForegroundColor = $color
}
else {
	# Testo inviato alla consolle in rosso.
	$Host.UI.RawUI.ForegroundColor = 12
	# La Chiave NON esiste. 

	do	{
			$yn = Read-Host "$chiave NON esiste. La creo? [y/n]"
			if ($yn-eq 'n')
				{
					# Ripristino il colore originale del testo.
					$Host.UI.RawUI.ForegroundColor = $color
					# Esce.
					exit
				}
		}
	while ($yn -ne "y")
  
	# Ripristino il colore originale del testo.
	$Host.UI.RawUI.ForegroundColor = $color
	# La crea.
	set-location -path Registry::HKEY_CLASSES_ROOT\
	New-Item -Path $chiave -Force
}

# Set path variables for PowerShell file types
$Path1 = 'Registry::HKEY_CLASSES_ROOT\.frm'

# Enable preview of those file types
New-ItemProperty -Path $Path1 -Name PerceivedType -PropertyType String  -Value 'text'