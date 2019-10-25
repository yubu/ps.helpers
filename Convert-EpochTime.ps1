
Function convertFrom-Epoch {
	<#
	.Synopsis
		Convert from epoch time to human
	.Description
		Convert from epoch time to human
	.Example
		convertFrom-epoch 1295113860
	.Example
		convertFrom-epoch 1295113860 | convertTo-epoch
	#>
	[CmdletBinding()]
	param ([Parameter(ValueFromPipeline=$true)]$epochdate)

	process {
		if (!$psboundparameters.count) {gh -ex $PSCmdlet.MyInvocation.MyCommand.Name | out-string | remove-emptylines; return}
		if (("$epochdate").length -gt 10 ) {
			if (("$epochdate").Contains('.')) {
				$seconds=("$epochdate").Split('.')[0]
				$millis=("$epochdate").Split('.')[1]
				$epochdate=$seconds+($millis[0..2] -join "")
				(Get-Date -Date "01/01/1970").AddMilliseconds($epochdate)
			}
			else {(Get-Date -Date "01/01/1970").AddMilliseconds($epochdate)}
		}
		else {(Get-Date -Date "01/01/1970").AddSeconds($epochdate)}
	}
}

Function convertTo-Epoch {
    <#
	.Synopsis
		Convert time to epoch
	.Description
		Convert time to epoch
	.Example
		convertTo-epoch (get-date -date "05/24/2015 17:05")
    .Example
        convertTo-epoch (get-date -date "05/24/2015 17:05") | convertFrom-epoch
    .Example
        (get-date -date "05/24/2015 17:05") | convertTo-epoch
    .Example 
        get-date | convertTo-epoch
    .Example
        convertTo-epoch (get-date).ToUniversalTime()
    .Example
        convertTo-epoch (get-date).ToUniversalTime() | convertFrom-epoch
    .Example
        convertTo-epoch ((get-date).AddHours(2))    
	#>
	[CmdletBinding()]
	param (
		[Parameter(ValueFromPipeline=$true)]$date
	)
	
	process {
		if (!$psboundparameters.count) {
			if (gcm rmel -ea ignore) {help -ex $PSCmdlet.MyInvocation.MyCommand.Name | Out-String | Remove-EmptyLines; return}
			else {help -ex $PSCmdlet.MyInvocation.MyCommand.Name; return}
		}
		if ($date.GetType().name -eq "string" ) {
			try {[void](get-date -date $date)}
			catch {
				Write-Host "`nERROR: $_" -f red
				Write-Host "`nDateTime formatting defaults on this system:" -f cyan
				get-culture | select -ExpandProperty DateTimeFormat | select *pattern*,@{n='ShortDateTimePattern';e={$_.ShortDatePattern+" "+ $_.ShortTimePattern}}
				""
				Write-Host "For all supported formats on this system run PS C:\>intl.cpl" -f magenta
				""
				Write-Host "For further DateTime formatting information look here:" -f cyan
				"https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-5.1"
				"https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings?view=netframework-4.8"
				""
				if (gcm rmel -ea ignore) {help -ex $PSCmdlet.MyInvocation.MyCommand.Name | Out-String | Remove-EmptyLines}
				else {help -ex $PSCmdlet.MyInvocation.MyCommand.Name}
				return
			}
		}
		else {}
		
		$date=$date -f "mm/dd/yyyy hh:mm"
		(New-TimeSpan -Start (Get-Date -Date "01/01/1970") -End $date).TotalSeconds
	}
} 
