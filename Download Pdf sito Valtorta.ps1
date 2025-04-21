$url = "https://scrittivaltorta.altervista.org/per_volume.htm"
$page = invoke-webrequest -Uri $url
$linksPdf = $page.Links
foreach ($linkPdf in $linksPdf)
    {
        if ($linkPdf.href -like '*pdf*')
            {
                $title = $linkPdf.outerHTML
                $title = ConvertFrom-Html -Content $title
                $title = $title.InnerText
                $title = [System.Web.HttpUtility]::HtmlDecode($title)
                $title = $title -replace '(^\s+|\s+$)' , '' -replace '\s+',' '
                $filePdf = $linkPdf.href 
                $vol = $filePdf.SubString(0,2)
                $chapter = $filePdf.Substring(0,$filePdf.Length-4)
                $chapter = $chapter.Substring($chapter.get_Length()-3)
                # Source file location
                $source = "https://scrittivaltorta.altervista.org/$filePdf"
                # Destination to save the file
                $destination = "F:\Letteratura cristiana\Evangelo\Volume $vol - Capitolo $chapter - $title.pdf"
                #Download the file
                Invoke-WebRequest -Uri $source -OutFile $destination
            }
    }