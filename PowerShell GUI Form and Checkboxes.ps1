[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

# Set form size
$Form = New-Object System.Windows.Forms.Form
$Form.width = 500
$Form.height = 500
$Form.Text = ”Install Software”

# Set font
$Font = New-Object System.Drawing.Font("Verdana",10)
$Form.Font = $Font

# Create panel
$Panel = New-Object System.Windows.Forms.Panel
$Panel.Location = New-Object System.Drawing.Size(0,0)
$Panel.Size = New-Object System.Drawing.Size(480,380)
$Panel.AutoScroll = $true
$Form.Controls.Add($Panel)

# Checkbox 7-Zip
$checkbox1 = New-Object System.Windows.Forms.Checkbox
$checkbox1.Location = New-Object System.Drawing.Size(30,30)
$checkbox1.Size = New-Object System.Drawing.Size(120,20)
$checkbox1.Text = " 7-Zip"
$checkbox1.Checked = $false
$Panel.Controls.Add($checkbox1)

# checkbox notepad ++
$checkbox2 = new-object System.Windows.Forms.checkbox
$checkbox2.Location = new-object System.Drawing.Size(30,50)
$checkbox2.Size = new-object System.Drawing.Size(120,20)
$checkbox2.Text = " Notepad ++"
$checkbox2.Checked = $false
$Panel.Controls.Add($checkbox2)

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

if($checkbox1.Checked) {Write-Host "CheckBox 1 checked!"}
if(!$checkbox1.Checked) {Write-Host "CheckBox 1 NOT checked!"}
if($checkbox2.Checked) {Write-Host "CheckBox 1 checked!"}
if(!$checkbox2.Checked) {Write-Host "CheckBox 1 NOT checked!"}

}

# activate form
$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()