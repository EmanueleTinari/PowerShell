
# Path to xPdf-Tools
$folder = 'D:\0E-I\xpdf-tools-win-4.03\bin32'
$Total = $Files = 0

Foreach ($File in (Get-ChildItem -Path $Folder -Filter *.pdf)) {

	$Pages = (D:\0E-I\xpdf-tools-win-4.03\bin32\pdfInfo.exe $File.FullName | Select-String -Pattern '(?<=Pages:\s*)\d+').Matches.Value
	
    $Total += $Pages
	$Files++
	[PSCustomObject]@{
		PdfFile = $File.Name
		Pages   = $Pages
	}
}

Write-Host "`nTotalNumber of pages: {0} in {1} files" -f $Total, $Files