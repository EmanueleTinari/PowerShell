Function Get-FileName($InitialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $InitialDirectory
    $OpenFileDialog.filter = "CHM (*.chm) | *.chm"
    $OpenFileDialog.ShowDialog() | Out-Null

}

$Path = Get-FileName

$Path | ForEach-Object { 
    
  Net User $_.SamAccountName $_.Password /FullName:"$_.FullName" /Add

}