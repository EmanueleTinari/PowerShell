##################################################
# [ITA] Svuota la console di Windows PowerShell. #OK tt
# [ENG] Empy Windows PowerShell consolle.        #
##################################################
#
Clear-Host
Clean-Memory
#
[void] [System.Windows.Forms.Application]::EnableVisualStyles()
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName PresentationCore,PresentationFramework 
Add-Type -AssemblyName System.Drawing
#
############################################################
# [ITA] Function  per svuotare le variabili dalla memoria. # 
# [ENG] Function to clean memory Vars.                     #
############################################################
#
Function Clean-Memory {
Get-Variable |
 Where-Object { $startupVariables -notcontains $_.Name } |
 ForEach-Object {
  try { Remove-Variable -Name "$($_.Name)" -Force -Scope "global" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue}
  catch { }
 }
}
#
#############################################################################
# [ITA] La variabile $Lingua contiene il codice della lingua nel sisytema . #OK tt
# [ENG] $Lingua variable contains the language code in the system.          #
#############################################################################
#
$Culture = Get-Culture
$Language = $Culture.Name
$Language
#
#######################################
# [ITA] Function  per obj_BtnAnnulla. #OK tt
# [ENG] Function for obj_BtnAnnulla.  #
#######################################
#
Function Annulla
    {
        # [ITA] Chiama la Function.
        # [ENG] Call Function.
        DeselezionaChkBox
        # [ITA] Chiama la Function.
        # [ENG] Call Function.
        SelezionaDefault
    }
#
######################################
# [ITA] Function  per obj_BtnChiudi. #OK tt
# [ENG] Function for obj_BtnChiudi.  #
######################################
#
Function Chiudi
    {
        # [ITA] Le seguenti operazioni verranno compiute alla chiusura della Form.
        # [ENG] Next operations'll be execduted on closing Form.
        $Add_FormClosed=
        {
            try
            {
                # [ITA] Rimuove il disegno del ToolTip.
                # [ENG] Remove ToolTip Draws.
                $obj_Ttp.Remove_Draw($obj_Ttp_Draw)
            }
            catch { Out-Null }
        }
        # [ITA] Chiude al Form obj_Frm.
        # [ENG] Close obj_Frm Form.
        $obj_Frm.Close()
    }
#
#######################################################
# [ITA] Function  per deselezionare tutti i CheckBox. #OK tt
# [ENG] Function  for unselect all CheckBoxes.        #
#######################################################
#
Function DeselezionaChkBox
    {
        # [ITA] Esamina tutti i controlli contenuti nella Form $obj_Frm e li mette, uno alla volta, nella variabile $FormControl.
        # [ENG] Loop throught all controls inside the Form $obj_Frm, and insert them, once a time, in $FormControl Var.
        Foreach ($FormControl in $obj_Frm.Controls)
            {
                # [ITA] Nella variabile $objectType viene inserito il nome dell'oggetto in esame contenuto nella variabile $FormControl.
                # [ENG] In $objectType Var we'll find the name of the objecy under examin in $FormControl Var.
                $objectType = $FormControl.GetType().Name
                # [ITA] Se il controllo contenuto nella variabile $objectType è di tipo GroupBox, allora.
                # [ENG] If control in $objectType Var is like GroupBox, then.
                If ($objectType -like "GroupBox")
                    {
                        # [ITA] Esamina tutti i controlli contenuti nella variabile $FormControl e li mette, uno alla volta, nella variabile $GroupBoxControl.
                        # [ENG] Loop throught all controls inside the $FormControl variable, and insert them, once a time, in $GroupBoxControl Var.
                        Foreach ($GroupBoxControl in $FormControl.Controls)
                            {
                                # [ITA] Nella variabile $objectType viene inserito il nome dell'oggetto in esame contenuto nella variabile $GroupBoxControl.
                                # [ENG] In $objectType Var we'll find the name of the objecy under examin in $GroupBoxControl Var.
                                $objectType = $GroupBoxControl.GetType().Name
                                # [ITA] Se il controllo contenuto nella variabile $objectType è di tipo CheckBox, allora.
                                # [ENG] If control in $objectType Var is like CheckBox, then.
                                If ($objectType -like "CheckBox")
                                    {
                                        # [ITA] Se spuntata, toglie la spunta alla CheckBox in esame.
                                        # [ENG] If checked, uncheck the CheckBox find.
                                        $GroupBoxControl.Checked = $False
                                    }
                            }
                    }
            }
    }
#
####################################################################
# [ITA] Function  per selezionare i CheckBox di default.           #OK tt
# [ENG] Function  for select default CheckBoxes (Undefined value). #
####################################################################
#
Function SelezionaDefault()
    {
        # [ITA] Seleziona tutti i primi CheckBox (Undefined).
        # [ENG] Select all first CheckBoxes (Undefined value).
        $obj_CkBox1.Checked = $True
        $obj_CkBox2.Checked = $True
        $obj_CkBox3.Checked = $True
        $obj_CkBox4.Checked = $True
        $obj_CkBox5.Checked = $True
    }
#
##########################################################
# [ITA] Viene costruita l'icona della bandiera italiana. #OK tt
# [ENG] Set icon for Italian menu.                       #
##########################################################
#
# [ITA] L'immagine è composta da una stringa di testo.
# [ENG] The image is in a Base64 string.
$base64IconStringIT = "iVBORw0KGgoAAAANSUhEUgAAAIAAAABVBAMAAABz4/FkAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEUAkkZVtoT////ecXnOKzf4vnb4AAAAAWJLR0QCZgt8ZAAAAAd0SU1FB+YLCAM0DA53SkQAAAA3SURBVFjD7czBAAAwEAOwMhzCpjJ/pgn0cQAJQJJmTnFfE4FAIBAIBAKBQCAQCAQCgUAgEKyDD49nzaSJedwFAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIyLTExLTA4VDAzOjUyOjEyKzAwOjAwcAeKJQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMi0xMS0wOFQwMzo1MjoxMiswMDowMAFaMpkAAAAASUVORK5CYII="
$iconImageBytes = [Convert]::FromBase64String($base64IconStringIT)
$imIT = New-Object IO.MemoryStream($iconImageBytes, 0, $iconImageBytes.Length)
$imIT.Write($iconImageBytes, 0, $iconImageBytes.Length);
#
#########################################################
# [ITA] Viene costruita l'icona della bandiera inglese. #OK tt
# [ENG] Set icon for English menu.                      #
#########################################################
#
# [ITA] L'immagine è composta da una stringa di testo.
# [ENG] The image is ub ìn a Base64 string.
$base64IconStringEN = "iVBORw0KGgoAAAANSUhEUgAAAIAAAABACAMAAADlCI9NAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAkFBMVEXVR17wv8f////i5u5wgqoJKG4BIWmrts7pn6vIEC4GJWxfc6Dc4er77vDjh5bLHzvWS2LxxMv77e/jg5PLHDnh5e1oe6YHJm3Q1uPK0eCtt8/z9fj++fr219zutb7tsLrxwsr66u3//f319/muuM/cZnnyxc3utL310tj+/f39+Pnyx87XUGbLGzjgd4j66exwsyf9AAAAAWJLR0QCZgt8ZAAAAAd0SU1FB+YLBxMkHB1H+1cAAAH4SURBVGje7ZlZV8JADIUvoxaqqOyL+4b78v//nYjFFpjJJBc8fZk8cDglk/uRtrMkQMNVbG//IFNYc+7ayivWml9oakYeHrWdOz45LcahgZ8PMwILsCHvHJZfTAgcgEe+AMjzTteEwAAs5Hv9Qb6qiPULKgQ7QEB+DrCekqUNR+PdAYxHw83kFwChH8Qs2AC89/4PIMwmZMECMJYVIPMFsqAHiEaHxokGUESG1pEAUEWFxdkEoIwI6wAlgDoamEFRAMOfAZO2CIDpdoJ5cEQA4wMN5tURAMyvNJjJIwhATGrImPnLD8DMqQGAGMLEBzBtMwsbMmoN8wFQ62qGZtjOpufOXVxeXf/aza0McBfwvJ88CCJwrHkywFgCQIu1WRVgRodBXrMlgASQABJAAqgfoPbFKO0HageIbUpL6z0We86n5xcZoOL5Gt2Uytvy0t7eC62Pz694Bla9xW05Ix8+mNgRQMiLRzMrAgj5yOHUhgBCPno8tyCAkFcUKPQIIORVJRotAgh5ZZFKhwBmkLZMp4kGJm36QmU8IpgHx1KqjUUF8+rYitVyZDCTh7VcL0VfNCxCDrtrWIQVQK1hRMsmpALzv6ebVn6lP4Bup7g46Pf+q21XWqkG6wZiu8blZhZAyG/Vul1HACG/ZfN6FQGme7+j9n31WfgGPwbsPvjpXhQAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjItMTEtMDdUMTk6MzY6MjgrMDA6MDCSHFjbAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIyLTExLTA3VDE5OjM2OjI4KzAwOjAw40HgZwAAAABJRU5ErkJggg=="
$iconImageBytes = [Convert]::FromBase64String($base64IconStringEN)
$imEN = New-Object IO.MemoryStream($iconImageBytes, 0, $iconImageBytes.Length)
$imEN.Write($iconImageBytes, 0, $iconImageBytes.Length);
#
###########################################
# [ITA] Variabile lingua di default.      #OK tt
# [ENG] Variable for the defaul language. #
###########################################
#
$linguaDefault = "Italiano"
#
################################################################################
# [ITA] Variabile lingua impostata, inizialmente è quella di default.          #OK tt
# [ENG] Variable for the selected language, on start it's the same of default. #
################################################################################
#
$linguaImpostata = $linguaDefault
#
############################
# [ITA] Mostra il ToolTip. # 
# [ENG] Show ToolTip.      #
############################
#
# [ITA] Definisce i pennelli per il nero ed il bianco.
$whiteBrush = new-object Drawing.SolidBrush White
$blackBrush = new-object Drawing.SolidBrush Black
# [ITA] Definisce il nuovo oggetto ToolTip.
$obj_Ttp = New-Object System.Windows.Forms.ToolTip
# [ITA] Questo blocco si occupa della visualizzazione dei ToolTip.
$MostraTooltip={
    # [ITA] Visualizza il Tooltip a popup.
    # [ITA] Ogni valore è il nome del controllo sulla Form.
    Switch ($This.Name) {
        # [ITA] Prima riga di CheckButton sulla Form, per il CurrentUser.
        "obj_CkBox1" {$Tip = $This.Text}
        "obj_CkBox1_1" {$Tip = $This.Text}
        "obj_CkBox1_2" {$Tip = $This.Text}

        # [ITA] Seconda riga di CheckButton sulla Form, per la LocalMachine.
        "obj_CkBox2" {$Tip = $This.Text}
        "obj_CkBox2_1" {$Tip = $This.Text}
        "obj_CkBox2_2" {$Tip = $This.Text}

        # [ITA] Terza riga di CheckButton sulla Form, per la MachinePolicy.
        "obj_CkBox3" {$Tip = $This.Text}
        "obj_CkBox3_1" {$Tip = $This.Text}
        "obj_CkBox3_2" {$Tip = $This.Text}

        # [ITA] Quarta riga di CheckButton sulla Form, per i Process.
        "obj_CkBox4" {$Tip = $This.Text}
        "obj_CkBox4_1" {$Tip = $This.Text}
        "obj_CkBox4_2" {$Tip = $This.Text}

        # [ITA] Quinta riga di CheckButton sulla Form, per la UserPolicy.
        "obj_CkBox5" {$Tip = $This.Text}
        "obj_CkBox5_1" {$Tip = $This.Text}
        "obj_CkBox5_2" {$Tip = $This.Text}

        "obj_BtnSalva" {$Tip = "Salva le impostazioni, chiedendone conferma."}
        "obj_BtnAnnulla" {$Tip = "Annulla gli inserimenti e riporta ai valori di default."}
        "obj_BtnChiudi" {$Tip = "Chiude la Form senza apportare cambiamenti."}
    }
     $obj_Ttp.SetToolTip($This,$Tip)
     $obj_Ttp.OwnerDraw = $True 
     $obj_Ttp_Draw=[System.Windows.Forms.DrawToolTipEventHandler]{

        # [ITA] Definisce il Font per il ToolTip personalizzato. 
        $fontstyle = new-object System.Drawing.Font('Calibri', 12, [System.Drawing.FontStyle]::Regular)

        # [ITA] Imposta l'allineamento della scritta nel ToolTip.
        $format = [System.Drawing.StringFormat]::GenericTypographic
        $format.LineAlignment = [System.Drawing.StringAlignment]::Center
        $format.Alignment = [System.Drawing.StringAlignment]::Center    
        
        # [ITA] Disegna il ToolTip.    
        $_.Graphics.FillRectangle($blackBrush, $_.Bounds)
        $_.Graphics.DrawString($_.ToolTipText, $fontstyle, $whiteBrush, ($_.Bounds.X + ($_.Bounds.Width/2)), ($_.Bounds.Y + ($_.Bounds.Height/2)), $format)         
     }
     # [ITA] Aggiunge il disegno del ToolTip allo stesso.
     $obj_Ttp.Add_Draw($obj_Ttp_Draw)

}
# [ITA] Fine del blocco dedicato al funzionamento dei ToolTip.
# [ENG] End ToolTip block.
#
#######################################################
# [ITA] Estrae l'icona di PowerShell dall'eseguibile. #Ok tt
# [ENG] Extract PowerShell Icon from PowerShell Exe.  #
#######################################################
#
$iconaPS = [Drawing.Icon]::ExtractAssociatedIcon((Get-Command powershell).Path)
#
#######################
# [ITA] FORM obj_Frm. #OK tt
# [ENG] FORM obj_Frm. #
#######################
#
# [ITA] Definisce il nuovo oggetto Form.
# [ENG] Define new Form object.
$obj_Frm = New-Object System.Windows.Forms.Form
# [ITA] Titolo della Form.
# [ENG] Form's title.
$obj_Frm.Text = "* * * Set-ExecutionPolicy * * *"
# [ITA] Larghezza della Form.
# [ENG] Form width.
$obj_Frm.Width = 600
# [ITA] Altezza della Form.
# [ENG] Form height.
$obj_Frm.Height = 450
# [ITA] L'icona della Form è quella contenuta nella variabile.
# [ENG] Form icon is in the Var.
$obj_Frm.Icon = $iconaPS
# [ITA] Menù principale della Form.
# [ENG] Form's menu.
$obj_Frm.MainMenuStrip = $menuMain
# [ITA] La Form non si ridimensiona automaticamente.
# [ENG] The Form isn't Autoresizable.
$obj_Frm.AutoSize = $false
# [ITA] Mette la Form davanti a tutte le altre finestre.
# [ENG] The Form is behind all other windows.
$obj_Frm.TopMost = $True
# [ITA] Imposto il carattere della Form.
# [ENG] Form's font.
$obj_Frm.Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Bold)
# [ITA] La Form non ha casella di controllo.
# [ENG] The Form's not ControlBox.
$obj_Frm.ControlBox = $false
# [ITA] La Form viene centrata allo schermo.
# [ENG] The Form's at the center of the screen.
$obj_Frm.StartPosition = "CenterScreen" 
# [ITA] Bordo della Form.
# [ENG] Form's Border.
$obj_Frm.FormBorderStyle = 'Fixed3D'
# [ITA] Colore della Form.
# [ENG] Form's back colour.
$obj_Frm.BackColor = [System.Drawing.Color]::DarkSalmon
#
########################
# [ITA] MENU obj_menu. #OK tt
# [ENG] MENU obj_menu. #
########################
#
# [ITA] Definisce il nuovo oggetto Menu.
# [ENG] Define new Object Menu.
$menuMain = New-Object System.Windows.Forms.MenuStrip
# [ITA] La Barra Menù viene aggiunta alla Form.
# [ENG] Menu Bar is added to the Form.
[void]$obj_Frm.Controls.Add($menuMain)
#
##############################################
# [ITA] Voce di menù per la lingua italiana. #OK tt
# [ENG] Italian language voice's menu.       #
##############################################
#
# [ITA] Definisce il nuovo oggetto Voce di menù.
# [ENG] Define new Tool strip menu item object.
$menuItaliano = New-Object System.Windows.Forms.ToolStripMenuItem
# [ITA] Testo del menù.
# [ENG] Menu text.
$menuItaliano.Text = "&Italiano"
# [ITA] Icona del menù.
# [ENG] Menu's icon.
$menuItaliano.Image = [System.Drawing.Image]::FromStream($imIT, $true)
# [ITA] Scelta rapida da tastiera.
# [ENG] Menu's Shortcut key.
$menuItaliano.ShortcutKeys = "Control, I"
# [ITA] Funzione che verrà eseguita cliccando sulla voce del menù.
# [ENG] Menu's Function on click.
$menuItaliano.Add_Click({LinguaItaliana})



$menuItaliano.Add_MouseEnter({$statusLabel.Text = "Italiano"})
$menuItaliano.Add_MouseLeave({$statusLabel.Text = "Pronto"})



# [ITA] La voce del menù viene aggiunto alla Barra menù.
# [ENG] Menu's voice is added to the menu bar.
[void]$menuMain.Items.Add($menuItaliano)
#
#############################################
# [ITA] Voce di menù per la lingua inglese. #OK tt
# [ENG] English language voice's menu.      #
#############################################
#
# [ITA] Definisce il nuovo oggetto Voce di menù.
# [ENG] Define new Tool strip menu item object.
$menuInglese = New-Object System.Windows.Forms.ToolStripMenuItem
# [ITA] Testo del menù.
# [ENG] Menu text.
$menuInglese.Text = "&English"
# [ITA] Icona del menù.
# [ENG] Menu's icon.
$menuInglese.Image = [System.Drawing.Image]::FromStream($imEN, $true)
# [ITA] Scelta rapida da tastiera.
# [ENG] Menu's Shortcut key.
$menuInglese.ShortcutKeys = "Control, E"
# [ITA] Funzione che verrà eseguita cliccando sulla voce del menù.
# [ENG] Menu's Function on click.
$menuInglese.Add_Click({LinguaInglese})


$menuInglese.Add_MouseEnter({$statusLabel.Text = "English"})
$menuInglese.Add_MouseLeave({$statusLabel.Text = "Ready"})




# [ITA] La voce del menù viene aggiunto alla Barra menù.
# [ENG] Menu's voice is added to the menu bar.
[void]$menuMain.Items.Add($menuInglese)
#
#############################
# [ITA] Voce di menù Aiuto. #OK tt
# [ENG] Help voice's menu.  #
#############################
#
# [ITA] Definisce il nuovo oggetto Voce di menù.
# [ENG] Define new Tool strip menu item object.
$menuAiuto = New-Object System.Windows.Forms.ToolStripMenuItem
# [ITA] Testo del menù.
# [ENG] Menu text.
$menuAiuto.Text = "&Aiuto"
# [ITA] Scelta rapida da tastiera.
# [ENG] Menu's Shortcut key.
$menuAiuto.ShortcutKeys = "Control, A"



$menuAiuto.Add_MouseEnter({$statusLabel.Text = "Menù aiuto"})
$menuAiuto.Add_MouseLeave({$statusLabel.Text = "Ready"})





# [ITA] La voce del menù viene aggiunto alla Barra menù.
# [ENG] Menu's voice is added to the menu bar.
[void]$menuMain.Items.Add($menuAiuto)
#
##################################################################
# [ITA] Sottovoce della voce di menù Aiuto (Menu Aiuto / Circa). #OK tt
# [ENG] Help subvoice's menu (Help Menu / Circa).                #
##################################################################
#
# [ITA] Definisce il nuovo oggetto Sottovoce di menù.
# [ENG] Define new Tool strip menu item object.
$menuCirca = New-Object System.Windows.Forms.ToolStripMenuItem
# [ITA] Testo della voce.
# [ENG] Submenu first voice text.
$menuCirca.Text = "Su Sicurezza script"
# [ITA] Icona del menù.
# [ENG] Menu's icon.
$menuCirca.Image = [System.Drawing.SystemIcons]::Information
# [ITA] Funzione che verrà eseguita cliccando sulla voce del menù.
# [ENG] Menu's Function on click.
$menuCirca.Add_Click({Circa})
# [ITA] La sottovoce del menù viene aggiunto alla voce del menù.
# [ENG] Menu's subvoice is added.
[void]$menuAiuto.DropDownItems.Add($menuCirca)
#
# [ITA] Definisce il nuovo oggetto StatusStrip.
# [ENG] Define new Object StatusStrip.
$statusStrip = New-Object System.Windows.Forms.StatusStrip
#
# [ITA] Definisce il nuovo oggetto StatusLabel.
# [ENG] Define new Object StatusLabel.
$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
#
# [ITA] Aggiungo l'etichetta alla barra di stato.
# [ENG] Add Status Label tp the StatusStrip.
[void]$statusStrip.Items.Add($statusLabel)
# [ITA] Testo dell'etichetta.
# [ENG] Label text.
$statusLabel.Text = "Pronto"
# [ITA] L'etichetta si ridimensiona automaticamente.
# [ENG] The label is Autoresizable.
$statusLabel.AutoSize = $true
# [ITA] La barra di stato viene aggiunta alla Form.
# [ENG] StatusStrip is added to the Form.
$obj_Frm.Controls.Add($statusStrip)
#
##################################
# [ITA] Function per Circa.      #OK tt
# [ENG] Function for About menu. #
##################################
#
Function Circa {
    # [ITA] Testo dell'etichetta della barra di stato.
    # [ENG] Status bar label text.
    $statusLabel.Text = "Circa"
    # [ITA] Definisce il nuovo oggetto Form.
    # [ENG] Define new Form object.
    $obj_FrmCirca = New-Object System.Windows.Forms.Form
    # [ITA] Dimensioni della Form.
    # [ENG] Form's dimensions.
    $obj_FrmCirca.ClientSize = "350,110"
    # [ITA] La Form non ha casella di controllo.
    # [ENG] The Form's not ControlBox.
    $obj_FrmCirca.ControlBox    = $True # POI DECOMMENTARE QUESTO E METTERE $False INVECE DI $True
    # [ITA] Mette la Form davanti a tutte le altre finestre.
    # [ENG] The Form is behind all other windows.
    $obj_FrmCirca.TopMost = $True
    # [ITA] La Form non ha l'icona nella TaskBar di Windows.
    # [ENG] The Form hasn't icon in Windows TaskBar.
    $obj_FrmCirca.ShowInTaskBar = $false
    # [ITA] La Form viene centrata rispetto alla Form principale.
    # [ENG] The Form is centered respect his form parent.
    $obj_FrmCirca.StartPosition = "CenterParent"
    # [ITA] Titolo della Form.
    # [ENG] Form's title.
    $obj_FrmCirca.Text = "SicurezzaScript.ps1"
    $obj_FrmCirca.Add_Load($obj_FrmCirca_Load)
    #
    # [ITA] Immagine Form Circa.
    # [ENG] About Form / Picture.
    #
    # [ITA] Definisce il nuovo oggetto Immagine.
    # [ENG] Define new PictureBox object.
    $obj_FrmCircaImage = New-Object System.Windows.Forms.PictureBox
    # [ITA] Immagine della Form Circa.
    # [ENG] Circa Form's image..
    $obj_FrmCircaImage.Image = $iconaPS.ToBitmap()
    # [ITA] Sua posizione.
    # [ENG] His position.
    $obj_FrmCircaImage.Location = New-Object System.Drawing.Size(40,22)
    # [ITA] Sue dimensioni.
    # [ENG] Its dimensions.
    $obj_FrmCircaImage.Size = New-Object System.Drawing.Size(40,40)
    # [ITA] Tipo visualizzazione immagine.
    # [ENG] Image mode.
    $obj_FrmCircaImage.SizeMode = "StretchImage"
    # [ITA] L'oggetto immagine viene aggiunto alla Form.
    # [ENG] Image object is added to the Form.
    $obj_FrmCirca.Controls.Add($obj_FrmCircaImage)
    #
    # [ITA] Etichetta nome Form Circa.
    # [ENG] About Form / Name Label.
    #
    # [ITA] Definisce il nuovo oggetto Etichetta.
    # [ENG] Define new Label object.
    $obj_FrmCircaNameLabel = New-Object System.Windows.Forms.Label
    # [ITA] Imposto il carattere della Form.
    # [ENG] Form's font.
    $obj_FrmCircaNameLabel.Font = New-Object Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Bold)
    # [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
    # [ENG] Position: From LEFT border, from TOP border.
    $obj_FrmCircaNameLabel.Location = New-Object System.Drawing.Size(70,0)
    # [ITA] Dimensione: LARGHEZZA, ALTEZZA.
    # [ENG] Dimensions: WIDTH, HEIGHT.
    $obj_FrmCircaNameLabel.Size = New-Object System.Drawing.Size(200,22)
    # [ITA] Testo dell'etichetta.
    # [ENG] Label's text.
    $obj_FrmCircaNameLabel.Text = "         Sicurezza Script"
    # [ITA] L'oggetto etichetta viene aggiunta alla Form.
    # [ENG] Label object is added to the Form.
    $obj_FrmCirca.Controls.Add($obj_FrmCircaNameLabel)
    #
    # [ITA] Etichetta testo Form Circa.
    # [ENG] About Form / Text label.
    #
    # [ITA] Definisce il nuovo oggetto Etichetta.
    # [ENG] Define new Label object.
    $obj_FrmCircaText = New-Object System.Windows.Forms.Label
    # [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
    # [ENG] Position: From LEFT border, from TOP border.
    $obj_FrmCircaText.Location = New-Object System.Drawing.Size(95,22)
    # [ITA] Dimensione: LARGHEZZA, ALTEZZA.
    # [ENG] Dimensions: WIDTH, HEIGHT.
    $obj_FrmCircaText.Size = New-Object System.Drawing.Size(200,36)
    # [ITA] Testo dell'etichetta.
    # [ENG] Label's text.
    $obj_FrmCircaText.Text = "                    Autore:`n`r           Emanuele Tinari"
    # [ITA] L'oggetto etichetta viene aggiunta alla Form.
    # [ENG] Label object is added to the Form.
    $obj_FrmCirca.Controls.Add($obj_FrmCircaText)
    #
    # [ITA] Etichetta mail Form Circa.
    # [ENG] About Form / Mail label.
    #
    # [ITA] Definisce il nuovo oggetto Etichetta.
    # [ENG] Define new Label object.
    $LinkLabel = New-Object System.Windows.Forms.LinkLabel
    # [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
    # [ENG] Position: From LEFT border, from TOP border.
    $LinkLabel.Location = New-Object System.Drawing.Size(100,59)
    # [ITA] Dimensione: LARGHEZZA, ALTEZZA.
    # [ENG] Dimensions: WIDTH, HEIGHT.
    $LinkLabel.Size = New-Object System.Drawing.Size(200,18)
    # [ITA] Colore del link.
    # [ENG] Link color.
    $LinkLabel.LinkColor = "#0074A2"
    # [ITA] Colore del link attivo.
    # [ENG] Active link color.
    $LinkLabel.ActiveLinkColor = "#114C7F"
    # [ITA] Testo dell'etichetta.
    # [ENG] Label's text.
    $LinkLabel.Text = "emanuele.tinari@gmail.com"
    # [ITA] Evento click sul link.
    # [ENG] Click event over link.
    $LinkLabel.add_Click({[system.Diagnostics.Process]::start("mailto:emanuele.tinari@gmail.com")})
    # [ITA] L'oggetto etichetta viene aggiunta alla Form.
    # [ENG] Label object is added to the Form.
    $obj_FrmCirca.Controls.Add($LinkLabel)
    #
    # [ITA] Pulsante OK Form Circa.
    # [ENG] About Form / Button OK.
    #
    # [ITA] Definisce il nuovo oggetto pulsante.
    # [ENG] Define new Button object.
    $obj_FrmCircaExit = New-Object System.Windows.Forms.Button
    # [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
    # [ENG] Position: From LEFT border, from TOP border.
    $obj_FrmCircaExit.Location = New-Object System.Drawing.Size(135,80)
    # [ITA] Testo del pulsante.
    # [ENG] Button's text.
    $obj_FrmCircaExit.Text = "OK"
    # [ITA] L'oggetto pulsante viene aggiunto alla Form.
    # [ENG] Button object is added to the Form.
    $obj_FrmCirca.Controls.Add($obj_FrmCircaExit)
    # [ITA] Su tasto ENTER.
    # [ENG] Accept button (on Enter).
    $obj_FrmCirca.AcceptButton = $obj_FrmCircaExit
    # [ITA] Su tasto ESC.
    # [ENG] Cancel button (on Esc).
    $obj_FrmCirca.CancelButton = $obj_FrmCircaExit
    # [ITA] La form viene mostrata.
    # [ENG] Form's shown.
    [void]$obj_FrmCirca.ShowDialog()
    # [ITA] Testo dell'etichetta della barra di stato.
    # [ENG] Status bar label text.
    $statusLabel.Text = "Pronto"
}
# [ITA] Fine Function Circa.
# [ENG] End Function Circa.
#
####################################################
# [ITA] Function per impostare la lingua italiana. #
# [ENG] Function for set italian language.         #
####################################################
#
Function LinguaItaliana
    {
        $statusLabel.Text = "Lingua italiana"
        $linguaImpostata = "Italiano"
        $statusLabel.Text = "Pronto"
        $menuItaliano.Text = "&Italiano"
        $menuInglese.Text = "&English"
        $menuInglese.ShortcutKeys = "Control, E"
        $menuAiuto.Text = "&Aiuto"
        $menuCirca.Text = "Su Sicurezza script"
        $menuAiuto.ShortcutKeys = "Control, A"
        # [ITA] Testo del pulsante SALVA della Form obj_Frm.
        # [ENG] obj_Frm's button SAVE text.
        $obj_BtnSalva.Text = "Salva" 
        # [ITA] Testo del BOTTONE ANNULLA della Form obj_Frm.
        # [ENG] obj_Frm's button RESET text.
        $obj_BtnAnnulla.Text = "Annulla" 
       # [ITA] Testo del BOTTONE CHIUDI della Form obj_Frm.
        # [ENG] obj_Frm's button CLOSE text.
        $obj_BtnChiudi.Text = "Chiudi" 
    }
#
###################################################
# [ITA] Function per impostare la lingua inglese. #
# [ENG] Function for set english language.        #
###################################################
#
Function LinguaInglese
    {
        $statusLabel.Text = "English language"
        $linguaImpostata = "Inglese"
        $statusLabel.Text = "Ready"
        $menuItaliano.Text = "&Italiano"
        $menuInglese.Text = "&English"
        $menuInglese.ShortcutKeys = "Control, E"
        $menuAiuto.Text = "&Help"
        $menuCirca.Text = "&About"
        $menuAiuto.ShortcutKeys = "Control, A"
        # [ITA] Testo del pulsante SALVA della Form obj_Frm.
        # [ENG] obj_Frm's button SAVE text.
        $obj_BtnSalva.Text = "Save" 
        # [ITA] Testo del BOTTONE ANNULLA della Form obj_Frm.
        # [ENG] obj_Frm's button RESET text.
        $obj_BtnAnnulla.Text = "Reset" 
        # [ITA] Testo del BOTTONE CHIUDI della Form obj_Frm.
        # [ENG] obj_Frm's button CLOSE text.
        $obj_BtnChiudi.Text = "Close" 
   }
#
#######################
# LABEL      obj_Lbl1 #OK tt
#######################
#
# [ITA] Definisce il nuovo oggetto Etichetta.
# [ENG] Define new Label object.
$obj_Lbl1 = New-Object System.Windows.Forms.Label
# [ITA] Testo dell'ETICHETTA.
# [ENG] Label text.
$obj_Lbl1.Text = "Undefined"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_Lbl1.Location = New-Object System.Drawing.Point(170,10) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_Lbl1.Size = New-Object System.Drawing.Size(105,25) 
# [ITA] L'oggetto Etichetta viene aggiunto alla Form.
# [ENG] Label object is added to the Form.
$obj_Frm.Controls.Add($obj_Lbl1)
#
#######################
# LABEL      obj_Lbl2 #OK tt
#######################
#
# [ITA] Definisce il nuovo oggetto Etichetta.
# [ENG] Define new Label object.
$obj_Lbl2 = New-Object System.Windows.Forms.Label
# [ITA] Testo dell'ETICHETTA.
# [ENG] Label text.
$obj_Lbl2.Text = "RemoteSigned"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_Lbl2.Location = New-Object System.Drawing.Point(285,10) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_Lbl2.Size = New-Object System.Drawing.Size(150,25) 
# [ITA] L'oggetto Etichetta viene aggiunto alla Form.
# [ENG] Label object is added to the Form.
$obj_Frm.Controls.Add($obj_Lbl2)
#
#######################
# LABEL      obj_Lbl3 #OK tt
#######################
#
# [ITA] Definisce il nuovo oggetto Etichetta.
# [ENG] Define new Label object.
$obj_Lbl3 = New-Object System.Windows.Forms.Label
# [ITA] Testo dell'ETICHETTA.
# [ENG] Label text.
$obj_Lbl3.Text = "AllSigned"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_Lbl3.Location = New-Object System.Drawing.Point(445,10) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_Lbl3.Size = New-Object System.Drawing.Size(105,25) 
# [ITA] L'oggetto Etichetta viene aggiunto alla Form.
# [ENG] Label object is added to the Form.
$obj_Frm.Controls.Add($obj_Lbl3)
#
#####################################
# Creo il gruppo per il CurrentUser #
#####################################
#
# [ITA] Definisce il nuovo oggetto GroupBox.
$obj_gBoxCU = New-Object System.Windows.Forms.GroupBox
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_gBoxCU.Location = New-Object System.Drawing.Point(10,55) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA (lo faccio alto quanto i CheckBox).
$obj_gBoxCU.Size = New-Object System.Drawing.Size(550,40)
# [ITA] Testo del GroupBox.
$obj_gBoxCU.Text = "CurrentUser:"
# [ITA] Nome del GroupBox.
$obj_gBoxCU.Name = "obj_gBoxCU" 
# [ITA] Rende visibile il GroupBox.
$obj_gBoxCU.Visible = $True
# QUESTE DUE RIGHE DI FORMATTAZIONE POI CANCELLARLE !!!
#$obj_gBoxCU.Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Regular)
#$obj_gBoxCU.BackColor = [System.Drawing.Color]::White
#
# [ITA] Aggiungo i tre CheckBox per il CurrentUser.
#
# [ITA] obj_CkBox1
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox1 = New-Object System.Windows.Forms.CheckBox 
# [ITA] Nome della CheckBox.
$obj_CkBox1.Name = "obj_CkBox1"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox1.Location = New-Object System.Drawing.Point(217,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox1.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Lo spunto perché è Undefined.
$obj_CkBox1.Checked = $True
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox1.TabIndex = 1
$obj_CkBox1.Text = "1"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox1.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxCU.Controls.Add($obj_CkBox1)
#
# [ITA] obj_CkBox1_1
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox1_1 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox1_1.Name = "obj_CkBox1_1"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox1_1.Location = New-Object System.Drawing.Point(351,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox1_1.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox1_1.TabIndex = 2
$obj_CkBox1_1.Text = "1_1"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox1_1.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxCU.Controls.Add($obj_CkBox1_1)
#
# [ITA] obj_CkBox1_2
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox1_2 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox1_2.Name = "obj_CkBox1_2"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox1_2.Location = New-Object System.Drawing.Point(476,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox1_2.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox1_2.TabIndex = 3
$obj_CkBox1_2.Text = "1_2"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox1_2.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxCU.Controls.Add($obj_CkBox1_2)
#
# [ITA] Aggiungo il GroupBox per il CurrentUser alla Form.
$obj_Frm.Controls.Add($obj_gBoxCU)
#
###########################################
# [ITA] Blocco evento Click per il CurrentUser  #
###########################################
#
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox1.Add_Click({
    If ($obj_CkBox1.Checked)
      {
        $obj_CkBox1_1.Checked = $False
        $obj_CkBox1_2.Checked = $False
      } 
    Else
      {
        $obj_CkBox1.Checked = $True
        $obj_CkBox1_1.Checked = $False
        $obj_CkBox1_2.Checked = $False
      }
})
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox1_1.Add_Click({
    If ($obj_CkBox1_1.Checked)
      {
        $obj_CkBox1.Checked = $False
        $obj_CkBox1_2.Checked = $False
      } 
    Else
      {
        $obj_CkBox1.Checked = $True
        $obj_CkBox1_1.Checked = $False
        $obj_CkBox1_2.Checked = $False
      }
})
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox1_2.Add_Click({
    If ($obj_CkBox1_2.Checked)
      {
        $obj_CkBox1.Checked = $False
        $obj_CkBox1_1.Checked = $False
      } 
    Else
      {
        $obj_CkBox1.Checked = $True
        $obj_CkBox1_1.Checked = $False
        $obj_CkBox1_2.Checked = $False
      }
})
#
######################################
# [ITA] Creo il gruppo per la LocalMachine #
######################################
#
# [ITA] Definisce il nuovo oggetto GroupBox.
$obj_gBoxLM = New-Object System.Windows.Forms.GroupBox
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_gBoxLM.Location = New-Object System.Drawing.Point(10,97) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA (lo faccio alto quanto i CheckBox).
$obj_gBoxLM.Size = New-Object System.Drawing.Size(550,40)
# [ITA] Testo del GroupBox.
$obj_gBoxLM.Text = "LocalMachine:" 
# [ITA] Nome del GroupBox.
$obj_gBoxLM.Name = "obj_gBoxLM" 
# [ITA] Rende visibile il GroupBox.
$obj_gBoxLM.Visible = $True
# QUESTE DUE RIGHE DI FORMATTAZIONE POI CANCELLARLE !!!
#$obj_gBoxLM.Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Regular)
#$obj_gBoxLM.BackColor = [System.Drawing.Color]::White
#
# [ITA] Aggiungo i tre CheckBox per la LocalMachine.
#
# [ITA] obj_CkBox2
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox2 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox2.Name = "obj_CkBox2"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox2.Location = New-Object System.Drawing.Point(217,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox2.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Lo spunto perché è Undefined.
$obj_CkBox2.Checked = $True
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox2.TabIndex = 4
$obj_CkBox2.Text = "2"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox2.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxLM.Controls.Add($obj_CkBox2)
#
# [ITA] obj_CkBox2_1
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox2_1 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox2_1.Name = "obj_CkBox2_1"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox2_1.Location = New-Object System.Drawing.Point(351,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox2_1.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox2_1.TabIndex = 5
$obj_CkBox2_1.Text = "2_1"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox2_1.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxLM.Controls.Add($obj_CkBox2_1)
#
# [ITA] obj_CkBox2_2
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox2_2 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox2_2.Name = "obj_CkBox2_2"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox2_2.Location = New-Object System.Drawing.Point(476,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox2_2.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox2_2.TabIndex = 6
$obj_CkBox2_2.Text = "2_2"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox2_2.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxLM.Controls.Add($obj_CkBox2_2)
#
# [ITA] Aggiungo il GroupBox per la LocalMachine alla Form.
$obj_Frm.Controls.Add($obj_gBoxLM)
#
############################################
# [ITA] Blocco evento Click per la LocalMachine  #
############################################
#
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox2.Add_Click({
    If ($obj_CkBox2.Checked)
      {
        $obj_CkBox2_1.Checked = $False
        $obj_CkBox2_2.Checked = $False
      } 
    Else
      {
        $obj_CkBox2.Checked = $True
        $obj_CkBox2_1.Checked = $False
        $obj_CkBox2_2.Checked = $False
      }
})
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox2_1.Add_Click({
    If ($obj_CkBox2_1.Checked)
      {
        $obj_CkBox2.Checked = $False
        $obj_CkBox2_2.Checked = $False
      } 
    Else
      {
        $obj_CkBox2.Checked = $True
        $obj_CkBox2_1.Checked = $False
        $obj_CkBox2_2.Checked = $False
      }
})
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox2_2.Add_Click({
    If ($obj_CkBox2_2.Checked)
      {
        $obj_CkBox2.Checked = $False
        $obj_CkBox2_1.Checked = $False
      } 
    Else
      {
        $obj_CkBox2.Checked = $True
        $obj_CkBox2_1.Checked = $False
        $obj_CkBox2_2.Checked = $False
      }
})
#
#######################################
# [ITA] Creo il gruppo per la MachinePolicy #
#######################################
#
# [ITA] Definisce il nuovo oggetto GroupBox.
$obj_gBoxMP = New-Object System.Windows.Forms.GroupBox
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_gBoxMP.Location = New-Object System.Drawing.Point(10,139) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA (lo faccio alto quanto i CheckBox).
$obj_gBoxMP.Size = New-Object System.Drawing.Size(550,40)
# [ITA] Testo del GroupBox.
$obj_gBoxMP.Text = "MachinePolicy:" 
# [ITA] Nome del GroupBox.
$obj_gBoxMP.Name = "obj_gBoxMP" 
$obj_gBoxCU.Visible = $True
# [ITA] Rende visibile il GroupBox.
$obj_gBoxMP.Visible = $True
# QUESTE DUE RIGHE DI FORMATTAZIONE POI CANCELLARLE !!!
#$obj_gBoxMP.Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Regular)
#$obj_gBoxMP.BackColor = [System.Drawing.Color]::White
#
# [ITA] Aggiungo i tre CheckBox per la MachinePolicy.
#
# [ITA] obj_CkBox3
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox3 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox3.Name = "obj_CkBox3"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox3.Location = New-Object System.Drawing.Point(217,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox3.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Lo spunto perché è Undefined.
$obj_CkBox3.Checked = $True
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox3.TabIndex = 7
$obj_CkBox3.Text = "3"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox3.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxMP.Controls.Add($obj_CkBox3)
#
# [ITA] obj_CkBox3_1
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox3_1 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox3_1.Name = "obj_CkBox3_1"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox3_1.Location = New-Object System.Drawing.Point(351,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox3_1.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox3_1.TabIndex = 8
$obj_CkBox3_1.Text = "3_1"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox3_1.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxMP.Controls.Add($obj_CkBox3_1)
#
# [ITA] obj_CkBox3_2
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox3_2 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox3_2.Name = "obj_CkBox3_2"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox3_2.Location = New-Object System.Drawing.Point(476,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox3_2.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox3_2.TabIndex = 9
$obj_CkBox3_2.Text = "3_2"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox3_2.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxMP.Controls.Add($obj_CkBox3_2)
#
# [ITA] Aggiungo il GroupBox per la MachinePolicy alla Form.
$obj_Frm.Controls.Add($obj_gBoxMP)
#
#############################################
# [ITA] Blocco evento Click per la MachinePolicy  #
#############################################
#
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox3.Add_Click({
    If ($obj_CkBox3.Checked)
      {
        $obj_CkBox3_1.Checked = $False
        $obj_CkBox3_2.Checked = $False
      } 
    Else
      {
        $obj_CkBox3.Checked = $True
        $obj_CkBox3_1.Checked = $False
        $obj_CkBox3_2.Checked = $False
      }
})
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox3_1.Add_Click({
    If ($obj_CkBox3_1.Checked)
      {
        $obj_CkBox3.Checked = $False
        $obj_CkBox3_2.Checked = $False
      } 
    Else
      {
        $obj_CkBox3.Checked = $True
        $obj_CkBox3_1.Checked = $False
        $obj_CkBox3_2.Checked = $False
      }
})
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox3_2.Add_Click({
    If ($obj_CkBox3_2.Checked)
      {
        $obj_CkBox3.Checked = $False
        $obj_CkBox3_1.Checked = $False
      } 
    Else
      {
        $obj_CkBox3.Checked = $True
        $obj_CkBox3_1.Checked = $False
        $obj_CkBox3_2.Checked = $False
      }
})
#
#################################
# [ITA] Creo il gruppo per il Process #
#################################
#
# [ITA] Definisce il nuovo oggetto GroupBox.
$obj_gBoxP = New-Object System.Windows.Forms.GroupBox
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_gBoxP.Location = New-Object System.Drawing.Point(10,181) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA (lo faccio alto quanto i CheckBox).
$obj_gBoxP.Size = New-Object System.Drawing.Size(550,40)
# [ITA] Testo del GroupBox.
$obj_gBoxP.Text = "Process:" 
# [ITA] Nome del GroupBox.
$obj_gBoxP.Name = "obj_gBoxP" 
# [ITA] Rende visibile il GroupBox.
$obj_gBoxP.Visible = $True
# QUESTE DUE RIGHE DI FORMATTAZIONE POI CANCELLARLE !!!
#$obj_gBoxP.Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Regular)
#$obj_gBoxP.BackColor = [System.Drawing.Color]::White
#
# [ITA] Aggiungo i tre CheckBox per il Process.
#
# [ITA] obj_CkBox4
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox4 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox4.Name = "obj_CkBox4"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox4.Location = New-Object System.Drawing.Point(217,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox4.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Lo spunto perché è Undefined.
$obj_CkBox4.Checked = $True
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox4.TabIndex = 10
$obj_CkBox4.Text = "4"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox4.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxP.Controls.Add($obj_CkBox4)
#
# [ITA] obj_CkBox4_1
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox4_1 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox4_1.Name = "obj_CkBox4_1"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox4_1.Location = New-Object System.Drawing.Point(351,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox4_1.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox4_1.TabIndex = 11
$obj_CkBox4_1.Text = "4_1"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox4_1.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxP.Controls.Add($obj_CkBox4_1)
#
# [ITA] obj_CkBox4_2
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox4_2 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox4_2.Name = "obj_CkBox4_2"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox4_2.Location = New-Object System.Drawing.Point(476,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox4_2.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox4_2.TabIndex = 12
$obj_CkBox4_2.Text = "4_2"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox4_2.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxP.Controls.Add($obj_CkBox4_2)
#
# [ITA] Aggiungo il GroupBox per il Process alla Form.
$obj_Frm.Controls.Add($obj_gBoxP)
#
######################################
# [ITA] Blocco evento Click per il Process #
######################################
#
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox4.Add_Click({
    If ($obj_CkBox4.Checked)
      {
        $obj_CkBox4_1.Checked = $False
        $obj_CkBox4_2.Checked = $False
      } 
    Else
      {
        $obj_CkBox4.Checked = $True
        $obj_CkBox4_1.Checked = $False
        $obj_CkBox4_2.Checked = $False
      }
})
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox4_1.Add_Click({
    If ($obj_CkBox4_1.Checked)
      {
        $obj_CkBox4.Checked = $False
        $obj_CkBox4_2.Checked = $False
      } 
    Else
      {
        $obj_CkBox4.Checked = $True
        $obj_CkBox4_1.Checked = $False
        $obj_CkBox4_2.Checked = $False
      }
})
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox4_2.Add_Click({
    If ($obj_CkBox4_2.Checked)
      {
        $obj_CkBox4.Checked = $False
        $obj_CkBox4_1.Checked = $False
      } 
    Else
      {
        $obj_CkBox4.Checked = $True
        $obj_CkBox4_1.Checked = $False
        $obj_CkBox4_2.Checked = $False
      }
})
#
####################################
# [ITA] Creo il gruppo per la UserPolicy #
####################################
#
# [ITA] Definisce il nuovo oggetto GroupBox.
$obj_gBoxUP = New-Object System.Windows.Forms.GroupBox
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_gBoxUP.Location = New-Object System.Drawing.Point(10,223) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA (lo faccio alto quanto i CheckBox).
$obj_gBoxUP.Size = New-Object System.Drawing.Size(550,40)
# [ITA] Testo del GroupBox.
$obj_gBoxUP.Text = "UserPolicy:" 
# [ITA] Nome del GroupBox.
$obj_gBoxUP.Name = "obj_gBoxUP" 
# [ITA] Rende visibile il GroupBox.
$obj_gBoxUP.Visible = $True
# QUESTE DUE RIGHE DI FORMATTAZIONE POI CANCELLARLE !!!
#$obj_gBoxUP.Font = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Regular)
#$obj_gBoxUP.BackColor = [System.Drawing.Color]::White
#
# [ITA] Aggiungo i tre CheckBox per la UserPolicy.
#
# [ITA] obj_CkBox5
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox5 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox5.Name = "obj_CkBox5"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox5.Location = New-Object System.Drawing.Point(217,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox5.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Lo spunto perché è Undefined.
$obj_CkBox5.Checked = $True
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox5.TabIndex = 13
$obj_CkBox5.Text = "5"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox5.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxUP.Controls.Add($obj_CkBox5)
#
# [ITA] obj_CkBox5_1
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox5_1 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox5_1.Name = "obj_CkBox5_1"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox5_1.Location = New-Object System.Drawing.Point(351,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox5_1.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox5_1.TabIndex = 14
$obj_CkBox5_1.Text = "5_1"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox5_1.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxUP.Controls.Add($obj_CkBox5_1)
#
# [ITA] obj_CkBox5_2
#
# [ITA] Definisce il nuovo oggetto CheckBox.
$obj_CkBox5_2 = New-Object System.Windows.Forms.Checkbox 
# [ITA] Nome della CheckBox.
$obj_CkBox5_2.Name = "obj_CkBox5_2"
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_CkBox5_2.Location = New-Object System.Drawing.Point(476,15) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_CkBox5_2.Size = New-Object System.Drawing.Size(70,20)
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_CkBox5_2.TabIndex = 15
$obj_CkBox5_2.Text = "5_2"
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
$obj_CkBox5_2.Add_MouseHover($MostraTooltip)
# [ITA] Aggiungo il CheckBox al GroupBox.
$obj_gBoxUP.Controls.Add($obj_CkBox5_2)
#
# [ITA] Aggiungo il GroupBox per il CurrentUser alla Form.
$obj_Frm.Controls.Add($obj_gBoxUP)
#
#########################################
# [ITA] Blocco evento Click per la UserPolicy #
#########################################
#
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox5.Add_Click({
    If ($obj_CkBox5.Checked)
      {
        $obj_CkBox5_1.Checked = $False
        $obj_CkBox5_2.Checked = $False
      } 
    Else
      {
        $obj_CkBox5.Checked = $True
        $obj_CkBox5_1.Checked = $False
        $obj_CkBox5_2.Checked = $False
      }
})
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox5_1.Add_Click({
    If ($obj_CkBox5_1.Checked)
      {
        $obj_CkBox5.Checked = $False
        $obj_CkBox5_2.Checked = $False
      } 
    Else
      {
        $obj_CkBox5.Checked = $True
        $obj_CkBox5_1.Checked = $False
        $obj_CkBox5_2.Checked = $False
      }
})
# [ITA] Aggiunge l'evento Click. 
$obj_CkBox5_2.Add_Click({
    If ($obj_CkBox5_2.Checked)
      {
        $obj_CkBox5.Checked = $False
        $obj_CkBox5_1.Checked = $False
      } 
    Else
      {
        $obj_CkBox5.Checked = $True
        $obj_CkBox5_1.Checked = $False
        $obj_CkBox5_2.Checked = $False
      }
})
#
##############################
# [ITA] BUTTON obj_BtnSalva. #OK tt
# [ENG] BUTTON obj_BtnSalva. #
##############################
#
# [ITA] Definisce il nuovo oggetto Button.
# [ENG] Define new object button.
$obj_BtnSalva = New-Object System.Windows.Forms.Button
# [ITA] Nome del BOTTONE.
# [ENG] Name of the object button.
$obj_BtnSalva.Name = "obj_BtnSalva"
# [ITA] Testo del BOTTONE.
# [ENG] Button text.
$obj_BtnSalva.Text = "Salva" 
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_BtnSalva.Location = New-Object System.Drawing.Point(10,300) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_BtnSalva.Size = New-Object System.Drawing.Size(120,50)
# [ITA] Imposto il carattere del pulsante.
# [ENG] Button's font.
$obj_BtnSalva.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold) 
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
# [ENG] Connector to MostraTooltip block with event _MouseHover for this control..
$obj_BtnSalva.Add_MouseHover($MostraTooltip)
# [ITA] Funzione che verrà eseguita cliccando sul pulsante.
# [ENG] Button's Function on click.
$obj_BtnSalva.Add_Click({Salva}) 
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_BtnSalva.TabIndex = 16
# [ITA] Aggiungo il pulsante alla Form.
# [ENG] Add Button to the Form.
$obj_Frm.Controls.Add($obj_BtnSalva)
#
################################
# [ITA] BUTTON obj_BtnAnnulla. #OK tt
# [ENG] BUTTON obj_BtnAnnulla. #
################################
#
# [ITA] Definisce il nuovo oggetto Button.
# [ENG] Define new object button.
$obj_BtnAnnulla = New-Object System.Windows.Forms.Button
# [ITA] Nome del BOTTONE.
# [ENG] Name of the object button.
$obj_BtnAnnulla.Name = "obj_BtnAnnulla"
# [ITA] Testo del BOTTONE.
# [ENG] Button text.
$obj_BtnAnnulla.Text = "Annulla" 
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_BtnAnnulla.Location = New-Object System.Drawing.Point(225,300) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_BtnAnnulla.Size = New-Object System.Drawing.Size(120,50)
# [ITA] Imposto il carattere del pulsante.
# [ENG] Button's font.
$obj_BtnAnnulla.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold) 
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
# [ENG] Connector to MostraTooltip block with event _MouseHover for this control..
$obj_BtnAnnulla.Add_MouseHover($MostraTooltip)
# [ITA] Funzione che verrà eseguita cliccando sul pulsante.
# [ENG] Button's Function on click.
$obj_BtnAnnulla.Add_Click({Annulla}) 
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_BtnAnnulla.TabIndex = 16
# [ITA] Aggiungo il pulsante alla Form.
# [ENG] Add Button to the Form.
$obj_Frm.Controls.Add($obj_BtnAnnulla)
#
###############################
# [ITA] BUTTON obj_BtnChiudi. #OK tt
# [ENG] BUTTON obj_BtnChiudi. #
###############################
#
# [ITA] Definisce il nuovo oggetto Button.
# [ENG] Define new object button.
$obj_BtnChiudi = New-Object System.Windows.Forms.Button
# [ITA] Nome del BOTTONE.
# [ENG] Name of the object button.
$obj_BtnChiudi.Name = "obj_BtnChiudi"
# [ITA] Testo del BOTTONE.
# [ENG] Button text.
$obj_BtnChiudi.Text = "Chiudi" 
# [ITA] Posizione: Distanza dal bordo SINISTRO, Distanza dal bordo IN ALTO.
# [ENG] Position: From LEFT border, from TOP border.
$obj_BtnChiudi.Location = New-Object System.Drawing.Point(440,300) 
# [ITA] Dimensione: LARGHEZZA, ALTEZZA.
# [ENG] Dimensions: WIDTH, HEIGHT.
$obj_BtnChiudi.Size = New-Object System.Drawing.Size(120,50)
# [ITA] Imposto il carattere del pulsante.
# [ENG] Button's font.
$obj_BtnChiudi.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold) 
# [ITA] Si connette al blocco MostraTooltip con l'evento _MouseHover per questo controllo.
# [ENG] Connector to MostraTooltip block with event _MouseHover for this control..
$obj_BtnChiudi.Add_MouseHover($MostraTooltip)
# [ITA] Funzione che verrà eseguita cliccando sul pulsante.
# [ENG] Button's Function on click.
$obj_BtnChiudi.Add_Click({Chiudi}) 
# [ITA] Ordine di tabulazione.
# [ENG] Tab order.
$obj_BtnChiudi.TabIndex = 17
# [ITA] Aggiungo il pulsante alla Form.
# [ENG] Add Button to the Form.
$obj_Frm.Controls.Add($obj_BtnChiudi) 
#
#################################
# [ITA] Mostra la Form obj_Frm. #OK tt
# [ENG] Show Form obj_Frm.      #
#################################
#
# [ITA] La form viene mostrata.
# [ENG] Form's shown.
$obj_Frm.ShowDialog()


#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope MachinePolicy
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope UserPolicy
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine

# Legge e mostra i permessi di esecuzione degli Script Powershell nel PC.
#Get-ExecutionPolicy -List