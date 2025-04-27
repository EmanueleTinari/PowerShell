# 3 spazi
$path = "E:\" 
Get-ChildItem $path -File -Recurse |
Where-Object { $_.Name.Contains('   ')} |
Rename-Item -NewName { $_.Name -replace '   ', ' '
                        Write-Host "$_.Name"
                    }
# 2 spazi
$path = "E:\" 
Get-ChildItem $path -File -Recurse |
Where-Object { $_.Name.Contains('  ')} |
Rename-Item -NewName { $_.Name -replace '  ', ' '
                        Write-Host "$_.Name"
                    }
# 3 spazi
$path = "D:\" 
Get-ChildItem $path -File -Recurse |
Where-Object { $_.Name.Contains('   ')} |
Rename-Item -NewName { $_.Name -replace '   ', ' '
                        Write-Host "$_.Name"
                    }
# 2 spazi
$path = "D:\" 
Get-ChildItem $path -File -Recurse |
Where-Object { $_.Name.Contains('  ')} |
Rename-Item -NewName { $_.Name -replace '  ', ' '
                        Write-Host "$_.Name"
                    }