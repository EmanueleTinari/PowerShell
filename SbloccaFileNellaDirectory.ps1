Function Get-Folder( $initialDirectory = "" )

{
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

    $folderName                 = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderName.Description     = "Seleziona una cartella"
    $folderName.rootFolder      = "MyComputer"
    $folderName.SelectedPath    = $initialDirectory

    If ( $foldername.ShowDialog() -eq "OK" )
    {
        $folder += $folderName.SelectedPath
    }
    Return $folder
}

$a = Get-Folder
Get-ChildItem $a -Recurse | Unblock-File

# Or
# dir /s $a | unblock-file -confirm

Read-Host -Prompt "Premi Invio per uscire."