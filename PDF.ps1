                                    #=================================================#
                                    #                                                 #
                                    #                                                 #
                                    #                                                 #
                                    #             Ver. 1.0.0  05/04/2021              #
                                    #                                                 #
                                    #=================================================#
##################################################################################################################
# (ITA) Svuota il terminale e tutte le variabili usate. 
Clear-Host
$DirectoryDiLavoro = ""
$Totale = 0
$Files = 0
$Pdf = ""
$CurrentPdf = ""
$Filename = ""
$Pages = 0
$Totale = 0
$NumChar = 0
$FirstElement = ""
$NomeFileNoExt = ""
$SecondoElemento = ""
$SecondoElementoNoLineetta = ""
$EstraiLingua = ""
$NumCharEstraiLingua = 0
Set-Variable -Name ITA -Value "Italiano" -Option Constant -Scope Global -Force
Set-Variable -Name LAT -Value "Latino" -Option Constant -Scope Global -Force
Set-Variable -Name GRE -Value "Greco" -Option Constant -Scope Global -Force
Set-Variable -Name ENG -Value "Inglese" -Option Constant -Scope Global -Force
###############################################################################################################################################################    
# (ITA) Pone nella variabile $DirectoryDiLavoro il percorso completo dello script, eliminando il nome dello stesso compreso di estensione.
$DirectoryDiLavoro = Split-Path $PSCommandPath
# (ITA) Pone nella variabile $Totale
$Totale = $Files = 0
# (ITA) Imposta un array contenente i (il) file pdf nella directory di lavoro.
$Pdf = Get-ChildItem $DirectoryDiLavoro -Filter *.pdf
# (ITA) Cicla tutti i file pdf contenuti nell'Array.
ForEach ($CurrentPdf in $Pdf)
    {
        # (ITA) Nella variabile $filename è contenuto il nome del file in elaborazione comprensivo di estensione.
        $Filename = $CurrentPdf.Name
        # (ITA) .
        $Pages = (.\PdfInfo.exe $CurrentPdf.FullName | Select-String -Pattern '(?<=Pages:\s*)\d+').Matches.Value
        $Totale += $Pages
        $Files++
        $NomeFileNoExt = $CurrentPdf.BaseName
        $NumChar = $NomeFileNoExt.Length
        $FirstElement = $NomeFileNoExt.Split(" - ")[0]
        $SecondoElemento = $NomeFileNoExt.Substring($NomeFileNoExt.IndexOf(" - "))
        $SecondoElementoNoLineetta = $SecondoElemento.Trim(" - ")
        $EstraiLingua = ($SecondoElementoNoLineetta |Select-String '(?<=\[)[^]]+(?=\])' -AllMatches).Matches.Value
        $NumCharEstraiLingua = $EstraiLingua.Length
        Write-Host $NumCharEstraiLingua
        If ($NumCharEstraiLingua = 3)
            {
                Write-Host $NumCharEstraiLingua
            }
        If ($NumCharEstraiLingua = 7)
            {
                Write-Host $NumCharEstraiLingua
            }
        If ($NumCharEstraiLingua = 11)
            {
                Write-Host $NumCharEstraiLingua
            }    
        If ($NumCharEstraiLingua = 15)
            {
                Write-Host $NumCharEstraiLingua
            }
        [PSCustomObject]@{
            'Pdf File' = $Filename
            Pagine   = $Pages
            Caratteri = $NumChar
            'Nome File' = $NomeFileNoExt
            'Autore' = $FirstElement
            'TitoloEcc' = $SecondoElementoNoLineetta
            'Lingua' = $EstraiLingua
        }
}

"`nNumero Totale di pagine: {0} in {1} files" -f $Totale, $Files
Write-Host $ITA
Write-Host $LAT
Write-Host $GRE
Write-Host $ENG