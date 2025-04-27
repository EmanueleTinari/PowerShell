# Released to the Public Domain
# See https://
# Recursively clear read-only flag for all files in current directory and 
# sub-directories.

Function Set-FolderItemsReadOnly {

	<#PSScriptInfo

		.Version 1.0.0.0

		.GUID ATTENZIONE!!! Inserire il GUID

		.Description Function to set all files in a dir (and in its subDirs) read only or not.

		.Author Emanuele Tinari

		.CompanyName None

		.Copyright Emanuele Tinari

		.Tags PowerShell, Utilities, Function, Files properties, File system.

		.LicenseURI https://github.com/EmanueleTinari/PowerShell/blob/main/LICENSE.md

		.ProjectURI https://github.com/EmanueleTinari/PowerShell/blob/main/Function%20Set%20folder%20items%20read%20only.ps1

		.IconURI 

		.ExternalModuleDependencies None

		.RequiredScripts None

		.RequiredModules None

		.ExternalScriptDependencies None

		.ReleaseNotes Initial release.


	#>

	<#
		.SYNOPSIS
			[ITA] Imposta o meno la proprietà dei file in Sola lettura o no.
			[ENG] Set files property read-only or not.

		.DESCRIPTION
			[ITA] Questa Funzione permette di impostare, o rimuovere, nei files in una data cartella (ed eventualmente nelle sue sotto cartelle) la proprietà Sola lettura.
			[ENG] Function set, or remove, in all files property, in a dir (and eventually its sub dirs) Read-Only attribute.

		.PARAMETER $Path
			0 - [ITA] Il percorso dei file su cui eseguire lo script. Se non viene impostato utilizza di default lo stesso percorso dove il file di PowerShell è posizionato (".\").
			0 - [ENG] Working path where are files to run the job. If not set, the same path where the script is located is used (.\)

		.PARAMETER $RecurseSubDirs
			1 - [ITA] True se si vuole operare anche nelle sotto cartelle, altrimenti False (Valore di default).
			1 - [ENG] True if we wanna recurse in all sub dirs too, otherwise False (Default value).

		.PARAMETER $ReadOnly
			2 - [ITA] True se si vogliono rendere tutti i file presenti di sola lettura, altrimenti False (Valore di default).
			2 - [ENG] True if we wanna set all files in dir Read only, otherwise False (Default value).

		.EXAMPLE	
			Set-FolderItemsReadOnly
			(Without any parameter, so default ones are used: same path of the script, Recurse Sub-Dirs False, Read only False)

		.EXAMPLE	
			Set-FolderItemsReadOnly -RecurseSubDirs $True
			(Only Recurse sub-dirs is set. Default ones are used for others parameters: same path of the script and Read only False)

		.EXAMPLE	
			Set-FolderItemsReadOnly -RecurseSubDirs $False
			(Only Recurse sub-dirs is set. Default ones are used for others parameters: same path of the script and Read only False)

		.EXAMPLE	
			Set-FolderItemsReadOnly -Path "C:\Test" -RecurseSubDirs $True
			(Only work path and Recurse sub-dirs are set. Default one is used for last parameter: Read only on False)

		.EXAMPLE	
			Set-FolderItemsReadOnly -Path "C:\Test" -RecurseSubDirs $False
			(Only work path and Recurse sub-dirs are set. Default one is used for last parameter: Read only on False)

		.EXAMPLE	
			Set-FolderItemsReadOnly -Path "C:\Test" -RecurseSubDirs $False -ReadOnly $False
			(All three parameters are set)

		.EXAMPLE	
			Set-FolderItemsReadOnly -Path "C:\Test" -RecurseSubDirs $True -ReadOnly $False
			(All three parameters are set)

		.EXAMPLE	
			Set-FolderItemsReadOnly -Path "C:\Test" -RecurseSubDirs $True -ReadOnly $True
			(All three parameters are set)

		.EXAMPLE	
			Set-FolderItemsReadOnly -Path "C:\Test" -RecurseSubDirs $False -ReadOnly $True
			(All three parameters are set)

		.INPUTS
			0 - [ITA] Il percorso dei file su cui eseguire lo script. Se non viene impostato utilizza di default lo stesso percorso dove il file di PowerShell è posizionato (".\").
			0 - [ENG] Working path where are files to run the job. If not set, the same path where the script is located is used (.\)
			1 - [ITA] True se si vuole operare anche nelle sotto cartelle, altrimenti False (Valore di default).
			1 - [ENG] True if we wanna recurse in all sub dirs too, otherwise False (Default value).
			2 - [ITA] True se si vogliono rendere tutti i file presenti di sola lettura, altrimenti False (Valore di default).
			2 - [ENG] True if we wanna set all files in dir Read only, otherwise False (Default value).

		.OUTPUTS
			[ITA] Niente.
			[ENG] None.

	#>

	Param
		(
			[Parameter(
				Mandatory = $False,
				HelpMessage = "Initial work directory.",
				Position = 0)]
			[String]$Path = ".\",										# Default

			[Parameter(
				Mandatory = $False,
				HelpMessage = "Recurse Sub-Directory or not.",
				Position = 1)]
			[Boolean]$RecurseSubDirs = $False,							# Default

			[Parameter(
				Mandatory = $False,
				HelpMessage = "Set or remove property Read-Only for the file",
				Position = 2)]
			[Boolean]$ReadOnly = $False									# Default
		)

	# [ITA] La funzione inizia in questo punto.
	# [ENG] Start Function.
	Try {

		# [ITA] Se è stato scelto di NON impostare la proprietà dei file in sola lettura.
		# [ENG] If files property is set on Not Read-Only.
		If ($ReadOnly -eq $False) {

			# [ITA] Se è stato scelto di NON operare anche sui file delle sotto cartelle.
			# [ENG] If is choose to not recurse into sub-dirs.
			If ($RecurseSubDirs -eq $False) {

				# [ITA] Nella variabile oggetto $files vengono posti tutti i file della cartella scelta.
				# [ENG] In Var obj $files are set all files in choose folder.
				$files = Get-ChildItem -LiteralPath $Path -File -ErrorAction SilentlyContinue

				# [ITA] Ciclo per tutti i file presenti nella var oggetto $files.
				# [ENG] Loop for each file present in Var Obj $files.
				ForEach($file in $files) {

						# [ITA] Nel file in esame la proprietà sola lettura è impostata su False.
						# [ENG] In file in exam is set property Read-Only on False.
						Set-ItemProperty -LiteralPath $file.FullName -Name IsReadOnly -Value $False
						# [ITA] Viene impostata la riga del messaggio stampato a consolle.
						# [ENG] Set consolle message after job done.
						Write-Host $file.FullName

					}
				}

			# [ITA] Se è stato scelto di operare anche sui file delle sotto cartelle.
			# [ENG] If is choose to recurse into sub-dirs.
			ElseIf ($RecurseSubDirs -eq $True) {

				# [ITA] Estrae tutti gli elementi compresi anche quelli nelle sotto cartelle, escluso l'oggetto cartella stesso (quindi solo i file).
				# [ENG] Extract all elements in folder and sub-folders, but not the sub-folders object.
				Get-ChildItem . -Recurse | 
				Where-Object {
					-not $_.PSIsContainer
					# [ITA] Viene impostata la riga del messaggio stampato a consolle.
					# [ENG] Set consolle message after job done.
					Write-Host ($_.FullName)
					# [ITA] Nel file in esame la proprietà sola lettura è impostata su False.
					# [ENG] In file in exam is set property Read-Only on False.
					} | Set-ItemProperty -name IsReadOnly -value $False

			}

		}

		# [ITA] Se è stato scelto di impostare la proprietà dei file in Sola lettura.
		# [ENG] If files properties is set on Read-Only.
		ElseIf ($ReadOnly -eq $True) {

			# [ITA] Se è stato scelto di NON operare anche sui file delle sotto cartelle.
			# [ENG] If is choose to not recurse into sub-dirs.
			If ($RecurseSubDirs -eq $False) {

				# [ITA] Nella variabile oggetto $files vengono posti tutti i file della cartella scelta.
				# [ENG] In Var obj $files are set all files in choose folder.
				$files = Get-ChildItem -LiteralPath $Path -File -ErrorAction SilentlyContinue

				# [ITA] Ciclo per tutti i file presenti nella var oggetto $files.
				# [ENG] Loop for each file present in Var Obj $files.
				ForEach($file in $files) {

						# [ITA] Nel file in esame la proprietà sola lettura è impostata su True.
						# [ENG] In file in exam is set property Read-Only on True.
						Set-ItemProperty -LiteralPath $file.FullName -Name IsReadOnly -Value $True
						# [ITA] Viene impostata la riga del messaggio stampato a consolle.
						# [ENG] Set consolle message after job done.
						Write-Host $file.FullName

					}
			}

			# [ITA] Se è stato scelto di operare anche sui file delle sotto cartelle.
			# [ENG] If is choose to recurse into sub-dirs.
			ElseIf ($RecurseSubDirs -eq $True) {

				# [ITA] Estrae tutti gli elementi compresi anche quelli nelle sotto cartelle, escluso l'oggetto cartella stesso (quindi solo i file).
				# [ENG] Extract all elements in folder and sub-folders, but not the sub-folders object.
				Get-ChildItem . -Recurse | 
				Where-Object {
					-not $_.PSIsContainer
					# [ITA] Viene impostata la riga del messaggio stampato a consolle.
					# [ENG] Set consolle message after job done.
					Write-Host ($_.Name)
				# [ITA] Nel file in esame la proprietà sola lettura è impostata su True.
				# [ENG] In file in exam is set property Read-Only on True.
				} | Set-ItemProperty -name IsReadOnly -value $True

			}

		}

	# End Try
	}

	Catch {

		Write-Host "Error calling 'Function Set-FolderItemsReadOnly'. Message: +
		$($_.Exception.Message) + $($_.ScriptStackTrace)"

	# End Catch
	}

	# End Finally
	Finally {}

}

