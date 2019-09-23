function Out-Hash {
	<#
	.Synopsis
	   	Output string hash. Supported hash algorithms: SHA,SHA1,MD5,SHA256,SHA-256,SHA384,SHA-384,SHA512,SHA-512. Supported encoding: UTF8,ASCII,UTF7,UTF32,BigEndianUnicode.
	.Description
	   	Output string hash. Supported hash algorithms: SHA,SHA1,MD5,SHA256,SHA-256,SHA384,SHA-384,SHA512,SHA-512. Supported encoding: UTF8,ASCII,UTF7,UTF32,BigEndianUnicode.
	.Example
		'string1','string2' | Out-Hash -Algorithm SHA256 -Encoding UTF8
		Get hash
	.Example
		(0..20) | %{"string"+(get-random)} | out-hash
		Get hash
	.Example
		gc c:\strings-to-hash.txt | ohash -Algorithm md5
		Get hash
	#>
	[Alias("ohash")]
	param (
		[Parameter(Mandatory=$False,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True,Position=0)][string]$in,
		[Parameter(Mandatory=$False,ValueFromPipeline=$False,ValueFromPipelineByPropertyName=$False)][ValidateSet("SHA","SHA1","MD5","SHA256","SHA-256","SHA384","SHA-384","SHA512","SHA-512")][string]$Algorithm="SHA1",
		[Parameter(Mandatory=$False,ValueFromPipeline=$False,ValueFromPipelineByPropertyName=$False)][ValidateSet("UTF8","ASCII","UTF7","UTF32","BigEndianUnicode")][string]$Encoding="UTF8"
	)
	begin {}
	
	process {

		if (!$psboundparameters.count) {Get-Help -ex $PSCmdlet.MyInvocation.MyCommand.Name | oss | Remove-EmptyLines; return}
		
		$hash=([System.Security.Cryptography.HashAlgorithm]::Create("$Algorithm").ComputeHash([System.Text.Encoding]::$Encoding.GetBytes("$in")) | % tostring x2).toUpper() -join ""
		write-verbose "`nAlgorithm: $Algorithm Encoding: $encoding"
		$hash
	}
}