function Remove-EmptyLines {
	<#
	.Synopsis
		Remove empty lines from file, string or variable
	.Description
		Remove empty lines from file, string or variable
	.Example
		Remove-EmptyLines -in (gc c:\file.txt)
	.Example
		$var | Remove-EmptyLines
	.Example
        help -ex Remove-EmptyLines | Remove-EmptyLines 
    .Example
        Get-Content *.txt | rmel
    .Example
        Get-ClipBoard | rmel
    .Example
        dir | oss | rmel
    .Example
        dir c:\windows -Recurse | oss | rmel | more
    .Example
        get-help dir | oss | rmel | more
	#>
	[cmdletbinding()]
    [Alias("rmel")]
    param ([parameter(mandatory=$false,position=0,ValueFromPipeline=$true)][array]$in)
    
    begin {$err=""}
    process {
        if (!$psboundparameters.count) {
            help -ex Remove-EmptyLines | out-string | Remove-EmptyLines
            return
        }
        try {$in.split("`r`n") | ? {$_.trim() -ne ""}}
        catch {$err=$_.Exception}
    }
    end {
        if ($err) {Write-Host "ERROR: Use 'out-string -stream' (oss)!" -f red -nonewline; Write-Host "`nExample: dir | oss | rmel. Example: get-help dir | oss | rmel." -f cyan}
    }
}
