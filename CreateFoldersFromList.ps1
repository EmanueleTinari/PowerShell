	<#
		.SYNOPSIS
			[ITA] .
			[ENG] .

		.DESCRIPTION
			[ITA] .
			[ENG] .

		.PARAMETER
			0 - [ITA] .
			0 - [ENG] .

		.EXAMPLE	
			

		.EXAMPLE	
			

		.EXAMPLE	
			

		.INPUTS
			.

		.OUTPUTS
			.
	#>





						#############
						# Functions #
						#############

Function ExtractUISysLang {
	<#
		.SYNOPSIS
			[ITA] Restituisce la sigla della lingua d'interfaccia di sistema.
			[ENG] Returns the system UI language, in format xx-XX.

		.DESCRIPTION
			[ITA] Questa funzione restituisce la sigla della lingua attuale dell'interfaccia del sistema, nel formato xx-XX.
			[ENG] This function returns the actual system UI language, a.k.a. Windows display language, in format xx-XX.

		.EXAMPLE
			$UILang = ExtractUISysLang
	#>

	Return ((Get-UICulture).Name)
}

Function ExtractUISysLangLCID {
	<#
		.SYNOPSIS
			[ITA] Restituisce il LCID della lingua d'interfaccia di sistema.
			[ENG] Returns the system UI language LCID.

		.DESCRIPTION
			[ITA] Questa funzione restituisce il codice numerico LCID della lingua attuale dell'interfaccia del sistema.
			[ENG] This function returns the actual UI system language as LCID code.

		.EXAMPLE
			$UILangLCID =  ExtractUISysLangLCID
	#>

	Return ((Get-UICulture).LCID)
}

Function ExtractSysLang {
	<#
		.SYNOPSIS
			[ITA] Restituisce la sigla delle impostazioni di cultura correnti impostate nel sistema operativo.
			[ENG] Returns the current culture set in the operating system, in format xx-XX.

		.DESCRIPTION
			[ITA] Questa funzione restituisce la sigla delle impostazioni di cultura correnti impostate nel sistema operativo (comprese le formattazioni di valuta ed ora), nel formato xx-XX.
			[ENG] This function returns the actual system language, a.k.a Regional format (locale), in format xx-XX.

		.EXAMPLE
			$sysLang = ExtractSysLang
	#>

	Return ((Get-Culture).Name)
}

Function ExtractSysLangLCID {
	<#
		.SYNOPSIS
			[ITA] Restituisce il LCID delle impostazioni di cultura correnti impostate nel sistema operativo.
			[ENG] Returns the current culture LCID set in the operating system.

		.DESCRIPTION
			[ITA] Questa funzione restituisce il codice numerico LCID delle impostazioni di cultura correnti impostate nel sistema operativo (comprese le formattazioni di valuta ed ora).
			[ENG] This function returns the actual system language, a.k.a Regional format (locale) as LCID code.

		.EXAMPLE
			$sysLangLCID = ExtractSysLangLCID
	#>

	Return ((Get-Culture).LCID)
}

Function ExtractSysLoc {
	<#
		.SYNOPSIS
			[ITA] Restituisce la sigla delle impostazioni locali correnti impostate nel sistema operativo.
			[ENG] Returns the System-locale setting for the current computer, in format xx-XX.

		.DESCRIPTION
			[ITA] Questa funzione restituisce la sigla, nel formato xx-XX, delle impostazioni per il computer corrente.
			[ENG] This function returns the name of the System-locale setting for the current computer, in format xx-XX.

		.EXAMPLE
			$sysLoc = ExtractSysLoc
	#>

	Return ((Get-WinSystemLocale).Name)
}

Function ExtractSysLocLCID {
	<#
		.SYNOPSIS
			[ITA] Restituisce il LCID delle impostazioni locali correnti impostate nel sistema operativo.
			[ENG] Returns the System-locale setting LCID for the current computer.

		.DESCRIPTION
			[ITA] Questa funzione restituisce il codice numerico LCID delle impostazioni locali correnti impostate nel sistema operativo.
			[ENG] This function returns the actual System-locale setting for the current computer as LCID code.

		.EXAMPLE
			$sysLocLCID = ExtractSysLocLCID
	#>

	Return ((Get-WinSystemLocale).LCID)
}


Function Get-OperationDate {
	<#
		.SYNOPSIS
		[ITA] Crea una stringa contenente la data ed ora locali attuali e la stessa in UTC.
		[ENG] Build a string with local and UTC date/time.

		.DESCRIPTION
		[ITA] Questa funzione restituisce una stringa composta dalla data ed ora locali attuali, la differenza in ore rispetto all'UTC, e la stessa data ed ora in formato UTC.
		[ENG] This function returns a string built with local date/time, the difference in hours with the UTC, and the same date/time in UTC format.

		.EXAMPLE	
			$myDate = Get-OperationDate
	#>

	$DataLoc = Get-Date -Format "dd-MM-yyyy HH:mm:ss.ffff"
	$DataUtc = (Get-Date).ToUniversalTime().ToString("dd-MM-yyyy HH:mm:ss.ffff UTC")
	$DiffOre = Get-Date -UFormat "%Z"
	# [ITA] La Function restituisce, formattata, una stringa contenente i valori delle tre variabili precedenti.
	# [ENG] Function return a formatted string with 3 variables values.
	Return ( "{[" + $DataLoc + "](" + $DiffOre + ")[" + $DataUtc + "]} -> " )
}







Function Open-ShowFileDialog {
	<#
		.SYNOPSIS
			[ITA] Apre una finestra di dialogo per selezionare un file.
			[ENG] Open a FileDialog to choose a file.

		.DESCRIPTION
			[ITA] Questa Funzione apre una finestra di dialogo per far scegliere all'utente un file; viene restituito il suo nome col suo percorso completo.
			[ENG] Function open a FileDialog windows and let user choose a file; then return his name, extension and complete path.

		.PARAMETER
			0 - [ITA] Cartella iniziale, non obbligatorio, di default è Questo PC.
			0 - [ENG] Initial Dir, not mandatory, This PC as default.
			1 - [ITA] .
			1 - [ENG] .

		.EXAMPLE	
			Open-ShowFileDialog

		.EXAMPLE	
			Open-ShowFileDialog

		.EXAMPLE	
			Open-ShowFileDialog
	#>

	Param
		(
			[Parameter( Position = 0, Mandatory = $False )] [String] $ofd_InitialDir = "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}",	# Default
			[Parameter( Position = 1, Mandatory = $False )] [String] $ofd_Filter = "All files (*.*)|*.*",	# Default
			[Parameter( Position = 2, Mandatory = $False )] [String] $ofd_FilterIndex = "1",	# Default
			[Parameter( Position = 3, Mandatory = $False )] [Boolean] $ofd_Multi = "False",	# Default
			[Parameter( Position = 4, Mandatory = $False )] [String] $ofd_Title = "Select a file",	# Default

			[Parameter( Position = "X", Mandatory = $False )] [String] $ofd_ = ""	# Default
		)
	Add-Type -AssemblyName System.Windows.Forms
	$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog
	# [ITA] Apre una finestra di tipo FileDialog per scegliere un file posizionandosi all'apertura (se non viene passato alcun dato al parametro $ofd_InitialDir) su: Questo PC.
	# [ENG] Open the FileDialog on This PC (or MyComputer) if no string is passed by $ofd_InitialDir parameter.
	$FileBrowser.InitialDirectory = $ofd_InitialDir
	# [ITA] Qui viene impostato il filtro dei file, se non viene passata alcuna stringa al parametro $ofd_Filter, sarà Tutti i file.
	# [ENG] Here you can set Filter. If no string is passed by $ofd_Filter parameter, is set on: All files.
	$FileBrowser.Filter = $ofd_Filter
	# [ITA] Qui viene impostato l'indice del filtro selezionato; se non viene passata alcuna valore al parametro $ofd_FilterIndex, sarà 1, il primo nel menù a discesa del filtro.
	# [ENG] Here you can set Filter index. If no value is passed by $ofd_FilterIndex parameter, is set on: 1 (First in list).
	$FileBrowser.Filter = $ofd_FilterIndex
	# [ITA] Qui viene impostato se la finestra di dialogo permette o meno la selezione di più file, di default è no (False).
	# [ENG] Here you can set if you can or not multiselect files, default is not (False).
	$fileBrowser.Multiselect = $ofd_Multi
	# [ITA] Qui viene settato il Titolo della finestra di dialogo, il cui valore di default è: Select a file (Seleziona un file).
	# [ENG] This is for the Title of the form, default value is: Select a file.
	$FileBrowser.Title = $ofd_Title


	$FileBrowser.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $True; Name = $HelpText })) | Out-Null

	# [ITA] La Function restituisce il nome del file scelto nella finestra di dialogo, completo del suo percorso ed estensione.
	# [ENG] Function return the name, complete with his path and extension, of the file choose with FileDialog.
	Return $FileBrowser.FileName
}


$pippo = Open-ShowFileDialog
Write-Host $pippo


Function CountLines {			
	<#
		.SYNOPSIS
			[ITA] .
			[ENG] .

		.DESCRIPTION
			[ITA] Questa Funzione conta il numero delle linee in un dato file di testo, completo del suo percorso completo.
			[ENG] Function to count the number of lines in a text file..

		.PARAMETER
			(Mandatory = $True) $FilePath.

		.EXAMPLE	
			$File = "C:\Test.txt"
			$NumberOfLines = CountLines $File

		.INPUTS
				.

		.OUTPUTS
			.
	#>
	[CmdletBinding()]
	Param
	(
		[Parameter( Mandatory = $True )] [String] $FilePath
	)
	$NumberOfLines = [Linq.Enumerable]::Count([System.IO.File]::ReadLines( $FilePath ))
	# Function return the number of lines in a given file, passed with his complete path as parameter.
	Return $NumberOfLines
}





# Questa Funzione estrae una specifica linea (indicata da un numero) in un dato file di testo.
# Function to extract the specified line in a text file.

Function ExtractLine {			
	[CmdletBinding()]
	Param
	(
		[Parameter( Mandatory = $True )] [String] $FilePath,
		[Parameter( Mandatory = $True )] [String] $LineNumber
	)
	$LineContent = [Linq.Enumerable]::ElementAt(([System.IO.File]::ReadLines( $FilePath )), $LineNumber )
	# Function return the line in a given file, passed with his complete path as parameter, at a indicated line number
	Return $LineContent
}


# Questa funzione controlla che una certa cartella esista in un determinato percorso.
# Function to check if a given folder exist in a given path.

Function Test-FolderExist {
	<#
		.SYNOPSIS
			Test for the existence of a folder
			
			ALIAS
				Folder
			
		.DESCRIPTION
			This function test for the existence of a folder
		
		.PARAMETER Path
			The path to the folder.
		
		.EXAMPLE	
			$folderExists = Test-FolderExist 'c:\temp\'
	
		.EXAMPLE	
			$folderExists = Test-FolderExist -Path 'c:\temp\'
			
		.EXAMPLE	
			$folderExists = 'c:\temp\' | Test-FolderExist
		
		.INPUTS
			Path as String
		
		.OUTPUTS
			Boolean
	#>
	[Alias("Folder")]
	[CmdletBinding()]
	Param
		(
			[Parameter( Mandatory = $True, ValueFromPipeline = $True )] [String] $FolderPath
		)
	if ( Test-Path -Path $FolderPath )
		{
			Return $True
		}	Else
				{
					Return $False
				}
}


# Questa funzione controlla che un certo file esista in un determinato percorso.
# Function to check if a given file exist in a given path.

Function Test-FileExist {
	<#
		.SYNOPSIS
			Test for the existence of a file

			ALIAS
				File

		.DESCRIPTION
			This function test for the existence of a file

		.PARAMETER Path
			The path to the file.

		.EXAMPLE	
			$fileExists = Test-FileExist 'c:\temp\temp.txt'

		.EXAMPLE	
			$fileExists = Test-FileExist -Path 'c:\temp\temp.txt'

		.EXAMPLE	
			$fileExists = 'c:\temp\temp.txt' | Test-FileExist

		.INPUTS
			Path as String

		.OUTPUTS
			Boolean
	#>
	[Alias("File")]
	[CmdletBinding()]
	Param
		(
			[Parameter( Mandatory = $True, ValueFromPipeline = $True )] [String] $FilePath
		)
	If ( Test-Path -Path $FilePath )
		{
			Return $True
		}
	Else
		{
			Return $False
		}
}





# Questa funzione inserisce all'inizio di qualsiasi file di testo una riga.
# Function to insert in a text file a line of text.
# Esempio: get-item fileName.ext | PrependTo-File "contentToAdd`r`n"
Function PrependToFile {
	<#
		.SYNOPSIS
			.

		.DESCRIPTION
			.

		.PARAMETER Path
			.

		.EXAMPLE	
			

		.EXAMPLE	
			

		.EXAMPLE	
			

		.INPUTS
			.

		.OUTPUTS
			.
	#>
	[CmdletBinding()]
	Param
		(
			[Parameter( Position = 0, ValueFromPipeline = $True, Mandatory = $True, ValueFromPipelineByPropertyName = $True )] [System.IO.FileInfo] $File,
			[Parameter( Position = 1, ValueFromPipeline = $False, Mandatory = $True )] [String] $Content
		)
	Process
		{
			If ( !$File.Exists )
				{
					Write-Error "$File does not exist."
					Return
				}
			$FilePath = $File.Fullname
			$tmpToken = (Get-Location).Path + "\_tmpFile" + $File.Name
			Write-Verbose "$tmpToken created to as buffer."
			$tfs = [System.IO.File]::Create( $tmpToken )
			$fs = [System.IO.File]::Open( $File.Fullname,[System.IO.FileMode]::Open,[System.IO.FileAccess]::ReadWrite )
			Try
				{
					$msg = $Content.ToCharArray()
					$tfs.Write( $msg, 0, $msg.Length )
					$fs.Position = 0
					$fs.CopyTo( $tfs )
				}
			Catch
				{
					Write-Verbose $_.Exception.Message
				}
			Finally
				{
					$tfs.Close()
					# Close calls dispose and GC.SuppressFinalize internally.
					$fs.Close()
					If ( $Error.Count -eq 0 )
						{
							Write-Verbose ( "Updating $FilePath" )
							[System.IO.File]::Delete( $FilePath )
							[System.IO.File]::Move( $tmpToken, $FilePath )
						}
					Else
						{
							$Error.Clear()
							Write-Verbose ( "An error occurred, rolling back. $FilePath not effected" )
							[System.IO.File]::Delete( $tmpToken )
						}
				}
		}
}





						########
						# Main #
						########
$xxxMain
# Clear the console.
Clear-Host

# Set in next 2 variables the italian values.
# ATTENZIONE: CAMBIARE DOPO LE PROVE !!!
Set-Variable -Option Constant -Scope Global -Name "ItaLang" -Value "en-EN" -Description "Here is stored the string for Italian"

Set-Variable -Option Constant -Scope Global -Name "ItaLCID" -Value "1040" -Description "Here is stored the LCID for Italian"


# Set in next 6 variables the values extract from the system.
$L11 = ExtractUISysLang
$L12 = ExtractUISysLangLCID
$L21 = ExtractSysLang
$L22 = ExtractSysLangLCID
$L31 = ExtractSysLoc
$L32 = ExtractSysLocLCID

# If statement to compare values in the system to set the language of the script.
If ( $L11 -eq $ItaLang -And $L21 -eq $ItaLang -And $L31 -eq $ItaLang )
	{
		If ( $L12 -eq $ItaLCID -And $L22 -eq $ItaLCID -And $L32 -eq $ItaLCID )
			{
				# Italiano
				Write-Host "Imposto la lingua dello script su: Italiano"
				Set-Variable -Option Constant -Scope Global -Name "ScriptLan" -Value "IT" -Description "Here is stored the value found for Italian"
			}
	}
Else
	{
		# English
		Write-Host "Set script language on: English"
		Set-Variable -Name "ScriptLan" -Value "EN" -Option Constant -Scope Global -Description "Here is stored the value found for English"
	}

# If statement to load in array data depending by the $ScriptLang.
If ( $ScriptLang -eq "IT" )
	{
		$Ita = @(
		[PSCustomObject]@{Num = '1'; Testo = 'Seleziona il file contenente la lista di elementi di cui creare le cartelle'}
		[PSCustomObject]@{Num = '2'; Testo = 'File di testo (*.txt)|*.txt|Tutti i file (*.*)|*.*'}
		[PSCustomObject]@{Num = '3'; Testo = ''}
		)
	}
Else
	{
		$Eng = @(
		[PSCustomObject]@{ Num = '1'; Text = 'Select file with elements list to create folders'}
		[PSCustomObject]@{ Num = '2'; Text = 'Text files (*.txt)|*.txt|All files (*.*)|*.*'}
		[PSCustomObject]@{ Num = '3'; Text = ''}
		)
	}

# ATTENZIONE: ELIMINARE QUESTA RIGA !!!
Write-Host $ScriptLang

$ChoseFile = 	If ( $ScriptLang -eq "IT" )
{
	Open-ShowFileDialog.Title = $Ita[0].Testo
}
Else
{
	Open-ShowFileDialog.Title = $Eng[0].Text
}

# [ITA] Qui viene settato il Filtro della finestra di dialogo in base alla lingua impostata per lo script.
# [ENG] This is for the Filter of the form.
If ( $ScriptLang -eq "IT" )
	{
		$FileBrowser.Filter = $Ita[1].Testo
	}
Else
	{
		$FileBrowser.Filter = $Eng[1].Text
	}


# ATTENZIONE: ELIMINARE QUESTA RIGA !!!
Write-Host $ChoseFile

$NumberOfLines = CountLines $ChoseFile

# ATTENZIONE: ELIMINARE QUESTA RIGA !!!
Write-Host $NumberOfLines
# ATTENZIONE: ELIMINARE QUESTA RIGA !!!
$LN = 1
# ATTENZIONE: ELIMINARE QUESTA RIGA !!!
$LineContent = ExtractLine $ChoseFile $LN
# ATTENZIONE: ELIMINARE QUESTA RIGA !!!
Write-Host $LineContent

# Set in variable the value of the extension for icon file.
Set-Variable -Option Constant -Scope Global -Name "IconExt" -Value "ico" -Description "Here is stored the string for icon ext"
# ATTENZIONE: ELIMINARE QUESTA RIGA !!!
Write-Host (Get-OperationDate)

Function Set-FileAttribute {
<#
	.SYNOPSIS
		Sets the attribute of a file

		ALIAS
			File-Setattr
		
	.DESCRIPTION
		This function sets the attributes of a file
	
	.PARAMETER Path
		The path to the file.
		
	.PARAMETER Attribute
		The attribute to set (or unset)
		
	.PARAMETER Unset
		Switch that specifies to unset the attribute
	
	.EXAMPLE	
		Set-FileAttribute 'c:\temp\temp.txt' 'Hidden'

	.EXAMPLE	
		Set-FileAttribute 'c:\temp\temp.txt' 'Hidden' -unset
		
	.EXAMPLE
		Set-FileAttribute -Path 'c:\temp\temp.txt' -Attribute 'Hidden'
	
	.EXAMPLE
		Set-FileAttribute -Path 'c:\temp\temp.txt' -Attribute 'Hidden' -unset
	
	.EXAMPLE
		'c:\temp\temp.txt' | Set-FileAttribute -Attribute 'Hidden'
		
	.INPUTS
		Path as String, Attribute as ValidatedString, Unset as Switch
#>
	[Alias("File-Setattr")]
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory,
			ValueFromPipeline)]
		[string]$Path,
		[Parameter(Mandatory)]
		[ValidateSet('Archive', 'Compressed', 'Device', 'Directory',
		'Encrypted', 'Hidden', 'IntegrityStream', 'None', 'Normal', 
		'NoScrubData', 'NotContentIndexed', 'Offline', 'ReadOnly', 
		'ReparsePoint', 'SparseFile', 'System', 'Temporary')]
		[string[]]$Attribute,
		[switch]$Unset
	)
		
	if ($Unset) {
		$Path = (Get-ChildItem $Path -force)
		$Path.Attributes = $Path.Attributes -bxor ([System.IO.FileAttributes]$Attributes).value__	
	}
	else {
		$Path = (Get-ChildItem $Path -force)
		$Path.Attributes = $Path.Attributes -bor ([System.IO.FileAttributes]$Attributes).value__	
	}
}







