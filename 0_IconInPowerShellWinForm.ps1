# ATTENZIONE!!! Funziona solo se ci sono le 2 ico nei percorsi dati. Altrimenti cambiare il percorso

# FROM: https://forums.powershell.org/t/add-icons-to-checkbox-text/24410

# x una Form scrollable: GUI: Scrollable selection of many checkboxes @ https://forums.powershell.org/t/gui-scrollable-selection-of-many-checkboxes/24415/1

# x Creare Form dinamicamente:
# Building Dynamic Forms with Powershell @ https://techhusain.wordpress.com/2017/02/14/building-dynamic-forms-with-powershell/
# Dynamically Updating a GUI Control with PowerShell @ https://xkln.net/blog/dynamically-updating-a-gui-control-with-powershell/


[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

# set form size
$Form = New-Object System.Windows.Forms.Form
$Form.width = 500
$Form.height = 500
$Form.Text = "Install Software"

# set font
$Font = New-Object System.Drawing.Font("Verdana",10)
$Form.Font = $Font

# checkbox 7-zip
$checkbox1 = new-object System.Windows.Forms.checkbox
$checkbox1.Location = new-object System.Drawing.Size(30,30)
$checkbox1.Size = new-object System.Drawing.Size(20,20)
$checkbox1.Checked = $false
$Form.Controls.Add($checkbox1)

# 7-zip icon
$ImagePath = 'C:\Program Files\Google\Drive File Stream\drive_fs.ico'
$ImageBytes = [System.IO.File]::ReadAllBytes($ImagePath)
$Icon = [Convert]::ToBase64String($ImageBytes)

$CheckBox1Label = New-Object System.Windows.Forms.Label
$CheckBox1Label.Width = 60
$CheckBox1Label.Location = New-Object System.Drawing.Point (50,30)
$CheckBox1Label.Image = $ImageBytes
$CheckBox1Label.ImageAlign = 'MiddleLeft'
$CheckBox1Label.Text = '7-Zip'
$CheckBox1Label.TextAlign = 'MiddleRight'
$Form.Controls.Add($CheckBox1Label)

# checkbox notepad ++
$checkbox2 = new-object System.Windows.Forms.checkbox
$checkbox2.Location = new-object System.Drawing.Size(30,50)
$checkbox2.Size = new-object System.Drawing.Size(20,20)
$checkbox2.Checked = $false
$Form.Controls.Add($checkbox2)

# Notepad++ icon
$ImagePath = 'C:\Program Files\Python313\DLLs\pyc.ico'
$ImageBytes = [System.IO.File]::ReadAllBytes($ImagePath)
$Icon = [Convert]::ToBase64String($ImageBytes)

$CheckBox2Label = New-Object System.Windows.Forms.Label
$CheckBox2Label.Width = 100
$CheckBox2Label.Location = New-Object System.Drawing.Point (50,50)
$CheckBox2Label.Image = $ImageBytes
$CheckBox2Label.ImageAlign = 'MiddleLeft'
$CheckBox2Label.Text = 'NotePad++'
$CheckBox2Label.TextAlign = 'MiddleRight'
$Form.Controls.Add($CheckBox2Label)

# ok button
$OKButton = new-object System.Windows.Forms.Button
$OKButton.Location = new-object System.Drawing.Size(130,400)
$OKButton.Size = new-object System.Drawing.Size(100,40)
$OKButton.Text = "OK"
$OKButton.Add_Click({$Form.Close()})
$form.Controls.Add($OKButton)

# cancel button
$CancelButton = new-object System.Windows.Forms.Button
$CancelButton.Location = new-object System.Drawing.Size(255,400)
$CancelButton.Size = new-object System.Drawing.Size(100,40)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$Form.Close()})
$form.Controls.Add($CancelButton)


$OKButton.Add_Click{

if($checkbox1.Checked) {Start-Process -FilePath C:\software\7z1900-x64.exe /S}
if($checkbox2.Checked) {Start-Process -FilePath C:\software\npp.7.8.1.Installer.x64.exe /S}

}

# activate form
$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()