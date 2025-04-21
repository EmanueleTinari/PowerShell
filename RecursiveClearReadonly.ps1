# Released to the Public Domain
# See https://gist.github.com/ullet/867c32c3a22dcf12a9cf

# Recursively clear read-only flag for all files in current directory and 
# sub-directories.

Get-ChildItem . -Recurse | 
  Where-Object {-not $_.PSIsContainer} | 
  Set-ItemProperty -name IsReadOnly -value $false