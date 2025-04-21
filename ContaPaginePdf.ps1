$folder = 'D:\Documents\Downloads\Emule-Incoming\xpdf-tools-win-4.03\bin32'
$Total = $Files = 0

foreach ($File in (Get-ChildItem -Path $Folder -Filter *.pdf))
{
    $Pages = (D:\Documents\Downloads\Emule-Incoming\xpdf-tools-win-4.03\bin32\pdfinfo.exe $File.FullName | Select-String -Pattern '(?<=Pages:\s*)\d+').Matches.Value
    $Total += $Pages
    $Files++
    [PSCustomObject]@{
        PdfFile = $File.Name
        Pages   = $Pages
    }
}
"`nTotalNumber of pages: {0} in {1} files" -f $Total,$Files