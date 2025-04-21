function SetFolderItemsReadOnly{
    Param([string]$Path)
    $files = Get-ChildItem $Path -File -ErrorAction SilentlyContinue
    foreach($file in $files) {
        Set-ItemProperty -Path $file.FullName -Name IsReadOnly -Value $true

    }
}