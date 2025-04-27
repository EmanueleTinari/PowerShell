Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Themes" Width="300" Height="200">
        <Window.Resources>
            <ResourceDictionary>
                <ResourceDictionary.MergedDictionaries>
                    <ResourceDictionary Source="pack://application:,,,/PresentationFramework.Luna;component/Themes/Luna.normalColor.xaml" />
                </ResourceDictionary.MergedDictionaries>
            </ResourceDictionary>
        </Window.Resources>

    <StackPanel>
        <Label Content="Hello World"/>
        <Button Name="ButtonClassic" Content="Classic"/>
        <Button Name="ButtonLuna" Content="Luna"/>
        <Button Name="ButtonAero" Content="Aero"/>
        <CheckBox Content="CheckBox"/>
        <RadioButton Content="RadioButton"/>
    </StackPanel>
</Window>
"@

$reader = [System.Xml.XmlNodeReader]::new($xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
$xaml.SelectNodes('//*[@Name]') | ForEach-Object { Set-Variable -Name $_.Name -Value $window.FindName($_.Name) }

$ButtonClassic.Add_Click({
    $window.Resources.MergedDictionaries.Clear()
    $dicClassic = [System.Windows.ResourceDictionary]::new()
    $dicClassic.Source = [uri]::new("pack://application:,,,/PresentationFramework.Classic;component/Themes/Classic.xaml")
    $window.Resources.MergedDictionaries.Add($dicClassic)
})
$ButtonLuna.Add_Click({
    $window.Resources.MergedDictionaries.Clear()
    $dicLuna = [System.Windows.ResourceDictionary]::new()
    $dicLuna.Source = [uri]::new("pack://application:,,,/PresentationFramework.Luna;component/Themes/Luna.normalColor.xaml")
    $window.Resources.MergedDictionaries.Add($dicLuna)
})
$ButtonAero.Add_Click({
    $window.Resources.MergedDictionaries.Clear()
    $dicAero = [System.Windows.ResourceDictionary]::new()
    $dicAero.Source = [uri]::new("pack://application:,,,/PresentationFramework.Aero;component/Themes/Aero.normalColor.xaml")
    $window.Resources.MergedDictionaries.Add($dicAero)
})

$window.ShowDialog()