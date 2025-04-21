Add-Type -AN System.IO.Compression.FileSystem
$zip1 = [IO.Compression.ZipFile]::OpenRead("c:\test\test1.zip")
$zip2 = [IO.Compression.ZipFile]::OpenRead("c:\test\test2.zip")
$names1 = $zip1.Entries.FullName
$names2 = $zip2.Entries.FullName
$counter = (diff $names1 $names2).count
$zip1.Dispose()
$zip2.Dispose()