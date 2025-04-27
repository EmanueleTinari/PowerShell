Add-type -path ".\iText.Kernel.dll"
Add-type -path ".\iText.PdfA.dll"
#Add-type -path ".\iTextsharp.XtrA.dll"

$validPDFfiles = New-Object System.Collections.ArrayList
# Use or remove -Recurse if you want/don't want this command to go into sub-directories.
$fileList = Get-ChildItem "G:\" -Filter *.pdf #-Recurse
$fileList | ForEach-Object {
	$IsValid = $False
	Try
	{
		$pdfReader = New-object iTextKernel.text.pdf.PdfReader($_.FullName)
	}
	Catch
	{
		$IsValid = "Error!"
	}

	If ($pdReader.IsOpenedWithFullPermissions)
	{
		$IsValid = $True
	}
	$pdfReader.Close()
	$validPDFfiles.Add([PSCustomObject]@{
		"Name" = $_.FullName
		"IsValid" = $IsValid
		}) | Out-Null
}

$validPDFfiles | Sort-Object -Property "IsValid"

Write-Host $validPDFfiles
Pause