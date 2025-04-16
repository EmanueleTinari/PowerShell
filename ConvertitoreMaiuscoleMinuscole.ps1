Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Function CopiaNellaClip{ 
    $TestoCopiato = $TextBox2.Text
    [System.Windows.Forms.Clipboard]::SetText($TestoCopiato)
    if ([System.Windows.Forms.Clipboard]::ContainsText() -AND
        [System.Windows.Forms.Clipboard]::GetText() -eq $TestoCopiato)
    {
        $BarraDiStato.Text = "Testo copiato negli Appunti con successo !"
        Timeout /T 2
        $BarraDiStato.Text = "Pronto"
    }
    else
    {
        $BarraDiStato.Text = "Testo NON copiato"
    }
}

Function SvuotaClip{ 
    [System.Windows.Forms.Clipboard]::Clear()
    $BarraDiStato.Text = "Appunti svuotati !"
    Timeout /T 2
    $BarraDiStato.Text = "Pronto" }

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
# Using System.Drawing.Font class to format the font style of label.
$Font = New-Object System.Drawing.Font("Times New Roman",18) 
$mainForm.Font = $Font 
$mainForm.Text = "Convertitore MAIUSCOLE / minuscole"
$mainForm.Width = 650
$mainForm.Height = 380
$mainForm.StartPosition = 'CenterScreen'

# Barra di stato
$BarraDiStato = New-Object System.Windows.Forms.StatusBar
$BarraDiStato.Width = 200
$BarraDiStato.Height = 30
$BarraDiStato.Text = "Pronto"
$BarraDiStato.Location = New-Object System.Drawing.Point( 0, 450 )
$mainForm.Controls.Add($BarraDiStato)

# TextBox1
$TextBox1 = New-Object System.Windows.Forms.TextBox
$TextBox1.Multiline = $True;
$TextBox1.Font = $Font
$TextBox1.Location = New-Object System.Drawing.Size(10,10)           # Da sinistra, dall'alto
$TextBox1.Size = New-Object System.Drawing.Size(610,100)             # Larghezza, Altezza
$TextBox1.ScrollBars = "Both"                                        # Valori possibili: Vertical, Horizontal, Both
$TextBox1.Add_TextChanged({

    $Testo1 = $TextBox1.Text.Trim()

    Write-Host $Testo1
    
    if ( $Testo1.Length -ge 1 )   # Più grande o uguale a (Greater Or Equal)
    {
        $Testo2 = $Testo1.Substring(0,1).ToUpper() + $Testo1.Substring(1).ToLower()
        $BottoneCopia.Enabled = $true
    }
    else
    {
        $Testo2 = ""
        $BottoneCopia.Enabled = $false
    }

    $TextBox2.Text = $Testo2

})
$mainForm.Controls.Add($TextBox1)

# TextBox2
$TextBox2 = New-Object System.Windows.Forms.TextBox
$TextBox2.Multiline = $True;
$TextBox2.Font = $Font
$TextBox2.Location = New-Object System.Drawing.Size(10,120)          # Da sinistra, dall'alto
$TextBox2.Size = New-Object System.Drawing.Size(610,100)             # Larghezza, Altezza
$TextBox2.ScrollBars = "Both"                                        # Valori possibili: Vertical, Horizontal, Both
$mainForm.Controls.Add($TextBox2)

# Bottone Copia 
$BottoneCopia = New-Object System.Windows.Forms.Button
$BottoneCopia.Location = New-Object System.Drawing.Size(10,230)  # Da sinistra, dall'alto
$BottoneCopia.Size = "150,50"
$BottoneCopia.Text = "&Copia"
$BottoneCopia.Enabled = $false
$BottoneCopia.add_Click({ CopiaNellaClip })
$mainForm.Controls.Add($BottoneCopia)

# Bottone Svuota 
$BottoneSvuota = New-Object System.Windows.Forms.Button
$BottoneSvuota.Location = New-Object System.Drawing.Size(240,230)  # Da sinistra, dall'alto
$BottoneSvuota.Size = "150,50"
$BottoneSvuota.Text = "&Svuota"
$BottoneSvuota.add_click({$mainForm.Controls |
    Where-Object{ $_ -is [system.windows.forms.textbox] } | 
    ForEach-Object{ $_.Clear() }
    SvuotaClip })
$mainForm.Controls.Add($BottoneSvuota)

# Bottone Esci 
$BottoneEsci = New-Object System.Windows.Forms.Button
$BottoneEsci.Location = New-Object System.Drawing.Size(470,230)      # Da sinistra, dall'alto
$BottoneEsci.Size = "150,50"
$BottoneEsci.Text = "&Esci"
$BottoneEsci.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$mainForm.Controls.Add($BottoneEsci)

$mainForm.Add_Shown({$TextBox1.Select()})
$mainForm.ShowDialog()