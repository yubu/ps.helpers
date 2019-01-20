# Helpers
## Files
- Check-ModuleUpdates.ps1: Checks updates for modules
Creates sched task if needed
```powershell
. C:\Helpers\Check-moduleUpdates.ps1
Functions: Check-moduleUpdates
Check-moduleUpdates -createSchedTask
Check-moduleUpdates -all -sendToast 
```
- Convert-EpochTime.ps1: Converts from/to epoch/UNIX time
```powershell
. C:\Helpers\Check-ModuleUpdates.ps1
Functions: ConvertFrom-Epoch, ConvertTo-Epoch
```
- Get-OneNoteHelp.ps1: OneNote useful keybindings
```powershell
. C:\Helpers\Get-OneNoteKeyBindingsHelp.ps1
Functions: Get-OneNoteKeyBindingsHelp
```
- Get-VScodeKeybindings.ps1: VScode keybindings
```powershell
. C:\Helpers\Get-VScodeKeybindings.ps1
Functions: Get-VScodeKeybindings
```
- Get-WinConrolPanelHelp.ps1: Windows control.exe commands
```powershell
. C:\Helpers\Get-WinConrolPanelHelp.ps1
Functions: Get-WinConrolPanelHelp
```
- Get-WinKeyHelp.ps1: Windows WinKey keybindings
```powershell
. C:\Helpers\Get-WinKeyHelp.ps1
Functions: Get-WinKeyHelp
```
- Get-WinShellCommandHelp.ps1: Windows shell commands
```powershell
. C:\Helpers\Get-WinShellCommandHelp.ps1
Functions: Get-WinShellCommandHelp
```
- Remove-EmptyLines.ps1: 
Remove empty lines from standard output, files and vars:
  - Try: Get-Help gcim -Examples
  - Try: Get-Help gcim -Examples | oss | rmel
  - Try, if module find-string installed: Get-Help gcim -Examples | oss | rmel | sls Example -Context 10 | Out-ColorMatchInfo
```powershell
. C:\Helpers\Remove-EmptyLines.ps1
Functions: Remove-EmptyLines
```