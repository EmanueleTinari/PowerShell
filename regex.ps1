$NomeFile = "John Walkenbach, Michael Alexander, Dick Kusleika - Microsoft® Excel® 2019 Bible (J. Wiley & Sons, 2019)[ENG]"
$NomeFile -match "(.*)\s\-"
$Autore = $Matches.1
Write-Host $Autore
$NomeFile -match "\-\s(.*)\s\("
$Titolo = $Matches.1
Write-Host $Titolo
$NomeFile -match "\,\s([0-9]{4})"
$Anno = $Matches.1
Write-Host $Anno
$NomeFile -match "\[([A-Z]{3})\]"
$Lingua = $Matches.1
Write-Host $Lingua