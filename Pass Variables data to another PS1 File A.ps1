Set-Variable -Scope Global -Name "__cName" -Description "Here is stored the computer name." -Value ($env:COMPUTERNAME)
Set-Variable -Scope Global -Name "__uName" -Description "Here is stored the user name." -Value ($env:USERNAME)
Set-Variable -Scope Global -Name "__oArch" -Description "Here is stored the architecture of the processor." -Value ($env:PROCESSOR_ARCHITECTURE)

# Another way to launch second script. For PowerShell 1 and 2.
# & "$(Split-Path $MyInvocation.MyCommand.Path)/Pass Variables data to another PS1 File B.ps1"  $__cName $__uName $__oArch

# For PowerShell => 3.
# "" Mandatory in Command if file name or path containing spaces!
& "$PSScriptRoot\Pass Variables data to another PS1 File B.ps1"  $__cName $__uName $__oArch

$__cName    = ""
$__uName    = ""
$__oArch    = ""
Pause