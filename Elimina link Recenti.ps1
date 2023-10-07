Get-ChildItem $env:APPDATA\Microsoft\Windows\Recent\* -File -Force -Exclude desktop.ini | 
Remove-Item -Force -ErrorAction SilentlyContinue
Get-ChildItem $env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations\* -File -Force -Exclude desktop.ini, f01b4d95cf55d32a.automaticDestinations-ms | 
Remove-Item -Force -ErrorAction SilentlyContinue
Get-ChildItem $env:APPDATA\Microsoft\Windows\Recent\CustomDestinations\* -File -Force -Exclude desktop.ini | 
Remove-Item -Force -ErrorAction SilentlyContinue
Get-ChildItem $env:APPDATA\Microsoft\Office\Recent\* -File -Force -Exclude desktop.ini |
Remove-Item -Force -ErrorAction SilentlyContinue

Read-Host -Prompt "Premi Invio per uscire."