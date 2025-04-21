# Excel deve essere aperto o lo script non funzionerà.
# Excel must be open or script'll not run.

Add-Type -AssemblyName 'System.Windows.Forms'
$notification = New-Object System.Windows.Forms.NotifyIcon
$path = (Get-Process -id (get-process "excel").id).Path
$notification.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
$notification.BalloonTipIcon  = [System.Windows.Forms.ToolTipIcon]:: "Error"
$Titolo = "Titolo"
$Messaggio = "Messaggio"
$Durata = "10"
$notification.BalloonTipTitle = $Titolo
$notification.BalloonTipText = $Messaggio
$notification.Visible = $true
$notification.ShowBalloonTip($Durata)