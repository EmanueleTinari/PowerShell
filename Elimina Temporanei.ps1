# Imposta la variabile su False.
$done = $False

Do {
    # Richiede di cancellare tutti i file presenti nella cartella TEMP per l'utente corrente.
    $risposta = $( Write-Host "`nQuesta procedura cancellerà tutti i file nella`ncartella temporanea per l'utente corrente." -NoNewLine ) +
                $( Write-Host "`n`nProseguo? [S/N/E(sci)]" -ForegroundColor Yellow -NoNewLine; Read-Host )
    
    # L'utente risponde Si.
    If ( $risposta -eq 's' ) {
        $done = $True
        # Recupera il percorso della cartella TEMP per l'utente corrente.
        $UsrTmpPath = $env:TEMP
        # Cancella i file.
        Remove-Item $UsrTmpPath -Recurse -Force
    }

    # L'utente risponde No.
    ElseIf ( $risposta -eq 'n' ) {
        Clear-Host
        Write-Host "Cancellato.`n"
        $done = $True
    }

    # L'utente risponde Esci.
    ElseIf ( $risposta -eq 'e' ) {
        Clear-Host
        Write-Host "Esci.`n"
        $done = $True
        # Esce dallo script.
        Exit
    }

    # L'utente preme un altro tasto che non sia S (s) o N (n) o E (e).
    Else  {
        Clear-Host
        Write-Host $risposta "non è un carattere valido, per favore riprova." -ForegroundColor Red
    }

} Until ($done)

# Imposta la variabile su False.
$done = $False

Do {
    # Richiede di cancellare tutti i file presenti nella cartella TEMP di sistema.
    $risposta = $( Write-Host "Questa procedura cancellerà tutti i file`nnella cartella temporanea di sistema." -NoNewLine ) +
                $(Write-Host "`n`nProseguo? [S/N/E(sci)]" -ForegroundColor Yellow -NoNewLine; Read-Host )
    
    # L'utente risponde Si.
    If ( $risposta -eq 's' ) {
        $done = $true
        # Recupera il percorso della cartella TEMP di sistema.
        $SysTmpPath = [System.Environment]::GetEnvironmentVariable('TEMP','Machine')
        # Cancella i file.
        Remove-Item $SysTmpPath -recurse -force
    }

    # L'utente risponde No.
    ElseIf ($risposta -eq 'n') {
        Clear-Host
        Write-Host "Cancellato.`n"
        $done = $true
    }

    # L'utente risponde Esci.
    ElseIf ($risposta -eq 'e') {
        Clear-Host
        Write-Host "Esci.`n"
        $done = $true
        # Esce dallo script.
        Exit
    }

    # L'utente preme un altro tasto che non sia S (s) o N (n) o E (e).
    Else  {
        Clear-Host
        Write-Host $risposta "non è un carattere valido, per favore riprova." -ForegroundColor Red
    }

} Until ($done)

Read-Host -Prompt "Premi Invio per uscire."