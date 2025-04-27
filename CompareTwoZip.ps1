
Add-Type -AN System.IO.Compression.FileSystem
$zip1 = [IO.Compression.ZipFile]::OpenRead("C:\test\test1.zip") # Insert your path + file here.
$zip2 = [IO.Compression.ZipFile]::OpenRead("C:\test\test2.zip") # Insert your path + file here.
$names1 = $zip1.Entries.FullName
$names2 = $zip2.Entries.FullName
$Counter = (Compare-Object $names1 $names2).count
$zip1.Dispose()
$zip2.Dispose()
Write-Host $Counter -Verbose
