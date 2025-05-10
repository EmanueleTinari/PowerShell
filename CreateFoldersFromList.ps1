Function ModelloFunzione_Inserire_qui_il_nome {

	<#PSScriptInfo

		.Version 1.0.0.0

		.GUID e1bc1683-62a3-4eab-8139-6d8fe9835727

		.Description Script to create folders from a list in text file.

		.Author Emanuele Tinari

		.CompanyName None

		.Copyright Emanuele Tinari

		.Tags PowerShell, Utilities

		.LicenseURI https://github.com/EmanueleTinari/PowerShell/blob/main/LICENSE.md

		.ProjectURI https://github.com/EmanueleTinari/PowerShell/blob/main/CreateFoldersFromList.ps1

		.IconURI 

		.ExternalModuleDependencies None

		.RequiredScripts None

		.RequiredModules None

		.ExternalScriptDependencies None

		.ReleaseNotes Initial release.


	#>

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

	Try {
		# [ITA] Nella variabile viene inserita data ed ora del momento in cui viene eseguita la funzione, nel formato: Giorno a 2 cifre, trattino, Mese a 2 cifre, trattino, Anno a 4 cifre, spazio, Ora a 2 cifre, trattino, Minuti a 2 cifre, trattino, Secondi a 2 cifre, punto, Millisecondi a 4 cifre
		# [ENG] In var is inserted date at the moment of script runs, in the format specified.
		$DataLoc = Get-Date -Format "dd-MM-yyyy HH:mm:ss.ffff"
		# [ITA] Nella variabile è inserita la differenza in ore tra il tempo locale e l'UTC.
		# [ENG] In var is inserted the difference from Local time and UTC.
		$DiffOre = Get-Date -UFormat "%Z"
		# [ITA] Nella variabile viene inserita data ed ora nel tempo UTC del momento in cui viene eseguita la funzione, nel formato: Giorno a 2 cifre, trattino, Mese a 2 cifre, trattino, Anno a 4 cifre, spazio, Ora a 2 cifre, trattino, Minuti a 2 cifre, trattino, Secondi a 2 cifre, punto, Millisecondi a 4 cifre e la sigla UTC.
		# [ENG] In var is inserted UTC date at the moment of script runs, in the format specified.
		$DataUtc = (Get-Date).ToUniversalTime().ToString("dd-MM-yyyy HH:mm:ss.ffff UTC")
		# [ITA] La Function restituisce, formattata, una stringa contenente i valori delle tre variabili precedenti.
		# [ENG] Function return a formatted string with 3 variables values.
		Return ( "{[" + $DataLoc + "](" + $DiffOre + ")[" + $DataUtc + "]} -> " )
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Get-OperationDate'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
}





Function Get-PowerShellVersion {
	<#
		.SYNOPSIS
			[ITA] Restituisce la versione di PowerShell.
			[ENG] Returns PowerShell version.

		.DESCRIPTION
			[ITA] Questa funzione restituisce la versione di PowerShell nel sistema in uso.
			[ENG] This function returns PowerShell version.

		.EXAMPLE
			If (Get-PowerShellVersion -ge 7)
				{
					# do something
				}
			Else
				{
					# do other thing
				}
	#>

	Try {
		Return ($PSVersionTable.PSVersion.Major)
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Get-PowerShellVersion'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
}





Function Get-UISysLang {
	<#
		.SYNOPSIS
			[ITA] Restituisce la sigla della lingua d'interfaccia di sistema.
			[ENG] Returns the system UI language, in format xx-XX.

		.DESCRIPTION
			[ITA] Questa funzione restituisce la sigla della lingua attuale dell'interfaccia del sistema, nel formato xx-XX.
			[ENG] This function returns the actual system UI language, a.k.a. Windows display language, in format xx-XX.

		.EXAMPLE
			$UILang = Get-UISysLang
	#>

	Try {
		Return ((Get-UICulture).Name)
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Get-UISysLang'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
}






Function Get-UISysLangLCID {
	<#
		.SYNOPSIS
			[ITA] Restituisce il LCID della lingua d'interfaccia di sistema.
			[ENG] Returns the system UI language LCID.

		.DESCRIPTION
			[ITA] Questa funzione restituisce il codice numerico LCID della lingua attuale dell'interfaccia del sistema.
			[ENG] This function returns the actual UI system language as LCID code.

		.EXAMPLE
			$UILangLCID =  Get-UISysLangLCID
	#>

	Try {
		Return ((Get-UICulture).LCID)
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Get-UISysLangLCID'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
}





Function Get-SysLang {
	<#
		.SYNOPSIS
			[ITA] Restituisce la sigla delle impostazioni di cultura correnti impostate nel sistema operativo.
			[ENG] Returns the current culture set in the operating system, in format xx-XX.

		.DESCRIPTION
			[ITA] Questa funzione restituisce la sigla delle impostazioni di cultura correnti impostate nel sistema operativo (comprese le formattazioni di valuta ed ora), nel formato xx-XX.
			[ENG] This function returns the actual system language, a.k.a Regional format (locale), in format xx-XX.

		.EXAMPLE
			$sysLang = Get-SysLang
	#>

	Try {
		Return ((Get-Culture).Name)
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Get-SysLang'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
}





Function Get-SysLangLCID {
	<#
		.SYNOPSIS
			[ITA] Restituisce il LCID delle impostazioni di cultura correnti impostate nel sistema operativo.
			[ENG] Returns the current culture LCID set in the operating system.

		.DESCRIPTION
			[ITA] Questa funzione restituisce il codice numerico LCID delle impostazioni di cultura correnti impostate nel sistema operativo (comprese le formattazioni di valuta ed ora).
			[ENG] This function returns the actual system language, a.k.a Regional format (locale) as LCID code.

		.EXAMPLE
			$sysLangLCID = Get-SysLangLCID
	#>

	Try {
		Return ((Get-Culture).LCID)
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Get-SysLangLCID'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
}





Function Get-SysLoc {
	<#
		.SYNOPSIS
			[ITA] Restituisce la sigla delle impostazioni locali correnti impostate nel sistema operativo.
			[ENG] Returns the System-locale setting for the current computer, in format xx-XX.

		.DESCRIPTION
			[ITA] Questa funzione restituisce la sigla, nel formato xx-XX, delle impostazioni per il computer corrente.
			[ENG] This function returns the name of the System-locale setting for the current computer, in format xx-XX.

		.EXAMPLE
			$sysLoc = Get-SysLoc
	#>

	Try {
		Return ((Get-WinSystemLocale).Name)
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Get-SysLoc'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
}





Function Get-SysLocLCID {
	<#
		.SYNOPSIS
			[ITA] Restituisce il LCID delle impostazioni locali correnti impostate nel sistema operativo.
			[ENG] Returns the System-locale setting LCID for the current computer.

		.DESCRIPTION
			[ITA] Questa funzione restituisce il codice numerico LCID delle impostazioni locali correnti impostate nel sistema operativo.
			[ENG] This function returns the actual System-locale setting for the current computer as LCID code.

		.EXAMPLE
			$sysLocLCID = Get-SysLocLCID
	#>

	Try {
		Return ((Get-WinSystemLocale).LCID)
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Get-SysLocLCID'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
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

	Try {
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

		# [ITA] Scrive un avviso sulla console di PowerShell per ricordare che la finestra di dialogo di scelta file potrebbe essere nascosta sotto altre finestre.
		# [ENG] Write a yellow warning on console, remembering new DialogForm may be hidden.
		Write-Host -ForegroundColor Yellow "* * * W A R N I N G : Dialog form may be hidden behind another window * * *"

		# [ITA] Apre la finestra di dialogo per la scelta del file.
		# [ENG] Open file dialog form.
		$FileBrowser.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost=$True; Name=$HelpText})) | Out-Null
		$FileBrowser.Dispose()

		# [ITA] La Function restituisce il nome del file scelto nella finestra di dialogo, completo del suo percorso ed estensione.
		# [ENG] Function return the name, complete with his path and extension, of the file choose with FileDialog.
		Return $FileBrowser.FileName
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Open-ShowFileDialog'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
}





Function CountLines {
	<#
		.SYNOPSIS
			[ITA] Conta il numero di linee in un file di testo.
			[ENG] Count number of lines in a text file.

		.DESCRIPTION
			[ITA] Questa Funzione conta il numero delle linee in un dato file di testo, completo del suo percorso completo (Primo parametro).
			[ENG] Function to count the number of lines in a text file (Parameter 0).

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
		[Parameter(
			Position=0,
			Mandatory=$True)]
		[String]$FilePath
	)

	Try {
		$NumberOfLines = [System.Linq.Enumerable]::Count([System.IO.File]::ReadLines( $FilePath ))
		# [ITA] La funzione restituisce la quantità di linee presenti in un file passato completo del suo percorso come primo parametro.
		# [ENG] Function return the number of lines in a given file, passed with his complete path as parameter.
		Return $NumberOfLines
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function CountLines'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
}





Function ExtractLine {
	<#
		.SYNOPSIS
			[ITA] Estrae da un file di testo la linea indicata.
			[ENG] Extract from a text file a passed line.

		.DESCRIPTION
			[ITA] Questa Funzione estrae una specifica linea (indicata da un numero, passato come secondo parametro) in un dato file di testo (passato come primo parametro, completo del suo percorso completo).
			[ENG] Function to extract the specified line (parameter 1) in a text file (parameter 0).

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

	Param (

		[Parameter(
			Position=0,
			Mandatory=$True)]
		[String]$FilePath,

		[Parameter(
			Position=1,
			Mandatory=$True)]
		[String]$LineNumber

	)

	Try {
		$LineContent = [Linq.Enumerable]::ElementAt(([System.IO.File]::ReadLines( $FilePath )), $LineNumber )
		# [ITA] La funzione restituisce una linea, da un file passato completo del suo percorso come primo parametro, alla linea indicata nel secondo parametro.
		# [ENG] Function return the line in a given file, passed with his complete path as parameter, at a indicated line number.
		Return $LineContent
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function ExtractLine'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
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
			[Parameter(
				Position=0,
				Mandatory=$True,
				ValueFromPipeline=$True)]
			[String] $FolderPath
		)

	Try {
		If ( Test-Path -Path $FolderPath ) {
			Return $True
		}	
		Else {
			Return $False
		}
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Test-FolderExist'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
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
			[Parameter(
				Position=0,
				Mandatory=$True,
				ValueFromPipeline=$True)]
			[String]$FilePath
		)

	Try {
		If ( Test-Path -Path $FilePath ) {
			Return $True
		}
		Else {
			Return $False
		}
	# End Try
	}
	Catch {
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"Error calling 'Function Test-FileExist'. Message: +
		$($_.Exception.Message)")
	# End Catch
	}
	# End Finally
	Finally {}
}





Function PrependToFile {									# ATTENZIONE!!! ANCORA DA COMPLETARE !!!
	<#
		.SYNOPSIS
			[ITA] Inserisce in un file una stringa.
			[ENG] Insert a string into a file.

		.DESCRIPTION
			[ITA] Questa funzione inserisce all'inizio di qualsiasi file di testo una stringa composta da una o più righe.
			[ENG] Function to insert at the beginning of a text file a string with one or more line of text.

		.PARAMETER File
			0 - [ITA] Obbligatorio. Il file in cui inserire la stringa.
			0 - [ENG] Mandatory. File where insert string.

		.PARAMETER Content
			1 - [ITA] Obbligatorio. La stringa di testo da inserire nel file.
			1 - [ENG] Mandatory. The content as string to insert.

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
			[Parameter(
				Position=0,
				ValueFromPipeline=$True,
				Mandatory=$True,
				ValueFromPipelineByPropertyName=$True)]
			[System.IO.FileInfo]$File,
			[Parameter(
				Position=1,
				ValueFromPipeline=$False,
				Mandatory=$True)]
			[String]$Content
		)

	Process
	{
		If ( !$File.Exists ) {
			$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
			"File: $File does not exist.")
			Return
		}

		$FilePath = $File.Fullname
		$tmpToken = (Get-Location).Path + "\_tmpFile" + $File.Name
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
		"$tmpToken created to as buffer.")
		Write-Verbose "$tmpToken created to as buffer."
		$tfs = [System.IO.File]::Create( $tmpToken )
		$fs = [System.IO.File]::Open( $File.Fullname,[System.IO.FileMode]::Open,[System.IO.FileAccess]::ReadWrite )

		Try {
			$msg = $Content.ToCharArray()
			$tfs.Write( $msg, 0, $msg.Length )
			$fs.Position=0
			$fs.CopyTo( $tfs )
		# End Try
		}

		Catch {
			$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
			"Error calling 'Function PrependToFile'. Message: +
			$($_.Exception.Message)")
		# End Catch
		}

		Finally {
			$tfs.Close()
			# Close calls dispose and GC.SuppressFinalize internally.
			$fs.Close()
			If ( $Error.Count -eq 0 ) {
				$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
				"Updating file $FilePath.")
				Write-Verbose ( "Updating file $FilePath" )
				[System.IO.File]::Delete( $FilePath )
				[System.IO.File]::Move( $tmpToken, $FilePath )
			}
			Else {
				$Error.Clear()
				$__0001_log_list.Insert(0, "" + $(Get-OperationDate) +
				"An error occurred, rolling back. File $FilePath not effected.")
				Write-Verbose ( "An error occurred, rolling back. $FilePath not effected." )
				[System.IO.File]::Delete( $tmpToken )
			}
		}
	}
}





Function Set-ini_File {										# ATTENZIONE!!! ANCORA DA COMPLETARE !!!
	<#
		.SYNOPSIS
			[ITA] Crea un nuovo file ini.
			[ENG] Create a new ini file.

		.DESCRIPTION
			[ITA] Crea un nuovo file ini per la cartella passata come parametro.
			[ENG] Create a new ini file for folder passed as parameter.

		.PARAMETER $ini_Dir
			0 - [ITA] Obbligatorio. Il percorso completo della cartella dove il file ini verrà creato.
			0 - [ENG] Mandatory. Complete path of folder where ini file'll be created.

		.PARAMETER $ini_Icon
			1 - [ITA] Il percorso completo dell'icona che verrà visualizzata sulla cartella.
			1 - [ENG] Complete path of icon file that'll be visualized on folder.

		.PARAMETER $ini_IconIndex
			2 - [ITA] L'indice dell'icona che verrà utilizzata in caso di una dll o di un exe, di default è 0.
			2 - [ENG] The icon index if ico is in dll or exe, 0 as default.

		.PARAMETER $ini_ConfirmFileOp
			3 - [ITA] .
			3 - [ENG] .

		.PARAMETER $ini_DropEffect
			4 - [ITA] .
			4 - [ENG] .

		.PARAMETER $ini_Tip
			5 - [ITA] .
			5 - [ENG] .

		.PARAMETER $ini_FolderType
			6 - [ITA] .
			6 - [ENG] .

		.EXAMPLE	
			

		.EXAMPLE	
			

		.INPUTS
			.

		.OUTPUTS
			.

	#>

	Param
		(
			[Parameter(
				Mandatory = $True,
				HelpMessage = "Directory to apply ini file.",
				Position = 0)]
			[String]$ini_Dir,

			[Parameter(
				Mandatory = $False,
				HelpMessage = "Icon file + ext, with complete path. '.\'Icon.ico ad default value.",
				Position = 1)]
			[String]$ini_Icon = ".\Icon.ico",						# Default

			[Parameter(
				Mandatory = $False,
				HelpMessage = "Icon index. '0' as default.",
				Position = 2)]
			[String]$ini_IconIndex	=	"0",						# Default

			[Parameter(
				Mandatory = $False,
				HelpMessage = "Confirm file operation. '0', no warning as default.",
				Position = 3)]
			[String]$ini_ConfirmFileOp	=	"0",					# Default

			[Parameter(
				Mandatory = $False,
				HelpMessage = "Default drop effect. 'Copy' as default.",
				Position = 4)]
			[String]$ini_DropEffect = "1",							# Default

			[Parameter(
				Mandatory = $False,
				HelpMessage = "Insert a tip for the folder. Empty string as default.",
				Position = 4)]
			[String]$ini_Tip = "",									# Default

			[Parameter(
				Mandatory = $False,
				HelpMessage = "Insert the folder type. 'Generic' as default.",
				Position = 4)]
			[String]$ini_FolderType = "Generic"						# Default

		)

	<# INI FOLDER TYPE:
		FROM Desktop.ini Documentation: https://hwiegman.home.xs4all.nl/desktopini.html

	FolderType = 	Documents
	MyDocuments
	Pictures
	MyPictures
	PhotoAlbum
	Music
	MyMusic
	MusicArtist
	MusicAlbum
	Videos
	MyVideos
	VideoAlbum
	UseLegacyHTT
	CommonDocuments
	Generic

		FROM: How to create desktop.ini in PowerShell?
		https://stackoverflow.com/questions/42005946/how-to-create-desktop-ini-in-powershell

		x la parte del drag and drop dell'INI file
		FROM: How to Change Default Drag and Drop Action in Windows
		https://www.tenforums.com/tutorials/38097-change-drag-drop-default-action-windows.html
	#>
$iniText = '
		[.ShellClassInfo]
		IconResource=D:\Remote\icons\folderBlue.ico,0
		IconIndex =  0
		ConfirmFileOp = 0
		DefaultDropEffect = 1
		[ViewState]
		Mode=
		Vid=
		FolderType=Generic
		'								### Empty line: Important !!!

Push-Location "$path"					### Push-Location (no Set-Location !!!)
#List all folder end with _S
$items = Get-ChildItem -Recurse | 
Where-Object {
($_.Attributes -match "Directory") -and ($_.Name.EndsWith("es"))} | 
Select-Object -ExpandProperty FullName				   ### ↑↑  change!!!

#For each folder _S ...
foreach ($item in $items)
{
Push-Location "$item"	  ### Push-Location instead of Set-Location

#Init. Delete desktop.ini if exist
try {
Remove-Item desktop.ini -Force -errorAction stop
}
catch {					### Write-Host "error removing $($item)"
}

#Write desktop.ini
Write-Host "Go to $($item)"
$iniText | Out-File desktop.ini -Force
Set-ItemProperty desktop.ini -Name Attributes -Value “ReadOnly,System,Hidden”
Pop-Location			   ### Pop-Location for corresponding Push-Location
attrib.exe +R +S "$item"   ### Follow DESKTOP.INI CUSTOMIZATIONS DO NOT …
}
Pop-Location				   ### Pop-Location for corresponding Push-Location
}


# call function declared above
Set-ini_File -ini_Dir "" -ini_Icon "" -ini_IconIndex "" -ini_ConfirmFileOp "" -ini_DropEffect "" -ini_Tip "" -ini_FolderType ""









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

# [ITA] Vengono di seguito impostate alcune operazioni che eseguirà inizialmente lo script.
# [ENG] Here are setting some starting operation of the script.
Remove-Variable -Include * -Name * -ErrorAction SilentlyContinue -Scope Global -Force
	# Lista delle variabili usate:
	#Remove-Variable -Name $__0001_log_list -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $__0004_L11 -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $__0005_L12 -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $__0006_L21 -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $__0007_L22 -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $__0008_L31 -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $__0009_L32 -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $__0000tmpVar -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $__0015_LineContent -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $ -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $ -ErrorAction SilentlyContinue -Scope Global -Force
	#Remove-Variable -Name $ -ErrorAction SilentlyContinue -Scope Global -Force

$Error.Clear()
$PSDefaultParameterValues=@{"Out-File:Width"="10000"}

# [ITA] Viene creata una nuova lista (tipo di Array) per contenere una serie di stringhe di log; Insert(0,"") pone la stringa per prima nella lista già creata.
# [ENG] Create a new list that will contains all log's strings; using Insert(0,""), set new one as first element: position 0.
Set-Variable -Scope Global -Name "__0001_log_list" -Description "Here are stored script's messages." -Value (New-Object 'System.Collections.Generic.List[String]')

# [ITA] Svuota la console usando il comando a seconda della versione di PowerShell in uso.
# [ENG] Clear the console, the used command depending of the version of PS in use.
If (Get-PowerShellVersion -ge 7)
	{
		[Console]::Clear()
	}
Else
	{
		Clear-Host
	}

# [ITA] Imposta nelle due costanti seguenti i valori per la lingua italiana.
# [ENG] Set in next 2 constants the italian values.
					# ATTENZIONE!!! DOPO LE PROVE ELIMINARE QUESTE 3 RIGHE E DE-COMMENTARE LA RIGA SEGUENTE!!!
					Set-Variable -Option Constant -Scope Global -Name "__0002_ItaLang" -Value "en-EN" -Description "Here is stored the string for Italian"
					# ATTENZIONE!!! DOPO LE PROVE ELIMINARE QUESTE 3 RIGHE E DE-COMMENTARE LA RIGA SEGUENTE!!!
					#Set-Variable -Option Constant -Scope Global -Name "__0002_ItaLang" -Value "it-IT" -Description "Here is stored the string for Italian"
Set-Variable -Option Constant -Scope Global -Name "__0003_ItaLCID" -Value "1040" -Description "Here is stored the LCID for Italian"

# [ITA] Imposta nelle sei variabili seguenti i valori estratti dal sistema.
# [ENG] Set in next 6 variables the values extract from the system.
Set-Variable -Scope Global -Name "__0004_L11" -Description "Here is stored the string for Italian" -Value (Get-UISysLang)
Set-Variable -Scope Global -Name "__0005_L12" -Description "Here is stored the string for Italian" -Value (Get-UISysLangLCID)
Set-Variable -Scope Global -Name "__0006_L21" -Description "Here is stored the string for Italian" -Value (Get-SysLang)
Set-Variable -Scope Global -Name "__0007_L22" -Description "Here is stored the string for Italian" -Value (Get-SysLangLCID)
Set-Variable -Scope Global -Name "__0008_L31" -Description "Here is stored the string for Italian" -Value (Get-SysLoc)
Set-Variable -Scope Global -Name "__0009_L32" -Description "Here is stored the string for Italian" -Value (Get-SysLocLCID)

# [ITA] Col successivo If viene impostato il linguaggio dello script.
# [ENG] If statement to compare values in the system to set the language of the script.
If ( $__0004_L11 -eq $__0002_ItaLang -And $__0006_L21 -eq $__0002_ItaLang -And $__0008_L31 -eq $__0002_ItaLang )
	{
		If ( $__0005_L12 -eq $__0003_ItaLCID -And $__0007_L22 -eq $__0003_ItaLCID -And $__0009_L32 -eq $__0003_ItaLCID )
			{
				# Italiano
				# [ITA] La lingua in uso nello script viene registrata nella lista di log.
				# [ENG] Script's language is registered in log_list.
				$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + "Imposto la lingua dello script su: Italiano")

				# ATTENZIONE!!! ALLA FINE ELIMINARE LA RIGA SEGUENTE!!!
				Write-Host "Imposto la lingua dello script su: Italiano"

				Set-Variable -Option Constant -Scope Global -Name "__0010_ScriptLan" -Description "Here is stored the value found for Italian" -Value "IT"
			}
	}
Else
	{
		# English
		# [ITA] La lingua in uso nello script viene registrata nella lista di log.
		# [ENG] Script's language is registered in log_list.
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + "Set script language on: English") 

				# ATTENZIONE!!! ALLA FINE ELIMINARE LA RIGA SEGUENTE!!!
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
Clear-Variable -name __0000tmpVar

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
$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + $__0014_fileName + " <-- File name + .ext") 

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

# [ITA] Imposta nella costante seguente il numero di righe presenti nel file usando la Funzione CountLines.
# [ENG] Set in next constant, using CountLines Function, the number of lines in the file.
Set-Variable -Option Constant -Scope Global -Name "__0017_NumberOfLines" -Description "Here is stored the number of lines in $__0012_ChosenFile" -Value (CountLines $__0012_ChosenFile)

# [ITA] Il numero di righe presenti nel file viene registrato nella lista di log.
# [ENG] File's number of lines is registered in log_list.
$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + $__0017_NumberOfLines + " <-- Number of lines (Folders to create)") 

# [ITA] Imposta nella costante seguente il valore dell'estensione per i file "ico".
# [ENG] Set in next constant the value of the extension for icon files.
Set-Variable -Option Constant -Scope Global -Name "__0018_IconExt" -Description "Here is stored the string for icon ext" -Value "ico"

# [ITA] Viene creata una variabile per contenere il valore della linea estratta dal file scelto.
# [ENG] Var is created to contain string value of line extract from choose file.
Set-Variable -Scope Global -Name "__0015_LineContent" -Description "Here is stored the line string" -Value ""

# [ITA] Ciclo per tutte le righe del file scelto.
# [ENG] Loop all lines in choose file.
For($__0000tmpVar = 0; $__0000tmpVar -lt $__0017_NumberOfLines; $__0000tmpVar++)
	{
		# [ITA] Inserisce nella variabile il valore della linea estratta nel ciclo di tutte le linee del file.
		# [ENG] Line string at line of $__0000tmpVar value is inserted into var.
		$__0015_LineContent = ExtractLine $__0012_ChosenFile ($__0000tmpVar)
		# [ITA] Il numero di linea in elaborazione e il suo valore viene registrato nella lista di log.
		# [ENG] Line number and its value is registered in log_list.
		$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + "Linea estratta n. " + (1 + $__0000tmpVar) + " [$__0000tmpVar] : $__0015_LineContent")
					# ATTENZIONE!!! ALLA FINE ELIMINARE LA RIGA SEGUENTE!!!
					Write-Host "Linea estratta n." (1 + $__0000tmpVar) "[$__0000tmpVar] : $__0015_LineContent"
		# [ITA] Controlla che una cartella col nome estratto non esista già nel percorso indicato.
		# [ENG] Check if a folder with the name extract exists or not in given path.
		If (Test-FolderExist ($__0013_filePath + $__0015_LineContent + "\"))
			{
				# [ITA] Il nome della cartella già esistente nel percorso viene registrato nella lista di log.
				# [ENG] Folder name already existent in given path is registered in log_list.
				$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + "Folder " + $__0013_filePath + $__0015_LineContent + " already exists. Go on with next line.")
						# ATTENZIONE!!! ALLA FINE ELIMINARE LA RIGA SEGUENTE!!!
						Write-Host ("La cartella " + $__0013_filePath + $__0015_LineContent + " esiste già! Proseguo con la riga successiva.")
				# [ITA] La variabile $__0015_LineContent viene azzerata.
				# [ENG] Empty $__0015_LineContent var.
				Clear-Variable -name __0015_LineContent
				# [ITA] Se esiste già, prosegue nel ciclo For col valore della line successiva.
				# [ENG] If folder exists, go on with next For loop line value.
				Continue
			}
		Else
			{
				# [ITA] La nuova cartella viene creata partendo dal percorso del file scelto.
				# [ENG] New folder is created from chosen file path.
				New-Item -Path ($__0013_filePath) -Name ($__0015_LineContent) -ItemType "Directory"
				# [ITA] Il nome della nuova cartella creata viene registrato nella lista di log.
				# [ENG] New folder name is registered in log_list.
				$__0001_log_list.Insert(0, "" + $(Get-OperationDate) + "Folder " + $__0013_filePath + $__0015_LineContent + " created!")
						# ATTENZIONE!!! ALLA FINE ELIMINARE LA RIGA SEGUENTE!!!
						Write-Host ("La cartella " + $__0013_filePath + $__0015_LineContent + " è stata creata!")
				# [ITA] La variabile $__0015_LineContent viene azzerata.
				# [ENG] Empty $__0015_LineContent var.
				Clear-Variable -name __0015_LineContent
			}
	}

		# [ITA] La variabile temporanea $__0000tmpVar viene azzerata.
		# [ENG] Empty temp Var $__0000tmpVar.
		Clear-Variable -name __0000tmpVar

Pause











#PERCORSO:
#D:\Documenti\Downloads\CAD\0
# [ITA] .
# [ENG] .


Function Set-FileAttribute {								# ATTENZIONE!!! ANCORA DA COMPLETARE !!!
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
		$Path.Attributes = $Path.Attributes -bXor ([System.IO.FileAttributes]$Attributes).value__	
	}
	else {
		$Path = (Get-ChildItem $Path -force)
		$Path.Attributes = $Path.Attributes -bor ([System.IO.FileAttributes]$Attributes).value__	
	}
}





Function Invoke-MsgBox {									# ATTENZIONE!!! ANCORA DA COMPLETARE !!!
	<#
		.SYNOPSIS
			[ITA] .
			[ENG] Display Windows message box.

		.DESCRIPTION
			[ITA] .
			[ENG] Display a Windows message box.

		.PARAMETER Title
			0 - [ITA] Titolo della MessageBox.
			0 - [ENG] Message box caption / title.

		.PARAMETER Message
			1 - [ITA] Testo da mostrare nella MessageBox.
			1 - [ENG] Text to display in the message box.

		.PARAMETER Buttons
			1 - [ITA] .
			1 - [ENG] Ok, OkCancel, YesNo, YesNoCancel. Default is Ok.

		.PARAMETER Icon
			1 - [ITA] .
			1 - [ENG] Error, Exclamation, Information, Question, Warning, None. Default is Information.

		.EXAMPLE	
			$tit = "Confirmation Title"
			$mess = "Confirmation Msg"
			Show-ConfirmationBox $tit $mess
			CONTROLLARE LA RIGA SEGUENTE!!!
$choice = Invoke-MsgBox -Message "Proceed?" -Title "Update Records" -ButtonType YesNo -Icon Question
		.EXAMPLE	
			

		.INPUTS
			.

		.OUTPUTS
			.
	#>

	[CmdletBinding(PositionalBinding=$False)]

	Param
		(
			[Parameter(
				Mandatory = $False,
				HelpMessage = "Title (caption) text for the MessageBox",
				Position = 0)]
			[String]$Title = "This is the title of the MessageBox",					# Default

			[Parameter(
				Mandatory = $False,
				HelpMessage = "Message text for the MessageBox",
				Position = 1)]
			[String]$Message = "This is the text of the MessageBox.",				# Default

			[Parameter(
				Mandatory = $False,
				HelpMessage = "Button for the MessageBox",
				Position = 2)]
			[ValidateSet(
				'OK',
				'OKCancel',
				'YesNo',
				'YesNoCancel',
				'AbortRetryIgnore',
				'RetryCancel')]
			[String]$Buttons = 'YesNo',												# Default

			[Parameter(
				Mandatory = $False,
				HelpMessage = "MessageBox icon",
				Position = 3)]
			[ValidateSet(
				'Asterisk',
				'Error',
				'Exclamation',
				'Hand',
				'Information',
				'Question',
				'Stop',
				'Warning',
				'None')]
			[String]$Icon = 'Information',											# Default

			[ValidateSet(0, 1, 2)]
			[Int] $DefaultButtonIndex

		)

	$buttonMap = @{ 
		'OK'			   = @{ buttonList = 'OK'; defaultButtonIndex = 0 }
		'OKCancel'		 = @{ buttonList = 'OK', 'Cancel'; defaultButtonIndex = 0; cancelButtonIndex = 1 }
		'AbortRetryIgnore' = @{ buttonList = 'Abort', 'Retry', 'Ignore'; defaultButtonIndex = 2; ; cancelButtonIndex = 0 }; 
		'YesNoCancel'	  = @{ buttonList = 'Yes', 'No', 'Cancel'; defaultButtonIndex = 2; cancelButtonIndex = 2 };
		'YesNo'			= @{ buttonList = 'Yes', 'No'; defaultButtonIndex = 0; cancelButtonIndex = 1 }
		'RetryCancel'	  = @{ buttonList = 'Retry', 'Cancel'; defaultButtonIndex = 0; cancelButtonIndex = 1 }
		}

	Try
		{
			If ($PSVersionTable.Platform -eq 'Unix')
				{
					Throw "Not supported on Linux systems"
				}
			If ($IsLinux)
				{ 
					Throw "Not supported on Linux." 
				}
			If ($IsMacOS)
				{ 
					Throw "Not supported on MacOS." 
				}

			$numButtons = $buttonMap[$Buttons].buttonList.Count
			$defaultIndex = [math]::Min($numButtons - 1, ($buttonMap[$Buttons].defaultButtonIndex, $DefaultButtonIndex)[$PSBoundParameters.ContainsKey('DefaultButtonIndex')])
			Add-Type -Assembly System.Windows.Forms		
			# Show the dialog.
			# Output the chosen button as a stringified [System.Windows.Forms.DialogResult] enum value
			[System.Windows.Forms.MessageBox]::Show($Message, $Title, $Buttons, $Icon, $defaultIndex * 256).ToString()
			#Add-Type -AssemblyName PresentationCore, PresentationFramework
			#$Result = [System.Windows.MessageBox]::Show($Message, $Title, $ButtonType, $Icon)
			$Result
		}
	Catch
		{
			Write-Error $_.Exception.Message
		}
}

$choice = Invoke-MsgBox -Title "Titolo: Attenzione!" -Message "Messaggio: Procedo?" -Buttons YesNo -Icon Question -DefaultButtonIndex 2
Write-Host $choice


# ATTENZIONE!!! Controllare la parte successiva
<#
Try
{
	$computers = Get-Content computers.txt -ErrorAction Stop
}
Catch
{
	"There was a problem opening the file; message: $($_.Exception.Message)" | Out-File -FilePath 'error.log' -Append
}
Finally
{
	Write-Host 'Tried to read computers file'
}


$computers = Get-ADComputer -SearchBase (Get-ADOrganizationalUnit -Filter {Name -eq 'Servers'} ) -Filter * | Select-Object -ExpandProperty Name
Measure-Command {
	Get-WmiObject Win32_ComputerSystem -ComputerName $computers -ErrorAction ignore
}
Measure-Command {
	Get-CimInstance Win32_ComputerSystem -ComputerName $computers -ErrorAction ignore
}

#>


