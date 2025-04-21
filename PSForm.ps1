[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")  
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[void] [System.Windows.Forms.Application]::EnableVisualStyles() 
# Second way:
#Add-Type -assembly System.Windows.Forms

    ########################
    # FUNCTION  for button #
    ########################
Function Chiudi
    {
        $main_form.Close()
    }

    #######################
    # FORM      main_form #
    #######################

$main_form = New-Object System.Windows.Forms.Form
# Size - Width\hight : I have given two method of defining the form's size. Comment out the second method (#).
# SECOND WAY: $Form.Size = New-Object System.Drawing.Size(400,200).
$main_form.Height = 400
$main_form.Width = 600
$LarghezzaForm = 600
$main_form.AutoSize = $false
$TitoloForm = "* * * Moduli caricati * * *"
$FontTitolo = New-Object System.Drawing.Font('Arial',14)
$LarghezzaTitolo = [System.Windows.Forms.TextRenderer]::MeasureText($TitoloForm, $FontTitolo)
$SpazioDisponibile = $LarghezzaForm - $LarghezzaTitolo.Width
$SpazioSx = $SpazioDisponibile / 2
$SpazioSx = ([Math]::Round($SpazioSx))
$TestoSpostato = $TitoloForm.PadLeft($SpazioSx)
# Text : This is your form Name.
$main_form.Text =$TestoSpostato
# MaximizeBox : Mazimize button can be enable\disable.
# $main_form.MaximizeBox = $false 
# If you want to hide the x and all the controls at the top of the form try
$main_form.ControlBox = $false
# StartPosition : You can decide where your form should appear while executing.
$main_Form.StartPosition = "CenterScreen" 
# FormBorderStyle : You cannot change the form's size by dragging border.
$main_Form.FormBorderStyle = 'Fixed3D' 
# Icon File : You have to create or download icon file (.ico) to use icon in form.
$formIcon = New-Object system.drawing.icon ("C:\Program Files\PowerShell\7\assets\Powershell_black.ico") 
$main_Form.Icon = $formIcon
$main_Form.BackColor = [System.Drawing.Color]::DarkSalmon

    ####################
    # LABEL     Label1 #
    ####################

$Label1 = New-Object System.Windows.Forms.Label
$Label1.Text = "Seleziona un modulo dalla Combo"
# $Label.Location  : Location size should provide based on our main form.
# Note the main form's location and provide the size accordingly.
# Another way.
# $Label.Location = New-Object System.Drawing.Size(75,50) 
$Label1.Location  = New-Object System.Drawing.Point(10,10)
$Label1.AutoSize = $true
# New-Object System.Drawing.Font("Arial",15,[System.Drawing.FontStyle]::Bold):
# Using System.Drawing.Font class to format the font style of label.
$Label1.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::Regular)
# We have to add all the newly creating objects under our main form ($main_form) object by using Controls.Add command.
$main_form.Controls.Add($Label1) # Adding $Label1 object inside our main FORM ($main_form).

    ####################
    # COMBOBOX  Combo1 #
    ####################

$Combo1 = New-Object System.Windows.Forms.ComboBox
$Combo1.Width = 300
$Mods = Get-Module
Foreach ($Mod in $Mods)
    {
        $Combo1.Items.Add($Mod);
    }
$Combo1.Location  = New-Object System.Drawing.Point(10,40)
$Combo1.AutoSize = $true
$main_Form.Controls.Add($Combo1)

    ######################
    # BUTTON    Closebtn #
    ######################

$Closebtn = New-Object System.Windows.Forms.Button
$LarghezzaBottone = 120
$PosizioneBottoneSx = $LarghezzaForm - $LarghezzaBottone - 30
$Closebtn.Location = New-Object System.Drawing.Size($PosizioneBottoneSx,20) 
$Closebtn.Size = New-Object System.Drawing.Size(120,50)
$Closebtn.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold) 
$Closebtn.Text = "Chiudi" 
$Closebtn.Add_Click({Chiudi}) 
$main_Form.Controls.Add($Closebtn) 
 
#$main_Form.Font = New-Object System.Drawing.Font("Verdana",10,[System.Drawing.FontStyle]::Bold)

    #############
    # SHOW FORM #
    #############

$main_form.ShowDialog()