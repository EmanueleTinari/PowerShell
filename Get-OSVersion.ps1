Function Get-OSVersion {

	$NewObj		= New-Object PSObject

	$OSCaption	= $((Get-CimInstance -class Win32_OperatingSystem).Caption)
	$IsWin7		= $(($OSCaption).Contains("Windows 7"))
	$IsWin8		= $(($OSCaption).Contains("Windows 8"))
	$IsWin10	= $(($OSCaption).Contains("Windows 10"))
	$IsWin11	= $(($OSCaption).Contains("Windows 11"))

	$VersNo		=	If($IsWin11) {
						11
					}
					ElseIf($IsWin10) {
						10
					}
					ElseIf($IsWin8) {
						8
					}
					Elseif($IsWin7) {
						7
					}
					Else {
						$null
					}

	$OSVersion	= [System.Environment]::OSVersion.Version

	$IsWin10AE	=	If($OSVersion.Major -eq 10 -and $OSVersion.build -ge 14393) {
						$True
					}
					Else {
						$False
					}

	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name Caption		-Value $($OSCaption)
	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name IsWin7		-Value $($IsWin7)
	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name IsWin8		-Value $($IsWin8)
	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name IsWin10		-Value $($IsWin10)
	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name IsWin11		-Value $($IsWin11)
	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name IsWin10AE	-Value $($IsWin10AE)
	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name Version		-Value $($VersNo)
	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name Major		-Value $($OSVersion.Major)
	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name Minor		-Value $($OSVersion.Minor)
	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name Build		-Value $($OSVersion.Build)
	Add-Member -InputObject $NewObj -MemberType NoteProperty -Name Revision		-Value $($OSVersion.Revision)

	Return $NewObj
}