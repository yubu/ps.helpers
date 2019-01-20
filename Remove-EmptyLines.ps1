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
	#>
	[cmdletbinding()]
    [Alias("rmel")]
    param ([parameter(mandatory=$false,position=0,ValueFromPipeline=$true)][array]$in)
    
    process {
        if (!$psboundparameters.count) {
            help -ex Remove-EmptyLines | out-string | Remove-EmptyLines
            return
        }
        $in.split("`r`n") | ? {$_.trim() -ne ""}
    }
}