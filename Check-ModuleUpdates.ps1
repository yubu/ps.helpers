function Check-moduleUpdates {
	<#
	.Synopsis
		Check poweshell modules for updates
	.Description
		Check powershell modules for updates
	.Example
		Check-moduleUpdates
		Check modules in use for updates
	.Example
		Check-moduleUpdates -all
		Check all available modules for updates 
	.Example
		Check-moduleUpdates PowershellGet -all
		Check module PowershellGet for updates
	.Example
		Check-moduleUpdates -update -skipUpdate "PSReadLine"
		Will update all modules in use except module PSReadLine
	.Example
		Check-moduleUpdates -all -update
		Will try to update all available modules
	.Example
		Check-moduleUpdates -all -update -skipUpdate "PSReadLine|PSWindowsUpdate"
		Will update all modules available except modules PSReadLine and PSWindowsUpdate
	.Example
		Check-moduleUpdates -all -skipUpdate "VMware.VimAutomation.Srm|VMware.VimAutomation.Storage"
		For PowerCLI only VMware.PowerCLI should be installed	
	#>
	[CmdletBinding()]
	[Alias("cmu")]
	param([switch]$update,[switch]$all,$module="",$skipUpdate="")
	
	$exclude="bitstransfer"
	[string[]]$changelist=""
	
	if ($all) {get-module -ListAvailable | ? name -notmatch "$exclude" | ? name -match "$module" | select -Unique -pv localModule | %{"--> $_ --> $($_.author)", $_.version.ToString(), (find-module -name $_ -ea silent | %{if ([version]$_.version -gt $localModule.version) {$_.version + "  <--"; [array]$changelist+=$localModule.name} else {($_.version).tostring()} })}}
	else {get-module | ? name -notmatch "$exclude" | ? name -match "$module" | select -Unique -pv localModule | %{"--> $_ --> $($_.author)", $_.version.ToString(), (find-module -name $_ -ea silent | %{if ([version]$_.version -gt $localModule.version) {$_.version.ToString() + "  <--"; [array]$changelist+=$localModule.name} else {$_.version.ToString()} })}}
	
	$changelist=$changelist | ?{$_}
	if ($skipUpdate) {$changelist=$changelist | ?{$_ -notmatch "$skipUpdate"} | ?{$_}}

	if (!$changelist -and !$skipUpdate) {write-host "All is up to date." -f green}
	elseif (!$changelist -and $skipUpdate) {write-host "All is up to date." -f green; write-host "Module(s) skipped: " -f green -nonewline; write-host "$skipUpdate" -f yellow}
	elseif ($changelist -and $skipUpdate) {Write-Host "Module(s) to update: " -f yellow -nonewline; Write-Host "$changelist" -f red; write-host "Module(s) skipped: " -f green -nonewline; write-host "$skipUpdate" -f yellow}
	elseif ($update -and $skipUpdate -and !$changelist) {write-host "All is up to date." -f green; write-host "Module(s) skipped: " -f green -nonewline; write-host "$skipUpdate" -f yellow}
	else {Write-Host "Module(s) to update: " -f yellow -nonewline; Write-Host "$changelist" -f red}
	if ($update -and $changelist) {Write-Output "`nWill update: $changelist ..."; install-module $changelist -force -allowClobber}
}