Add-type -path "C:\Windows\System32\itextsharp.dll"
Add-type -path "C:\Windows\System32\itextsharp.pdfa.dll"
Add-type -path "C:\Windows\System32\itextsharp.xtra.dll"
$validpdffiles = New-Object System.Collections.ArrayList
$filelist = Get-ChildItem "E:\eBook\" -Filter *.pdf -Recurse #Remove -recurse if you don't want this command to go into sub-directories
$filelist | foreach {
    $IsValid = $false
    try
    {
        $pdfreader = New-object iTextSharp.text.pdf.PdfReader($_.FullName)
    }
    catch
    {
        $IsValid = "Error!"
    }
    
    if ($pdfreader.IsOpenedWithFullPermissions)
    {
        $IsValid = $true
    }
    $pdfreader.Close()
    $validpdffiles.Add([PSCUSTOMOBJECT]@{
        "Name" = $_.FullName
        "IsValid" = $IsValid
        }) | Out-Null
}
$validpdffiles | Sort-Object -Property "IsValid"