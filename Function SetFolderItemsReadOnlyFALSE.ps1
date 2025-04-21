function SetFolderItemsReadOnly
    {
        Param([string]$Path)
        $files = Get-ChildItem -LiteralPath -File -ErrorAction SilentlyContinue
        foreach($file in $files)
            {
                Set-ItemProperty -LiteralPath $file.FullName -Name IsReadOnly -Value $false
            }
    }