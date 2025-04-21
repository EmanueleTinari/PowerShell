# (ITA) Svuota il terminale. 
# (ENG) Clear console.
Clear-Host

# (ITA) Pone nella variabile $DirectoryDiLavoro il percorso completo dello script, eliminando il nome dello stesso compreso di estensione.
# (ENG) Set in $DirectoryDiLavoro variable the complete path, removing script name and his extension, that we are running. 
$DirectoryDiLavoro = Split-Path $PSCommandPath

# (ITA) Pone nella variabile $DllDaCaricare il contenuto della variabile $DirectoryDiLavoro, concatena uno slash, concatena il contenuto della variabile
#       $DataOdierna ed infine inserisce l'estensione .html
# (ENG) Set in $DllDaCaricare variable the string in $DirectoryDiLavoro variable, add a slash, add the library name with its extension.
$DllDaCaricare = "$DirectoryDiLavoro" + "\" + "itextsharp.dll"

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
        $PDFFile = [iText.Kernel.Pdf.PdfReader]::new($CurrentPdf)
        $Document = [iText.Kernel.Pdf.PdfDocument]::new($PDFFile)
        $OldAuthor       = $Document.GetDocumentInfo().GetAuthor()
        $OldTitle        = $Document.GetDocumentInfo().GetTitle()
        $OldKeywords     = $Document.GetDocumentInfo().GetKeywords()
        Write-Host $OldAuthor
        Write-Host $OldTitle
        Write-Host $OldKeywords
        $NewAuthor = "Autore impostato da PS"
        $NewTitle = "Titolo impostato da PS"
        $NewKeywords = "Keywords impostate da PS"
        try {
            [iText.Kernel.Pdf.PdfDocumentInfo] $info = $Document.GetDocumentInfo()
        } catch {
            Write-Warning "New-PDFInfo - Error: $($_.Exception.Message)"
            return
        }
            $Info.SetAuthor($NewAuthor)
        $Info.SetTitle($NewTitle)
        $Info.SetKeywords($NewKeywords)
        $Details = Get-PDFDetails -Document $Document
        Write-Host $Details
        $Document.Close()
        $PDFFile.Close()
        # (ITA) Nella variabile $filename è contenuto il nome del file in elaborazione comprensivo di estensione.
        # (ENG) Set in $filename variable the name and the extension of the current pdf.
        # $filename = $CurrentPdf.Name
        # (ITA) .
        # (ENG) .
        $Document = Get-PDF -FilePath "C:\Users\Emanuele\Desktop\PSScript\a.pdf"
        $Details = Get-PDFDetails -Document $Document
        Write-Host $Details
        #$Document.Title = "Titolo impostato da PS"
        New-PDFInfo  $Document -Title "Titolo impostato da PS" -Author "Autore impostato da PS" -Keywords "Keywords impostate da PS"
        $Details = Get-PDFDetails -Document $Document
        Write-Host $Details
        Close-PDF -Document $Document
    }

$a = Select-String "CreateDate\>(.*)\<" .\filename.pdf