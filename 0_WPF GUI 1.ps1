Add-Type -AssemblyName PresentationFramework

# Create the application window
$Window = New-Object System.Windows.Window
$Window.Width = 800
$Window.Height = 600

# Create the grid
$Grid = New-Object System.Windows.Controls.Grid

# Define 3 rows and 3 columns
$Grid.RowDefinitions.Add((New-Object System.Windows.Controls.RowDefinition))
$Grid.RowDefinitions.Add((New-Object System.Windows.Controls.RowDefinition))
$Grid.RowDefinitions.Add((New-Object System.Windows.Controls.RowDefinition))

$Grid.ColumnDefinitions.Add((New-Object System.Windows.Controls.ColumnDefinition))
$Grid.ColumnDefinitions.Add((New-Object System.Windows.Controls.ColumnDefinition))
$Grid.ColumnDefinitions.Add((New-Object System.Windows.Controls.ColumnDefinition))

# Add a label to Row 0, Column 0
$Label = New-Object System.Windows.Controls.Label
$Label.Content = "Hello World"
[System.Windows.Controls.Grid]::SetRow($Label, 0) 
[System.Windows.Controls.Grid]::SetColumn($Label, 0)
$Grid.Children.Add($Label)

$Window.Content = $Grid
$Window.ShowDialog()