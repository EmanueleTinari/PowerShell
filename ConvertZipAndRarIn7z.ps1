					#=====================================================================#
					#																																			#
					#		Converte tutti i file RAR e tutti i file ZIP											#
					#		contenuti nella directory contenente lo script										#
					#		in file 7z (miglior compressione).																#
					#				Ver. 1.0.0	03/05/2020																				#
					#																																			#
					#=====================================================================#


							###########################################################
							#		[ITA] Svuota tutte le variabili create nello script.	#
							#		[ENG] Clear all variables built in this script.				#
							###########################################################

$NewVariables = Get-Variable | Select-Object -ExpandProperty Name | Where-Object {$ExistingVariables -notcontains $_ -and $_ -ne "ExistingVariables"}

If ($NewVariables) {

		If ((Get-Culture).LCID -eq 1040) {

			Clear-Variable $NewVariables
			$CorpoHtml = $CorpoHtml + "<br>Svuoto le seguenti variabili:`n`r`n$NewVariables."

		}

		ElseIf ((Get-Culture).LCID -ne 1040) {

			Clear-Variable $NewVariables
			$CorpoHtml = $CorpoHtml + "<br>Empty variables:`n`r`n$NewVariables."

		}
}

Else {

	If ((Get-Culture).LCID -eq 1040) {

		$CorpoHtml = $CorpoHtml + "<br>Nessuna nuova variabile da svuotare!"

	}

	ElseIf ((Get-Culture).LCID -ne 1040) {

		$CorpoHtml = $CorpoHtml + "<br>No new variable to clear!"

	}
}

																			#######################
																			#		[ITA] Funzioni.		#
																			#		[ENG] Functions.	#
																			#######################
						#----------------------------------------
						#		[ITA] Funzione CancellaCartella.		#
						#		[ENG] Function CancellaCartella.		#
						#----------------------------------------

# [ITA] Cancella una cartella e tutto il suo contenuto. 
# [ENG] Remove folder and its contents.
Function CancellaCartella {
	# [ITA] Come parametro viene passato il percorso completo della cartella da eliminare. 
	# [ENG] As parameter we pass the complete path of the folder to delete.
	Param($FullTmpDir)

	# [ITA] Con -Recurse eliminiamo la cartella anche se questa non è vuota. 
	# [ENG] With the param -Recurse, we delete the folder even If it's not empty.
	Remove-Item $FullTmpDir -Recurse
	
	If ((Get-Culture).LCID -eq 1040) {
		# [ITA] Invia il messaggio di cancellazione cartella al file di log.
		$CorpoHtml = $CorpoHtml + "<br>Cartella $FullTmpDir e suo relativo contenuto, eliminata."
	}
	ElseIf ((Get-Culture).LCID -ne 1040) {
		# [ENG] Send message of delete folder to file log.
		$CorpoHtml = $CorpoHtml + "<br>Folder $FullTmpDir and all its contents, deleted."
	}
}

						#--------------------------------------------
						#		[ITA] Funzione GestioneLastExitCode.		#
						#		[ENG] Function GestioneLastExitCode.		#
						#--------------------------------------------

# [ITA] Funzione per gestire la risposta dell'ultimo programma esterno eseguito, in questo caso, 7z.exe. 
# [ENG] Function to handle the last answer of the last external program runned, in this case, 7z.exe.
Function GestioneLastExitCode {
	# [ITA] Come parametro viene passata la variabile $LastExitCode. 
	# [ENG] As parameter we pass $LastExitCode variable.
	Param($LastExitCode)

	# [ITA] Gestione dell'ultimo codice d'uscita. 
	# [ENG] Handle of the last exit code.
	If ($LastExitCode -eq 0)
		{
		If ((Get-Culture).LCID -eq 1040) {
			$ExitCode = "Tutto bene, codice $LastExitCode. Nessun errore."
		}
		ElseIf ((Get-Culture).LCID -ne 1040) {
			$ExitCode = "Ok. Code $LastExitCode. No error."
		}
	}
	ElseIf ($LastExitCode -eq 1) {
		If ((Get-Culture).LCID -eq 1040) {
			$ExitCode = "Attenzione, codice $LastExitCode : Errore(i) non fatale(i).
						Per esempio, uno o più file sono bloccati da qualche altra applicazione, così non sono stati compressi."
		}
		ElseIf ((Get-Culture).LCID -ne 1040) {
			$ExitCode = "Warning (Non fatal error(s)). For example, one or more files were locked by some other
						application, so they were not compressed."
		}
	}
	ElseIf ($LastExitCode -eq 2) {
		If ((Get-Culture).LCID -eq 1040) {
			$ExitCode = "Attenzione, codice $LastExitCode : Errore fatale."
		}
		ElseIf ((Get-Culture).LCID -ne 1040) {
			$ExitCode = "Code $LastExitCode. Fatal error"
		}
	}
	ElseIf ($LastExitCode -eq 7) {
		If ((Get-Culture).LCID -eq 1040) {
			$ExitCode = "Attenzione, codice $LastExitCode : Errore della linea di comando."
		}
		ElseIf ((Get-Culture).LCID -ne 1040) {
			$ExitCode = "Code $LastExitCode. Command line error."
		}
	}
	ElseIf ($LastExitCode -eq 8) {
		If ((Get-Culture).LCID -eq 1040) {
			$ExitCode = "Attenzione, codice $LastExitCode : non c'è abbastanza memoria per compiere l'operazione."
		}
		ElseIf ((Get-Culture).LCID -ne 1040) {
			$ExitCode = "Code $LastExitCode. Not enough memory for operation."
		}
	}
	ElseIf ($LastExitCode -eq 255) {
		If ((Get-Culture).LCID -eq 1040) {
			$ExitCode = "Attenzione, codice $LastExitCode : l'utente ha terminato il processo prima del tempo."
		}
		ElseIf ((Get-Culture).LCID -ne 1040) {
			$ExitCode = "Code $LastExitCode. User stopped the process."
		}
	}
	Else {
		If ((Get-Culture).LCID -eq 1040) {
			$ExitCode = "Nessun codice restituito."
		}
		ElseIf ((Get-Culture).LCID -ne 1040) {
			$ExitCode = "No code error."
		}
	}

	# [ITA] Invia la stringa contenuta nella variabile $ExitCode al file di log. 
	# [ENG] Send string in $ExitCode variable to file log.
	If ((Get-Culture).LCID -eq 1040) {

		$CorpoHtml = $CorpoHtml + "<br>L'operazione eseguita ha restituito: <br>$ExitCode"

	}

	ElseIf ((Get-Culture).LCID -ne 1040) {

		$CorpoHtml = $CorpoHtml + "<br> The last operation returns: <br>$ExitCode"

	}

}

																			########################
																			# [ITA] Fine funzioni. #
																			# [ENG] End functions. #
																			########################

#############################################################################################################

# [ITA] Svuota il terminale. 
# [ENG] Clear console.
Clear-Host

#############################################################################################################

	#####################################################
	#		[ITA] Questa parte si occupa del file di log.		#
	#		[ENG] This part is for the log file.						#
	#####################################################

# [ITA] Percorso completo di 7-zip.exe (ModIficare secondo le proprie esigenze). 
# [ENG] Path of 7-zip.exe (ModIfy as your needs).
$7zipPath = "D:\SyMenu\ProgramFiles\SPSSuite\SyMenuSuite\7-Zip_(x64)_sps\7z.exe"

# [ITA] Se non trova l'eseguibile 7zip nel percorso indicato, termina lo script con un messaggio di errore.
# [ENG] If there isn't 7zip in given directory, stop script with an error.
If (-not (Test-Path -Path $7zipPath -PathType Leaf)) {

	If ((Get-Culture).LCID -eq 1040) {

		Throw $CorpoHtml = $CorpoHtml + "<br>Non ho trovato 7 zip in '$7zipPath'."

  }

  ElseIf ((Get-Culture).LCID -ne 1040) {

		Throw $CorpoHtml = $CorpoHtml + "<br>7 zip file '$7zipPath' not found."

  }
}

# [ITA] Imposta l'Alias come 7zip.
# [ENG] Set Alias in 7zip.
Set-Alias 7zip $7zipPath

# [ITA] Pone nella variabile $PercorsoScript il percorso completo dello script che si sta eseguendo, comprensivo del suo nome ed estensione. 
# [ENG] Set in $PercorsoScript variable the complete path of the script we are running, included its name and extension.
$PercorsoScript = $MyInvocation.MyCommand.Path

# [ITA] Pone nella variabile $DirectoryDiLavoro il percorso completo dello script, eliminando il nome dello stesso compreso di estensione.
# [ENG] Set in $DirectoryDiLavoro variable the complete path, removing script name and his extension, that we are running. 
$DirectoryDiLavoro = Split-Path $PercorsoScript

If ((Get-Culture).LCID -eq 1040) {

  # [ITA] Scrive nel file di log il contenuto della variabile $DirectoryDiLavoro.
	$CorpoHtml = $CorpoHtml + "<br>Directory di lavoro: $DirectoryDiLavoro"
	# [ITA] Pone nella variabile $DataOdierna la data e l'ora attuale (Cambiare la formattazione tra le virgolette se si desidera un altro formato).
	$DataOdierna = $((Get-Date).ToString('dd_MM_yyyy_HH_mm_ss'))
	# [ITA] Scrive nel file di log il contenuto della variabile $DataOdierna.
	$CorpoHtml = $CorpoHtml + "<br>Data odierna: $DataOdierna"

}

ElseIf ((Get-Culture).LCID -ne 1040) {

	# [ENG] Write in log file $DirectoryDiLavoro variable content.
	$CorpoHtml = $CorpoHtml + "<br>Working dir: $DirectoryDiLavoro"
	# [ENG] Set in $DataOdierna variable date and hour (Format the date as your need).
	$DataOdierna = $((Get-Date).ToString('yyyy_MM_dd_HH_mm_ss'))
	# [ENG] Write in log file $DataOdierna variable content.
	$CorpoHtml = $CorpoHtml + "<br>Current date: $DataOdierna"

}

# [ITA] Pone nella variabile $LogFile il contenuto della variabile $DirectoryDiLavoro, concatena uno slash, concatena il contenuto della variabile $DataOdierna ed infine inserisce l'estensione .html
# [ENG] Set in $LogFile variable the string in $DirectoryDiLavoro variable, add a slash, add the string in $DataOdierna and set .log extension.
$LogFile = "$DirectoryDiLavoro" + "\" + "$DataOdierna.html"

#############################################################################################################

	#################################################
	#		[ITA] Questa parte si occupa dei file RAR.	#
	#		[ENG] This part is for RAR file.						#
	#################################################

# [ITA] Imposta un array contenente i (il) file rar nella directory di lavoro.
# [ENG] New Array with all rar files in working dir.
$Rar = Get-ChildItem $DirectoryDiLavoro -Filter *.rar

# [ITA] Cicla tutti i file rar contenuti nell'Array.
# [ENG] Loop for all rar files in the Array.
ForEach ($CurrentRar in $Rar) {

	If ((Get-Culture).LCID -eq 1040) {

		# [ITA] Scrive nel file di log il contenuto della variabile $CurrentRar.
		$CorpoHtml = $CorpoHtml + "<br>File Rar in elaborazione: " + $CurrentRar.PSChildName + ""
		# [ITA] Pone nella variabile $DirTmp il nome del file rar in elaborazione senza estensione.
		$DirTmp = $CurrentRar.BaseName
		# [ITA] Aggiunge alla variabile $DirTmp il suffisso _tmp.
		$DirTmp = $DirTmp + "_tmp"
		# [ITA] Scrive nel file di log il contenuto della variabile $DirTmp.
		$CorpoHtml = $CorpoHtml + "<br>Cartella temporanea: $DirTmp"
		# [ITA] Scrive nella variabile $FullTmpDir il contenuto della variabile $DirectoryDiLavoro, concatena uno slash, concatena il contenuto
		#		 della variabile $DirTmp.
		$FullTmpDir = $DirectoryDiLavoro + "\" + $DirTmp
		# [ITA] Scrive nel file di log il contenuto della variabile $FullTmpDir.
		$CorpoHtml = $CorpoHtml + "<br>Percorso completo cartella temporanea: $FullTmpDir"

	}

	ElseIf ((Get-Culture).LCID -ne 1040) {

		# [ENG] Write in log file $CurrentRar variable content.
		$CorpoHtml = $CorpoHtml + "<br>I'm elaborating: $CurrentRar.PSChildName"
		# [ENG] Set in $DirTmp variable the name of the current rar without extension.
		$DirTmp = $CurrentRar.BaseName
		# [ENG] Add at the variable $DirTmp the suffix _tmp.
		$DirTmp = $DirTmp + "_tmp"
		# [ENG] Write in log file $DirTmp variable content.
		$CorpoHtml = $CorpoHtml + "<br>Temp folder: $DirTmp"
		# [ENG] Set in $FullTmpDir variable the string in $DirectoryDiLavoro variable, add a slash, add the string in $DirTmp.
		$FullTmpDir = $DirectoryDiLavoro + "\" + $DirTmp
		# [ENG] Write in log file $FullTmpDir variable content.
		$CorpoHtml = $CorpoHtml + "<br>Complete path of the temp folder: $FullTmpDir"

	}

	# [ITA] Controlla, se la directory temporanea esiste,
	# [ENG] Check, If temp folder already exist,
	If ( Test-Path -Path $FullTmpDir -PathType Container ) {

		# [ITA] la elimina usando la funzione CancellaCartella.
		# [ENG] delete it using CancellaCartella function.
		CancellaCartella $FullTmpDir

	}
	
	# [ITA] Testa l'archivio RAR corrente e riporta il risultato nel file di log.
	# [ENG] Test integrity of the current RAR archive and write result in log file.
	7zip t $CurrentRar.FullName -r | findstr /i /v "pavlov scanning compressing"	| Out-File $LogFile 2>&1 -Append
	Write-Output "[$($file.FullName)] $Line" | ConvertTo-Html | Out-File C:\Users\username\Desktop\FoundFiles.htm
	
	
	
	
	
	
	GestioneLastExitCode $LastExitCode
	
	
	
	
	
	
	
	
	
	
	$ok = $LastExitCode -eq 0

	# [ITA] Estrae l'elenco dei file e delle cartelle nell'archivio RAR corrente e lo inserisce nel file di log.
	# [ENG] List all file and folders in the current RAR archive and write it in log file.
	7zip l $CurrentRar.FullName | findstr /i /v "pavlov scanning compressing" | Out-File $LogFile 2>&1 -Append
	
	# [ITA] Crea una riga vuota nel file di log.
	# [ENG] Leave one blank line in log file.
	"" | Out-File $LogFile 2>&1 -Append
	
	# [ITA] Estrae solo la riga contenente il numero di file e cartelle contenute nell'archivio RAR corrente e lo inserisce nel file di log.
	# [ENG] Extract only row with the number of files and folder for the current RAR archive and write it in log file.
	7zip l $CurrentRar.FullName | findstr /i '([0-9]+) files, ([0-9]+) folders' | Out-File $LogFile 2>&1 -Append
	
	# [ITA] Pone nella variabile $StringTest la riga contenente il numero di file e cartelle contenute nell'archivio RAR corrente.
	# [ENG] Set in $StringTest variable the row with the number of files and folder for the current RAR archive. 
	$StringTest = 7zip l $CurrentRar.FullName | findstr /i '([0-9]+) files, ([0-9]+) folders' | Out-String
	
	# [ITA] Estrae con un RegEx dalla variabile $StringTest solo numero di file e cartelle contenute nell'archivio RAR corrente e crea coi due dati un array $Matches.
	# [ENG] Extract with RegEx from $StringTest variable only number of files and number of folder and put them in an Array $Matches. 
	$StringTest -match '([0-9]+ files,) ([0-9]+ folders)'
	
	# [ITA] La prima parte della stringa viene posta nella variabile $NumFilesInRar.
	# [ENG] First part of string is set into $NumFilesInRar variable. 
	$NumFilesInRar = $Matches[1]
	
	# [ITA] Viene eliminata dalla variabile $NumFilesInRar tutto ciò che non è un numero.
	# [ENG] Removing from $NumFilesInRar variable all except numbers.
	$NumFilesInRar = $NumFilesInRar -replace "([^0-9]+)"

	# [ITA] La variabile stringa $NumFilesInRar, ora solo numeri, viene trasformata in una variabile di tipo Long.
	# [ENG] The variable string $NumFilesInRar, containing now only numbers, is set as a Long type variable. 
	[Long]$NumFilesInRar = $NumFilesInRar
	
	# [ITA] La seconda parte della stringa viene posta nella variabile $NumDirsInRar.
	# [ENG] Second part of string is set into $NumDirsInRar variable. 
	$NumDirsInRar = $Matches[2]
	
	# [ITA] Viene eliminata dalla variabile $NumDirsInRar tutto ciò che non è un numero.
	# [ENG] Removing from $NumDirsInRar variable all except numbers. 
	$NumDirsInRar = $NumDirsInRar -replace "([^0-9]+)"

	# [ITA] La variabile stringa $NumDirsInRar, ora solo numeri, viene trasformata in una variabile di tipo Long.
	# [ENG] The variable string $NumDirsInRar, containing now only numbers, is set as a Long type variable. 
	[Long]$NumDirsInRar = $NumDirsInRar
	
	# [ITA] Estrae l'archivio RAR corrente.
	# [ENG] Extract the current RAR archive.
	7zip x $CurrentRar.FullName "-o$FullTmpDir"	-r | findstr /i /v "pavlov scanning compressing"	| Out-File $LogFile 2>&1 -Append

	# [ITA] .
	# [ENG] . 
	$Ok = $LastExitCode -eq 0

	# [ITA] Crea una riga vuota nella finestra Terminale.
	# [ENG] Leave one blank line in terminal window.
	""

	# [ITA] Se la variabile $Ok è True, tutto è andato bene durante l'estrazione.
	# [ENG] If $Ok variable is True, all during extraction gone ok.
	If ($Ok -eq "True") {

		# [ITA] L'Exit code è 0 pertanto tutto è andato bene.
		# [ENG] Exit code is 0, all is ok.
		$Ok = "Exit code = 0, tutto bene"

	}
	
	# [ITA] Altrimenti, se la variabile $Ok non è impostata a True, qualcosa è andato storto.
	# [ENG] If $Ok variable is not equal to True, something go wrong.
	ElseIf ($Ok -ne "True") {

		# [ITA] Nella variabile $0 viene inserito il codice di errore generato da 7zip.
		# [ENG] Set in $0 variabile the exit code value.
		$Ok = "PROBLEMA: Codice errore $LastExitCode"

	}

	# [ITA] Scrive a video il contenuto della variabile $Ok.
	# [ENG] Write in console $Ok variable content.
	Write-host " $Ok"

	# [ITA] Crea una riga vuota nella finestra Terminale.
	# [ENG] Leave one blank line in terminal window.
	""
	}
# [ITA] Crea una riga vuota nella finestra Terminale.
# [ENG] Leave one blank line in terminal window.
""

# 7zip a -mx=9 $DirTmp $CurrentRar

#############################################################################################################

#############################################################
#		[ITA] Sezione che costruisce l'html del file di log.		#
#		[ENG] This section build html of the log file.					#
#############################################################

$Header = @"
<title>File di log per le operazioni svolte nella cartella $($DirectoryDiLavoro)</title>
<style>
h1
	{
	text-align:center;
	}
body
	{
	font-family: "Courier New";
	font-size: 20px;
	line-height: 2
	}
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
<h1>File di log per le operazioni svolte nella cartella <br> $($DirectoryDiLavoro)</h1>
"@

If ((Get-Culture).LCID -eq 1040) {

  $post = "<br><i>Report generato il $((Get-Date).ToString()) da $($Env:Computername)</i>"

}

ElseIf ((Get-Culture).LCID -ne 1040) {

  $post = "<br><i>Report generated on $((Get-Date).ToString()) from $($Env:Computername)</i>"

}

ConvertTo-HTML -Head $Header -body $CorpoHtml -PostContent $post | Out-file $LogFile

Invoke-Item $LogFile