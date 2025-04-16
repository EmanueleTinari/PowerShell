Function ModelloXFunzione_Inserire_qui_il_nome {
	<#
		.SYNOPSIS
			[ITA] .
			[ENG] .

		.DESCRIPTION
			[ITA] .
			[ENG] .

		.PARAMETER Nome parametro 0
			0 - [ITA] .
			0 - [ENG] .

		.PARAMETER Nome parametro 1
			1 - [ITA] .
			1 - [ENG] .

		.EXAMPLE	
			

		.EXAMPLE	
			

		.INPUTS
			.

		.OUTPUTS
			.
	#>

	Param
		(
			# [Parameter(Position="X", Mandatory=$False)] [String] $xxx_Xxxx = ""	# Default
		)
}




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
			$myDate = (Get-OperationDate)

		.EXAMPLE	
			Write-Host $myDate = (Get-OperationDate)
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

		.PARAMETER $ofd_InitialDir
			0 - [ITA] Opzionale. Cartella iniziale, di default è Questo PC.
			0 - [ENG] Optional. Initial Dir, This PC as default.

		.PARAMETER $ofd_Title
			1 - [ITA] Opzionale. Titolo della finestra di dialogo, di default è "Select a file".
			1 - [ENG] Optional. FileDialog windows title, "Select a file" as default.

		.PARAMETER $ofd_Filter
			2 - [ITA] Opzionale. Filtro file, di default è Tutti i file (*.*).
			2 - [ENG] Optional. File filter, All files (*.*) as default.

		.PARAMETER $ofd_FilterIndex
			3 - [ITA] Opzionale. Indice del filtro file, di default è 1, cioè il primo elemento nella lista filtro.
			3 - [ENG] Optional. Filter Index, 1, first element in filter list, as default.

		.PARAMETER $ofd_Multiselect
			4 - [ITA] Opzionale. Multiselect, di default è False, un solo file selezionabile.
			4 - [ENG] Optional. Multiselect, False (only one file you can select) as default.

		.EXAMPLE	
			Open-ShowFileDialog -ofd_InitialDir ("C:\")

		.EXAMPLE
			Open-ShowFileDialog -ofd_Filter ("Text files (*.txt)|*.txt|All files (*.*)|*.*")
			Open-ShowFileDialog -ofd_Filter ("Documents (*.docx)|*.docx|SpreadSheet (*.xlsx)|*.xlsx|*.txt|All files (*.*)|*.*")

		.EXAMPLE	
			Open-ShowFileDialog -ofd_FilterIndex = "2"

		.EXAMPLE	
			Open-ShowFileDialog -ofd_Multiselect ("True")

		.EXAMPLE	
			Open-ShowFileDialog -ofd_Title ("This is my title for the OpenDialog")

		.EXAMPLE	
		Open-ShowFileDialog -ofd_Filter ("Text files (*.txt)|*.txt|All files (*.*)|*.*") -ofd_Title ("This is my title for the OpenDialog")
	#>

	[CmdletBinding()]

	[OutputType([String])]

	Param
		(
			[Parameter(
				Mandatory = $False,
				ValueFromPipelineByPropertyName = $True,
				HelpMessage = "Initial Directory for browsing",
				Position = 0)]
			[String]$ofd_InitialDir = "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}",	# Default

			[Parameter(
				Mandatory = $False,
				ValueFromPipelineByPropertyName = $True,
				HelpMessage = "Message Box Title",
				Position = 1)]
			[String]$ofd_Title = "Select a file",									# Default

			[Parameter(
				Mandatory = $False,
				ValueFromPipelineByPropertyName = $True,
				HelpMessage = "Filter to apply",
				Position = 2)]
			[String]$ofd_Filter	=	"All files (*.*)|*.*",							# Default

			[Parameter(
				Mandatory = $False,
				ValueFromPipelineByPropertyName = $True,
				HelpMessage = "Index of filter to apply",
				Position = 3)]
			[String]$ofd_FilterIndex	=	1,										# Default

			[Parameter(
				Mandatory = $False,
				ValueFromPipelineByPropertyName = $True,
				HelpMessage = "Allow multi files selection",
				Position = 4)]
			[Switch]$ofd_Multiselect = $False										# Default
		)

	# Load Assembly
	Add-Type -AssemblyName System.Windows.Forms
	# Open Class
	$FileBrowser = New-Object -TypeName System.Windows.Forms.OpenFileDialog
	# [ITA] Apre una finestra di tipo FileDialog per scegliere un file posizionandosi all'apertura (se non viene passato alcun dato al parametro $ofd_InitialDir) su: Questo PC.
	# [ENG] Open the FileDialog on This PC (or MyComputer) if no string is passed by $ofd_InitialDir parameter.
	If (-Not [String]::IsNullOrWhiteSpace($ofd_InitialDir))
		{
			$FileBrowser.InitialDirectory = $ofd_InitialDir
		}
	# [ITA] Qui viene impostato il filtro dei file, se non viene passata alcuna stringa al parametro $ofd_Filter, sarà Tutti i file.
	# [ENG] Here you can set Filter. If no string is passed by $ofd_Filter parameter, is set on: All files.
	$FileBrowser.Filter = $ofd_Filter
	# [ITA] Qui viene impostato l'indice del filtro selezionato; se non viene passata alcuna valore al parametro $ofd_FilterIndex, sarà 1, il primo nel menù a discesa del filtro.
	# [ENG] Here you can set Filter index. If no value is passed by $ofd_FilterIndex parameter, is set on: 1 (First in list).
	$FileBrowser.FilterIndex = $ofd_FilterIndex
	# [ITA] Controlla che il file scelto esista.
	# [ENG] Check if file exists.
	$FileBrowser.CheckFileExists = $True
	# [ITA] Qui viene impostato se la finestra di dialogo permette o meno la selezione di più file, di default è no (False).
	# [ENG] Here you can set if you can or not multiselect files, default is not (False).
	If ($ofd_Multiselect)
		{
			$FileBrowser.Multiselect = $True
		}
	# [ITA] Qui viene settato il Titolo della finestra di dialogo, il cui valore di default è: Select a file (Seleziona un file).
	# [ENG] This is for the Title of the form, default value is: Select a file.
	$FileBrowser.Title = $ofd_Title
	

	# Without this line the ShowDialog() function may hang depending on system configuration and running from console vs. ISE.
#$FileBrowser.ShowHelp = $True
	
	# [ITA] Scrive un avviso sulla console di PowerShell per ricordare che la finestra di dialogo di scelta file potrebbe essere nascosta sotto altre finestre.
	# [ENG] Write a yellow warning on console, remembering new DialogForm may be hidden.
	Write-Host -ForegroundColor Yellow "* * * W A R N I N G : Dialog form may be hidden behind another window * * *"
	$FileBrowser.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost=$True; Name=$HelpText})) | Out-Null
	$FileBrowser.Dispose()
	# [ITA] La Function restituisce il nome del file scelto nella finestra di dialogo, completo del suo percorso ed estensione.
	# [ENG] Function return the name, complete with his path and extension, of the file choose with FileDialog.
	Return $FileBrowser.FileName
}





Function CountLines {			
	<#
		.SYNOPSIS
			[ITA] Conta il numero di linee in un file di testo.
			[ENG] Count number of lines in a text file.

		.DESCRIPTION
			[ITA] Questa Funzione conta il numero delle linee in un dato file di testo, completo del suo percorso completo.
			[ENG] Function to count the number of lines in a text file.

		.PARAMETER FilePath
			0 - [ITA] Obbligatorio. Nome file compreso del suo percorso completo.
			0 - [ENG] Mandatory. File name with its complete path.

		.EXAMPLE	
			$File = "C:\Test.txt"
			$NumberOfLines = CountLines $File

		.INPUTS
			[ITA] Un file, di cui contare le linee, esistente, e col suo percorso completo.
			[ENG] A file with its complete path.

		.OUTPUTS
			[ITA] Il numero di righe del file in una stringa di testo.
			[ENG] A string with the number of lines inside.
	#>

	[CmdletBinding()]

	Param
	(
		[Parameter(Position=0, Mandatory=$True)] [String] $FilePath
	)

	$NumberOfLines = [System.Linq.Enumerable]::Count([System.IO.File]::ReadLines( $FilePath ))
	# Function return the number of lines in a given file, passed with his complete path as parameter.
	Return $NumberOfLines
}





Function ExtractLine {
	<#
		.SYNOPSIS
			[ITA] Estrae da un file di testo una certa linea indicata nel parametro n. 2.
			[ENG] .

		.DESCRIPTION
			[ITA] Questa Funzione estrae una specifica linea (indicata da un numero) in un dato file di testo.
			[ENG] Function to extract the specified line in a text file.

		.PARAMETER FilePath
			0 - [ITA] Obbligatorio. Nome file compreso del suo percorso completo.
			0 - [ENG] Mandatory. File name with its complete path.

		.PARAMETER LineNumber
			1 - [ITA] Obbligatorio. Numero della linea da estrarre.
			1 - [ENG] Mandatory. Line number to extract.

		.EXAMPLE	
			$myLine = ExtractLine "C:\Text.txt" "4".

		.INPUTS
			0 - [ITA] Un file, di cui contare le linee, esistente, e col suo percorso completo.
			0 - [ENG] A file with its complete path.
			1 - [ITA] Il numero di linea il cui testo si vuole estrarre.
			1 - [ENG] The line number.

		.OUTPUTS
			[ITA] Una stringa contenente il testo della linea estratta.
			[ENG] A string with the text of line.
	#>

	[CmdletBinding()]

	Param
	(
		[Parameter(Position="0", Mandatory=$True)] [String] $FilePath,
		[Parameter(Position="1", Mandatory=$True)] [String] $LineNumber
	)

	$LineContent = [Linq.Enumerable]::ElementAt(([System.IO.File]::ReadLines( $FilePath )), $LineNumber )
	# Function return the line in a given file, passed with his complete path as parameter, at a indicated line number
	Return $LineContent
}





Function Test-FolderExist {
	<#
		.SYNOPSIS
			[ITA] Testa l'esistenza di una cartella.
			[ENG] Test for the existence of a folder.

			ALIAS
				Folder

		.DESCRIPTION
			[ITA] Questa funzione controlla che una certa cartella esista in un determinato percorso.
			[ENG] Function to check if a given folder exist in a given path.

		.PARAMETER FolderPath
			0 - [ITA] Obbligatorio. Il percorso della cartella.
			0 - [ENG] Mandatory. The path to the folder.

		.EXAMPLE	
			$folderExists = Test-FolderExist 'C:\temp\'

		.EXAMPLE	
			$folderExists = Test-FolderExist -FolderPath 'C:\temp\'

		.EXAMPLE	
			$folderExists = 'C:\temp\' | Test-FolderExist

		.INPUTS
			0 - [ITA] Il percorso della cartella.
			0 - [ENG] Path as String.

		.OUTPUTS
			[ITA] Booleano: La cartella esiste ($True) o non esiste ($False).
			[ENG] Boolean.
	#>

	[Alias("Folder")]

	[CmdletBinding()]

	Param
		(
			[Parameter(Position="0", Mandatory=$True, ValueFromPipeline=$True)] [String] $FolderPath
		)

	If ( Test-Path -Path $FolderPath )
		{
			Return $True
		}	
	Else
		{
			Return $False
		}
}





Function Test-FileExist {
	<#
		.SYNOPSIS
			[ITA] Testa l'esistenza di un file.
			[ENG] Test for the existence of a file.

			ALIAS
				File

		.DESCRIPTION
			[ITA] Questa funzione controlla che un certo file esista in un determinato percorso.
			[ENG] Function to check if a given file exist in a given path.

		.PARAMETER FilePath
			0 - [ITA] Il percorso completo al file e il file stesso compreso di estensione.
			0 - [ENG] The complete path to the file and his name and extension.

		.EXAMPLE	
			$fileExists = Test-FileExist 'c:\temp\temp.txt'

		.EXAMPLE	
			$fileExists = Test-FileExist -Path 'c:\temp\temp.txt'

		.EXAMPLE	
			$fileExists = 'c:\temp\temp.txt' | Test-FileExist

		.INPUTS
			0 - [ITA] Il percorso del file.
			0 - [ENG] Path as String.

		.OUTPUTS
			[ITA] Booleano: Il file esiste ($True) o non esiste ($False).
			[ENG] Boolean.
	#>

	[Alias("File")]

	[CmdletBinding()]

	Param
		(
			[Parameter(Position="0", Mandatory=$True, ValueFromPipeline=$True)] [String] $FilePath
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





Function PrependToFile { # ATTENZIONE!!! ANCORA DA COMPLETARE !!!
	<#
		.SYNOPSIS
			[ITA] .
			[ENG] .

		.DESCRIPTION
			[ITA] Questa funzione inserisce all'inizio di qualsiasi file di testo una stringa composta da una o più righe.
			[ENG] Function to insert at the beginning of a text file a string with one or more line of text.

		.PARAMETER Path
			0 - [ITA] .
			0 - [ENG] .

		.EXAMPLE	
			get-item fileName.ext | PrependTo-File "contentToAdd`r`n"

		.INPUTS
			.

		.OUTPUTS
			.
	#>

	[CmdletBinding()]

	Param
		(
			[Parameter(Position=0, ValueFromPipeline=$True, Mandatory=$True, ValueFromPipelineByPropertyName=$True)] [System.IO.FileInfo] $File,
			[Parameter(Position=1, ValueFromPipeline=$False, Mandatory=$True)] [String] $Content
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
				$fs.Position=0
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






					# ATTENZIONE: ELIMINARE QUESTO BLOCCO !!!
					# La seguente variabile serve solo per muoversi velocemente nel menù a discesa delle Funzioni e Variabili in VS Code e per arrivare al volo dal blocco delle Funzioni a quello dello Script.
						$xxxMain = ""
						Write-Host $xxxMain
					# [ITA] .
					# [ENG] .
					# Modello x COSTANTI:
					# Set-Variable -Option Constant -Scope Global -Name "" -Description "" -Value ""
					# Modello x VARIABILI:
					# Set-Variable -Scope Global -Name "__00XX_" -Description "" -Value ""
					# ATTENZIONE: ELIMINARE QUESTO BLOCCO !!!

						########
						# Main #
						########

Remove-Variable * -ErrorAction SilentlyContinue -Scope Global -Force; Remove-Module *; $Error.Clear();
# [ITA] Vengono di seguito impostate alcune operazioni che eseguirà inizialmente lo script.
# [ENG] Here are setting some starting operation of the script.
$PSDefaultParameterValues['Out-File:Width'] = 2000

# [ITA] Viene creata una nuova lista (tipo di Array) per contenere una serie di stringhe di log; Insert(0,"") pone la stringa per prima nella lista già creata.
# [ENG] Create a new list that will contains all log's strings; using Insert(0,""), set new one as first element: position 0.
Set-Variable -Scope Global -Name "__0001_log_list" -Description "" -Value (New-Object 'System.Collections.Generic.List[String]')

# [ITA] Svuota la console.
# [ENG] Clear the console.
Clear-Host


# [ITA] Imposta nelle due costanti seguenti i valori per la lingua italiana.
# [ENG] Set in next 2 constants the italian values.
					# ATTENZIONE: CAMBIARE DOPO LE PROVE ED ELIMINARE QUESTA RIGA DI COMMENTO!!!
Set-Variable -Option Constant -Scope Global -Name "__0002_ItaLang" -Value "en-EN" -Description "Here is stored the string for Italian"
Set-Variable -Option Constant -Scope Global -Name "__0003_ItaLCID" -Value "1040" -Description "Here is stored the LCID for Italian"


# [ITA] Imposta nelle sei variabili seguenti i valori estratti dal sistema.
# [ENG] Set in next 6 variables the values extract from the system.
Set-Variable -Scope Global -Name "__0004_L11" -Description "Here is stored the string for Italian" -Value (ExtractUISysLang)
Set-Variable -Scope Global -Name "__0005_L12" -Description "Here is stored the string for Italian" -Value (ExtractUISysLangLCID)
Set-Variable -Scope Global -Name "__0006_L21" -Description "Here is stored the string for Italian" -Value (ExtractSysLang)
Set-Variable -Scope Global -Name "__0007_L22" -Description "Here is stored the string for Italian" -Value (ExtractSysLangLCID)
Set-Variable -Scope Global -Name "__0008_L31" -Description "Here is stored the string for Italian" -Value (ExtractSysLoc)
Set-Variable -Scope Global -Name "__0009_L32" -Description "Here is stored the string for Italian" -Value (ExtractSysLocLCID)

# [ITA] Col successivo If viene impostato il linguaggio dello script.
# [ENG] If statement to compare values in the system to set the language of the script.
If ( $__0004_L11 -eq $__0002_ItaLang -And $__0006_L21 -eq $__0002_ItaLang -And $__0008_L31 -eq $__0002_ItaLang )
	{
		If ( $__0005_L12 -eq $__0003_ItaLCID -And $__0007_L22 -eq $__0003_ItaLCID -And $__0009_L32 -eq $__0003_ItaLCID )
			{
				# Italiano
				Write-Host "Imposto la lingua dello script su: Italiano"
				Set-Variable -Option Constant -Scope Global -Name "__0010_ScriptLan" -Description "Here is stored the value found for Italian" -Value "IT"
			}
	}
Else
	{
		# English
		Write-Host "Set script language on: English"
		Set-Variable -Option Constant -Scope Global -Name "__0010_ScriptLanguage" -Description "Here is stored the value found for English" -Value "EN"
	}

# [ITA] Col successivo If vengo caricati nell'Array dei dai dipendenti dal valore della variabile $__0010_ScriptLanguage.
# [ENG] If statement to load data in array depending by the $__0010_ScriptLanguage value.
If ( $__0010_ScriptLanguage -eq "IT" )
	{
		$__0011_Ita = @(
		[PSCustomObject]@{Num = '1'; Testo = "Seleziona il file contenente la lista di elementi di cui creare le cartelle"}
		[PSCustomObject]@{Num = '2'; Testo = "File di testo (*.txt)|*.txt|Tutti i file (*.*)|*.*"}
		[PSCustomObject]@{Num = '3'; Testo = ""}
		)
	}
Else
	{
		$__0011_Eng = @(
		[PSCustomObject]@{ Num = '1'; Text = "Select file with elements list to create folders"}
		[PSCustomObject]@{ Num = '2'; Text = "Text files (*.txt)|*.txt|All files (*.*)|*.*"}
		[PSCustomObject]@{ Num = '3'; Text = ""}
		)
	}

# [ITA] La lingua in uso nello script viene registrata nella lista di log.
# [ENG] Script's language is registered in log_list.
$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + $__0010_ScriptLanguage + " <-- Script Language") 

# [ITA] Viene creata una variabile temporanea per varie necessità.
# [ENG] Temp var.
Set-Variable -Scope Global -Name "__0000tmpVar" -Description "Temp variable" -Value ""

# [ITA] In base alla lingua rilevata, viene aperta una finestra di dialogo per la scelta del file; il file scelto viene quindi inserito nella variabile temporanea $__0000tmpVar.
# [ENG] Based on language detected, open a FileDialog to choose a file; its name is set into $__0000tmpVar variable.
$__0000tmpVar = If ( $__0010_ScriptLanguage -eq "IT" )
	{
		# [ITA] Qui viene settato il Titolo e il Filtro della finestra di dialogo.
		Open-ShowFileDialog -ofd_Title = $__0011_Ita[0].Testo -ofd_Filter = $__0011_Ita[1].Testo
	}
Else
	{
		# [ENG] Here we set Title and Filter of the FileDialog.
		Open-ShowFileDialog -ofd_Title $__0011_Eng[0].Text -ofd_Filter $__0011_Eng[1].Text
	}

# [ITA] Imposta nella costante seguente il valore della variabile temporanea $__0000tmpVar.
# [ENG] Set in next constant the value in $__0000tmpVar.
Set-Variable -Option Constant -Scope Global -Name "__0012_ChosenFile" -Description "Here is stored the name, extension and complete path of file choose" -Value ($__0000tmpVar)

# [ITA] La variabile temporanea $__0000tmpVar viene azzerata.
# [ENG] Empty temp Var $__0000tmpVar.
Clear-Variable $__0000tmpVar

# [ITA] Il nome del file completo di estensione e suo percorso viene registrato nella lista di log.
# [ENG] File name, extension and path is registered in log_list.
$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + $__0012_ChosenFile + " <-- File choose") 

# [ITA] Nell'oggetto viene posto il file scelto.
# [ENG] Set in $fileObject var choose file object.
$fileObject = Get-Item $__0012_ChosenFile

# [ITA] Imposta nella costante seguente il percorso completo al file più il backslash finale.
# [ENG] Set in next constant complete path to file + final backslash.
Set-Variable -Option Constant -Scope Global -Name "__0013_filePath" -Description "Path of file and final backslash" -Value ($fileObject.DirectoryName + "\")

# [ITA] Il percorso completo del file viene registrato nella lista di log.
# [ENG] File path is registered in log_list.
$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + $__0013_filePath + " <-- File path + final Backslash") 

# [ITA] Imposta nella costante seguente il nome del file compreso di estensione.
# [ENG] Set in next constant only the name of the file and its extension.
Set-Variable -Option Constant -Scope Global -Name "__0014_fileName" -Description "Name of the file with extension" -Value ($fileObject.Name)

# [ITA] Il nome del file + estensione vengono registrati nella lista di log.
# [ENG] File name and extension are registered in log_list.
$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + $__0014_fileName + " <-- File name") 

# [ITA] Imposta nella costante seguente il solo nome del file.
# [ENG] Set in next constant only the name of the file.
Set-Variable -Option Constant -Scope Global -Name "__0015_baseName" -Description "Only name of the file" -Value ($fileObject.BaseName)

# [ITA] Il solo nome del file viene registrato nella lista di log.
# [ENG] File name is registered in log_list.
$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + $__0015_baseName + " <-- File base name") 

# [ITA] Imposta nella costante seguente la sola estensione del file.
# [ENG] Set in next constant the extension of the file.
Set-Variable -Option Constant -Scope Global -Name "__0016_fileExtension" -Description "Extension of the file" -Value ($fileObject.Extension)

# [ITA] L'estensione del file esclusa del punto viene registrata nella lista di log.
# [ENG] File extension without dot is registered in log_list.
$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + ($__0016_fileExtension -replace "\.", "") + " <-- File extension") 

# [ITA] Imposta nella costante seguente il numero di righe presenti nel file.
# [ENG] Set in next constant the number of lines in the file.
Set-Variable -Option Constant -Scope Global -Name "__0017_NumberOfLines" -Description "Here is stored the number of lines in $__0012_ChosenFile" -Value (CountLines $__0012_ChosenFile)

# [ITA] Il numero di righe presenti nel file viene registrato nella lista di log.
# [ENG] File's number of lines is registered in log_list.
$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + $__0017_NumberOfLines + " <-- Number of lines") 

# [ITA] Imposta nella costante seguente il numero di righe presenti nel file.
# [ENG] Set in next constant the value of the extension for icon files.
Set-Variable -Option Constant -Scope Global -Name "__0018_IconExt" -Description "Here is stored the string for icon ext" -Value "ico"

# [ITA] Imposta nella variabile seguente il numero di righe presenti nel file.
# [ENG] Set in next variable the value of the extension for icon files.
Set-Variable -Option Constant -Scope Global -Name "__0018_IconExt" -Description "Here is stored the string for icon ext" -Value "ico"






# [ITA] Ciclo per tutte le righe del file scelto.
# [ENG] Loop all lines in choose file.
For($__0000tmpVar = 0; $__0000tmpVar -lt $__0017_NumberOfLines; $__0000tmpVar++)
	{
		$__0015_LineContent = ExtractLine $__0012_ChosenFile ($__0000tmpVar)
		Write-Host "Linea " ($__0000tmpVar) ": " ($__0015_LineContent)
	}

# [ITA] La variabile temporanea $__0000tmpVar viene azzerata.
# [ENG] Empty temp Var $__0000tmpVar.
Clear-Variable $__0000tmpVar




	
	
	








#PERCORSO:
#D:\Documenti\Downloads\CAD\0


Function Set-FileAttribute {
<#
	.SYNOPSIS
		Sets the attribute of a file

		ALIAS
			File-SetAttr
		
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
	[Alias("File-SetAttr")]
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory, ValueFromPipeline)] [String] $Path,
		[Parameter(Mandatory)] [ValidateSet('Archive', 'Compressed', 'Device', 'Directory',
		'Encrypted', 'Hidden', 'IntegrityStream', 'None', 'Normal', 
		'NoScrubData', 'NotContentIndexed', 'Offline', 'ReadOnly', 
		'ReparsePoint', 'SparseFile', 'System', 'Temporary')] [String[]] $Attribute,
		[Switch] $Unset
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


Function Show-Alert {
    param([Parameter(Mandatory = $true)] [string] $Message)
    Add-Type -AssemblyName PresentationFramework
    $result = [System.Windows.MessageBox]::Show($Message, "Prompt", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Warning, [System.Windows.MessageBoxResult]::OK, [System.Windows.MessageBoxOptions]::DefaultDesktopOnly)
    return $result;
}
function Show-ConfirmationBox {
    param(
        [Parameter(Mandatory = $true)][string] $Message,
        [Parameter(Mandatory = $true)][string] $Title
    )
    return [System.Windows.Forms.MessageBox]::Show($Message, $title, "YesNo", "Information", "Button1");
}

$A = "Messaggio di prova alert"
#$B = "Messaggio conferma"
#$C = "Titolo conferma"
Show-Alert $A
#Show-ConfirmationBox $B $C

function Invoke-MsgBox {
	<#
	.SYNOPSIS
		Display Windows message box
	.DESCRIPTION
		Display a Windows message box
	.PARAMETER Message
		Text to display in the message box
	.PARAMETER Title
		Message box caption / title
	.PARAMETER ButtonType
		Ok, OkCancel, YesNo, YesNoCancel. Default is Ok
	.PARAMETER Icon
		Error, Exclamation, Information, Question, Warning, None. Default is Information
	.EXAMPLE
		$choice = Invoke-MsgBox -Message "Proceed?" -Title "Update Records" -ButtonType YesNo -Icon Question
	.LINK
		https://github.com/Skatterbrainz/helium/blob/master/docs/Invoke-MsgBox.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$Message,
		[parameter(Mandatory)][string]$Title,
		[parameter()][string][ValidateSet('Ok','OkCancel','YesNo','YesNoCancel')]$ButtonType = 'Ok',
		[parameter()][string]
			[ValidateSet('Asterisk','Error','Exclamation','Hand','Information','Question','Stop','Warning','None')]$Icon = 'Information'
	)
	try {
		if ($PSVersionTable.Platform -eq 'Unix') { throw "Not supported on Linux systems" }
		Add-Type -AssemblyName PresentationCore, PresentationFramework
		$result = [System.Windows.MessageBox]::Show($Message, $Title, $ButtonType, $Icon)
		$result
	} catch {
		Write-Error $_.Exception.Message
	}
}

$choice = Invoke-MsgBox -Message "Proceed?" -Title "Update Records" -ButtonType YesNo -Icon Question
Write-Host $choice




