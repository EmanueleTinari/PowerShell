                                                    #=================================================#
                                                    #                                                 #
                                                    #     [ITA] Trova in una determinata cartella     #
                                                    #     tutti i pdf protetti da password.           #
                                                    #             Ver. 1.0.0  24/05/2020              #
                                                    #                                                 #
                                                    #=================================================#

###############################################################################################################################################################    

# (ITA) Svuota il terminale. 
# (ENG) Clear console.
Clear-Host

###############################################################################################################################################################    

# (ITA) Pone nella variabile $DirectoryDiLavoro il percorso completo dello script, eliminando il nome dello stesso compreso di estensione.
# (ENG) Set in $DirectoryDiLavoro variable the complete path, removing script name and his extension, that we are running. 
$DirectoryDiLavoro = Split-Path $PSCommandPath


# (ITA) Pone nella variabile $DllDaCaricare il contenuto della variabile $DirectoryDiLavoro, concatena uno slash, concatena il contenuto della variabile
#       $DataOdierna ed infine inserisce l'estensione .html
# (ENG) Set in $DllDaCaricare variable the string in $DirectoryDiLavoro variable, add a slash, add the library name with its extension.
$DllDaCaricare = "$DirectoryDiLavoro" + "\" + "itextsharp.dll"

###############################################################################################################################################################
# (ITA) Carica la dll.
# (ENG) Load the dll.
[System.Reflection.Assembly]::LoadFrom($DllDaCaricare)
# (ITA) Metodo secondario per caricare la dll.
# (ENG) Another way to load the dll.
# Add-Type -Path $DllDaCaricare

# (ITA) Imposta un array contenente i (il) file pdf nella directory di lavoro.
# (ENG) New Array with all pdf files in working dir.
$Pdf = Get-ChildItem $DirectoryDiLavoro -Filter *.pdf

# (ITA) Cicla tutti i file pdf contenuti nell'Array.
# (ENG) Loop for all pdf files in the Array.
foreach ($CurrentPdf in $Pdf)
    {
        # (ITA) Nella variabile $filename è contenuto il nome del file in elaborazione comprensivo di estensione.
        # (ENG) Set in $filename variable the name and the extension of the current pdf.
        $filename = $CurrentPdf.Name
        # (ITA) .
        # (ENG) .
        $Basename = $CurrentPdf.BaseName
        Try
            {   
                # (ITA) Crea un nuovo oggetto col file in elaborazione.
                # (ENG) Open reader with the current pdf file.
                $CheckPdf = New-Object iTextSharp.text.pdf.PdfReader ($CurrentPdf.FullName)
                $raf = New-object iTextSharp.text.pdf.RandomAccessFileOrArray($CurrentPdf.FullName)
                $reader = New-object iTextSharp.text.pdf.PdfReader($raf, $Nothing)

                $reader







                
                
                $ScriviPdf = New-Object iTextSharp.text.pdf.PdfWriter ($CurrentPdf.FullName)
                info = $CurrentPdf.FullName.getDocumentInfo
                info.setTitle("The Strange Case of Dr. Jekyll and Mr. Hyde")

                # $doc = New-Object -TypeName iTextSharp.text.Document
                # $fileStream = New-Object -TypeName IO.FileStream -ArgumentList ($CurrentPdf.FullName, [System.IO.FileMode]::Create)
                # [iTextSharp.text.pdf.PdfWriter]::GetInstance($doc, $filestream)
                # [iTextSharp.text.FontFactory]::RegisterDirectories()
                # (ITA) Se il pdf in elaborazione è criptato.
                # (ENG) If current pdf is encripted.
                if ($CheckPdf.IsEncrypted())
                    {
                        # (ITA) .
                        # (ENG) .
                        Write-Host $filename "`nProtetto" -ForegroundColor Red
                        # (ITA) .
                        # (ENG) .
                        Write-Host $CheckPdf.Info.Title 
                        # (ITA) .
                        # (ENG) .
                        Write-Host $CheckPdf.Info.Author
                        # (ITA) .
                        # (ENG) .
                        Write-Host $CheckPdf.Info.Subject
                    }
                # (ITA) .
                # (ENG) .
                else
                    {
                        # (ITA) .
                        # (ENG) .
                        Write-Host $filename "`nNON protetto" -ForegroundColor Green
                        #Write-Host "Titolo: " $CheckPdf.Info.Title
                        # (ITA) .
                        # (ENG) .
                        if ($CheckPdf.Info.Title -ne "")
                            {
                                # (ITA) .
                                # (ENG) .
                                Write-Host " * * * Sistemo il titolo del pdf * * * "
                                # (ITA) .
                                # (ENG) .
                                Write-Host "Vecchio titolo: " $CheckPdf.Info.Title
                                # (ITA) .
                                # (ENG) .
                                $Doc.AddTitle("") | Out-Null
                                # (ITA) .
                                # (ENG) .
                                Write-Host "Titolo svuotato: " $CheckPdf.Info.Title
                                # (ITA) .
                                # (ENG) .
                                $Basename -match "\-\s(.*)\s\("
                                # (ITA) .
                                # (ENG) .
                                $Doc.AddTitle("$Matches.1") | Out-Null
                            }    
                        #Write-Host "Autore: " $CheckPdf.Info.Author
                        # (ITA) .
                        # (ENG) .
                        if ($CheckPdf.Info.Author -ne "")
                            {
                                # (ITA) .
                                # (ENG) .
                                Write-Host " * * * Sistemo l'autore del pdf * * * "
                                # (ITA) .
                                # (ENG) .
                                Write-Host "Vecchio autore: " $CheckPdf.Info.Author
                                # (ITA) .
                                # (ENG) .
                                $Doc.AddAuthor("") | Out-Null
                                # (ITA) .
                                # (ENG) .
                                Write-Host "Autore svuotato: " $CheckPdf.Info.Author
                                # (ITA) .
                                # (ENG) .
                                $Basename -match "(.*)\s\-"
                                # (ITA) .
                                # (ENG) .
                                $Doc.AddAuthor("$Matches.1") | Out-Null
                            }
                        #Write-Host "Soggetto: " $CheckPdf.Info.Subject
                        # (ITA) .
                        # (ENG) .
                        if ($CheckPdf.Info.Subject -ne "")
                            {
                                # (ITA) .
                                # (ENG) .
                                Write-Host " * * * Sistemo il soggetto del pdf * * * "
                                # (ITA) .
                                # (ENG) .
                                Write-Host "Vecchio soggetto: " $CheckPdf.Info.Subject
                                # (ITA) .
                                # (ENG) .
                                $Doc.AddSubject("") | Out-Null
                                # (ITA) .
                                # (ENG) .
                                Write-Host "Soggetto svuotato: " $CheckPdf.Info.Subject
                            }
                            # (ITA) .
                            # (ENG) .
                            Write-Host " * * * Sistemo la lingua del pdf * * * "
                            # (ITA) .
                            # (ENG) .
                            Write-Host "Vecchia lingua: " $CheckPdf.xmp
                            # (ITA) .
                            # (ENG) .
                            $Doc.AddLanguage("") | Out-Null
                            # (ITA) .
                            # (ENG) .
                            Write-Host "Lingua aggiornata: " $CheckPdf.Info.Subject
                            # (ITA) .
                            # (ENG) .
                            $Basename -match "\[([A-Z]{3})\]"
                            # (ITA) .
                            # (ENG) .
                            $Doc.AddLanguage("$Matches.1") | Out-Null
                    }                        
            }
        Catch
            {
                # (ITA) .
                # (ENG) .
                write-host $filename " Problemi col file. Controllare." -ForegroundColor Yellow
            }
        }