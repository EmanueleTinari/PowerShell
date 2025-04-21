$global:workPath = "$PSCommandPath"
$local:temp = Split-Path $PSCommandPath
$global:scriptPath = "$temp"
$temp = ""
$global:Cn = $env:COMPUTERNAME
$global:Un = $env:USERNAME
$global:Os = $env:PROCESSOR_ARCHITECTURE

$scriptPath = $scriptPath + "\" + 'PassVariablesDataToAnotherPS1_FileB.ps1'
& $scriptPath  $Cn $Un $Os

$global:Cn = ""
$global:Un = ""
$global:Os = ""