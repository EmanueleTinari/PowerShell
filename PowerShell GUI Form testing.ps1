# Build form (GUI)
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
$guiForm = New-Object System.Windows.Forms.Form
$guiForm.Text = "Tool"
$guiForm.Size = New-Object System.Drawing.Size(1200,600)
$guiForm.StartPosition = "CenterScreen"
$guiForm.FormBorderStyle = "FixedDialog"
$guiForm.MaximizeBox = $false
# Text
$guiTextBoxFile = New-Object System.Windows.Forms.TextBox
$guiTextBoxFile.Location = New-Object System.Drawing.Size(10,10)
$guiTextBoxFile.Size = New-Object System.Drawing.Size(500,100)
$guiForm.Controls.Add($guiTextBoxFile)
# Button
[System.Windows.Forms.Button]$guiButtonOpenFile = New-Object System.Windows.Forms.Button
$guiButtonOpenFile.Location = New-Object System.Drawing.Size(515,10)
$guiButtonOpenFile.Size = New-Object System.Drawing.Size(95,20)
$guiButtonOpenFile.Text = "Browse file"
$guiForm.Controls.Add($guiButtonOpenFile)
# OpenFileDialog
$guiOpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$guiOpenFileDialog.initialDirectory = "c:\temp"
$guiOpenFileDialog.filter = "All files (*.*)| *.*"
$guiOpenFileDialog.initialDirectory = "c:\temp"
# List
$guiListBox = New-Object System.Windows.Forms.ListBox
$guiListBox.Location = New-Object System.Drawing.Size(10,50)
$guiListBox.Size = New-Object System.Drawing.Size(600,100)
$guiForm.Controls.Add($guiListBox)
[void]$guiListBox.Items.Add("Red")
[void]$guiListBox.Items.Add("Green")
[void]$guiListBox.Items.Add("Blue")
[void]$guiListBox.Items.Add("Yellow")
[void]$guiListBox.Items.Add("Black")
[void]$guiListBox.Items.Add("White")
# ListItems
$guiListBox_ListItems = New-Object System.Windows.Forms.ListView
$guiListBox_ListItems.View = [System.Windows.Forms.View]::Details
$guiListBox_ListItems.Location = New-Object System.Drawing.Size(10,410)
$guiListBox_ListItems.Size = New-Object System.Drawing.Size(600,155)
$guiListBox_ListItems.MultiSelect = $false
$guiListBox_ListItems.FullRowSelect = $true
$cHeader1 =  New-Object System.Windows.Forms.ColumnHeader
$cHeader1.Text = "Name"
$cHeader1.Width = 350
$cHeader2 =  New-Object System.Windows.Forms.ColumnHeader
$cHeader2.Text = "UniqueId"
$cHeader2.Width = 220
$guiListBox_ListItems.Columns.AddRange([System.Windows.Forms.ColumnHeader[]](@($cHeader1, $cHeader2)))
$guiForm.Controls.Add($guiListBox_ListItems)
# Output TextBox (Read-Only)
$guiTextBox_Output = New-Object System.Windows.Forms.TextBox
$guiTextBox_Output.Location = New-Object System.Drawing.Size(620,10)
$guiTextBox_Output.Size = New-Object System.Drawing.Size(565,547)
$guiTextBox_Output.Multiline = $true
$guiTextBox_Output.Font = New-Object System.Drawing.Font("Courier New", "8")
$guiTextBox_Output.Wordwrap = $false
$guiTextBox_Output.ReadOnly = $True
$guiTextBox_Output.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical, [System.Windows.Forms.ScrollBars]::Horizontal
$guiForm.Controls.Add($guiTextBox_Output)
$guiComboBox = New-Object System.Windows.Forms.ComboBox
$guiComboBox.Location = New-Object System.Drawing.Size(10,200)
$guiComboBox.Size = New-Object System.Drawing.Size(100,30)
[void]$guiComboBox.Items.Add("Red")
[void]$guiComboBox.Items.Add("Green")
[void]$guiComboBox.Items.Add("Blue")
[void]$guiComboBox.Items.Add("Yellow")
[void]$guiComboBox.Items.Add("Black")
[void]$guiComboBox.Items.Add("White")
$guiForm.Controls.Add($guiComboBox)
# (Interactive) Functions
$guiListBox.Add_SelectedValueChanged(
    {
        Write-Output -Message ('guiListBox.SelectedValueChanged to '+$guiListBox.SelectedItem)
    }
)
$guiComboBox.Add_SelectedValueChanged(
    {
        Write-Output -Message ('guiComboBox.SelectedValueChanged to '+$guiComboBox.SelectedItem)
    }
)
$guiButtonOpenFile.Add_Click(
    {
        $guiOpenFileDialog.ShowDialog()
        $guiTextBoxFile.Text = $guiOpenFileDialog.Filename
    }
)
# Finally show form (GUI)
$guiForm.Add_Shown({$guiForm.Activate()})
$guiForm.ShowDialog()