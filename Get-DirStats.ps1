# Get-DirStats.ps1
# Outputs file system directory statistics.

#Requires -version 2

	<#
		.SYNOPSIS
			Outputs file system directory statistics.

		.DESCRIPTION
			Outputs file system directory statistics (number of files and the sum of all file sizes) for one or more directories.

		.PARAMETER Path
			Specifies a path to one or more file system directories. Wildcards are not permitted. The default path is the current directory (.).

		.PARAMETER LiteralPath
			Specifies a path to one or more file system directories. Unlike Path, the value of LiteralPath is used exactly as it is typed.

		.PARAMETER Only
			Outputs statistics for a directory but not any of its subdirectories.

		.PARAMETER Every
			Outputs statistics for every directory in the specified path instead of only the first level of directories.

		.PARAMETER FormatNumbers
			Formats numbers in the output object to include thousands separators.

		.PARAMETER Total
			Outputs a summary object after all other output that sums all statistics.
	#>

	[CmdletBinding(DefaultParameterSetName="Path")]

	Param
		(
			[Parameter(
				Position=0,
				Mandatory=$False,
				ParameterSetName="Path",
				ValueFromPipeline=$True)]
				$Path=(Get-Location).Path,

			[Parameter(
				Position=0,
				Mandatory=$True,
				ParameterSetName="LiteralPath")]
			[String[]] $LiteralPath,
			
			[Switch] $Only,
			
			[Switch] $Every,
			
			[Switch] $FormatNumbers,
			
			[Switch] $Total
		)

	Begin {

		$ParamSetName = $PSCmdlet.ParameterSetName

		If ( $ParamSetName -eq "Path" ) {
			$PipelineInput = ( -not $PSBoundParameters.ContainsKey("Path") ) -and ( -not $Path )
		}
		ElseIf ( $ParamSetName -eq "LiteralPath" ) {
			$PipelineInput = $False
		}

		# Script-level variables used with -Total.
		[UInt64] $script:TotalCount = 0
		[UInt64] $script:TotalBytes = 0

		# Returns a [System.IO.DirectoryInfo] object if it exists.
		Function Get-Directory {

			Param( $item )

			If ( $ParamSetName -eq "Path" ) {

				If ( Test-Path -Path $item -PathType Container ) {
					$item = Get-Item -Path $item -Force
				}
			}
			ElseIf ( $ParamSetName -eq "LiteralPath" ) {

				If ( Test-Path -LiteralPath $item -PathType Container ) {
					$item = Get-Item -LiteralPath $item -Force
				}
			}

			If ( $item -and ($item -is [System.IO.DirectoryInfo]) ) {
				Return $item
			}
		}

		# Filter that outputs the custom object with formatted numbers.
		Function Format-Output {

			process {
				$_ | Select-Object Path,
				@{Name="Files"; Expression={"{0:N0}" -f $_.Files}},
				@{Name="Size"; Expression={"{0:N0}" -f $_.Size}}
			}
		}

		# Outputs directory statistics for the specified directory. With -recurse,
		# the function includes files in all subdirectories of the specified
		# directory. With -format, numbers in the output objects are formatted with
		# the Format-Output filter.
		Function Get-DirectoryStats {

			Param( $directory, $recurse, $format )

			Write-Progress -Activity "Get-DirStats.ps1" -Status "Reading '$($directory.FullName)'"
			$files = $directory | Get-ChildItem -Force -Recurse:$recurse | Where-Object { -not $_.PSIsContainer }

			If ( $files ) {

				Write-Progress -Activity "Get-DirStats.ps1" -Status "Calculating '$($directory.FullName)'"
				$output = $files | Measure-Object -Sum -Property Length | Select-Object `
				@{Name="Path"; Expression={$directory.FullName}},
				@{Name="Files"; Expression={$_.Count; $script:TotalCount += $_.Count}},
				@{Name="Size"; Expression={$_.Sum; $script:TotalBytes += $_.Sum}}

			}

			Else {

				$output = "" | Select-Object `
				@{Name="Path"; Expression={$directory.FullName}},
				@{Name="Files"; Expression={0}},
				@{Name="Size"; Expression={0}}
			}

			If ( -not $format ) {

				$output

			}

			Else {

				$output | Format-Output

			}
			}
	}

	Process {

		# Get the item to process, no matter whether the input comes from the
		# pipeline or not.
		If ( $PipelineInput ) {

			$item = $_

		}

		Else {

			If ( $ParamSetName -eq "Path" ) {

				$item = $Path

			}

			Elseif ( $ParamSetName -eq "LiteralPath" ) {

				$item = $LiteralPath

			}
		}

		# Write an error if the item is not a directory in the file system.
		$directory = Get-Directory -item $item

		If ( -not $directory ) {

			Write-Error -Message "Path '$item' is not a directory in the file system." -Category InvalidType
			Return

		}

		# Get the statistics for the first-level directory.
		Get-DirectoryStats -directory $directory -recurse:$False -format:$FormatNumbers

		# -Only means no further processing past the first-level directory.
		If ( $Only ) {

			Return

		}

		# Get the subdirectories of the first-level directory and get the statistics
		# for each of them.
		$directory | Get-ChildItem -Force -Recurse:$Every |
		Where-Object { $_.PSIsContainer } | ForEach-Object {
		Get-DirectoryStats -directory $_ -recurse:(-not $Every) -format:$FormatNumbers
		} | Format-Table -AutoSize
	}

	End {

		# If -Total specified, output summary object.
		If ( $Total ) {

			$output = "" | Select-Object `
			@{Name="Path"; Expression={"<Total>"}},
			@{Name="Files"; Expression={$script:TotalCount}},
			@{Name="Size"; Expression={$script:TotalBytes}}

			If ( -not $FormatNumbers ) {

				$output

			}

			Else {

				$output | Format-Output

			}
		}
	}