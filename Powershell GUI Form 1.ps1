# Generates main form
Function GenerateForm ($__QuantityOfCheckBox, $__CheckBoxDescription){
	# Loading Windows Forms Assembly
	[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
	[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null

	# Creating control objects 
	$form1 = New-Object System.Windows.Forms.Form
	$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
	# Region Generated Form Code
	$form1.Text = "Test Form"
	$form1.Name = "form1"
	$form1.AutoScroll="true"
	$form1.DataBindings.DefaultDataSourceUpdateMode = 0
	$System_Drawing_Size = New-Object System.Drawing.Size
	$System_Drawing_Size.Width = 450
	$System_Drawing_Size.Height = 236
	$form1.ClientSize = $System_Drawing_Size

	# Call function to generate on the fly checkboxes
	Function GenerateCheckboxes ($__QuantityOfCheckBox, $__CheckBoxDescription){
 
	# Reads input text from array 
	$CheckBoxLabels = $__CheckBoxDescription
	# Keep track of number of checkboxes
	$CheckBoxCounter = 1
	#looping to create checkboxes based on the CheckBoxLabels array
	$CheckBoxes = Foreach($Label in $CheckBoxLabels) {
		$CheckBox = New-Object System.Windows.Forms.CheckBox
		$CheckBox.UseVisualStyleBackColor = $True
		$System_Drawing_Size = New-Object System.Drawing.Size
		$System_Drawing_Size.Width = 104
		$System_Drawing_Size.Height = 24
		$CheckBox.Size = $System_Drawing_Size
		$CheckBox.TabIndex = 2
		# Assign text based on the input
		$CheckBox.Text = $Label
		$System_Drawing_Point = New-Object System.Drawing.Point
		$System_Drawing_Point.X = 27
		# Make sure to vertically space them dynamically, counter comes in handy
		$System_Drawing_Point.Y = 13 + (($CheckBoxCounter - 1) * 31)
		$CheckBox.Location = $System_Drawing_Point
		$CheckBox.DataBindings.DefaultDataSourceUpdateMode = 0
		# Give it a unique name based on our counter
		$CheckBox.Name = "CheckBox$CheckBoxCounter"
		# Add it to the form
		$form1.Controls.Add($CheckBox)
		# return object ref to array
		$CheckBox
		# increment our counter
		$CheckBoxCounter++
		#End Loop
		}
	#End Function
	}

	GenerateCheckboxes $__QuantityOfCheckBox $__CheckBoxDescription
	$form1.ShowDialog()| Out-Null 
#End Function
}

Set-Variable -Scope Global -Name __QuantityOfCheckBox -Description "" -Value (3)
Set-Variable -Scope Global -Name __CheckBoxDescription -Description "" -Value ("CheckboxN1", "CheckboxN2", "CheckboxN3")
GenerateForm $__QuantityOfCheckBox $__CheckBoxDescription
