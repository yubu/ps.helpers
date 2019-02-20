function Get-WinKeyHelp {
   <#
  .Synopsis
	  Get WinKey keybindings
  .Description
	  Get WinKey keybindings
  .Example
    Get-WinKeyHelp | ? action -match system
  .Example
	  Get-WinKeyHelp system
  .Example 
	  Get-WinKeyHelp mini
  .Example
	  "go|move" | gwkh
  .Example
	   gwkh "go|move"	
  .Example 
  #>
  [CmdletBinding()]
  [Alias("gwkh")]
  param (
	  [Parameter(Mandatory=$False,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]$query
  )
    begin {
        $WinKeyHelp=@'
        Keyboard shortcut	Action
        Windows key	Open or close Start Menu.
        Windows key + A	Open Action center.
        Windows key + B	Go to System Tray.
        Windows key + C	Open Cortana in listening mode.
        Windows key + D	Display and hide the desktop.
        Windows key + E	Open File Explorer.
        Windows key + F	Open Feedback menu.
        Windows key + G	Open Game bar when a game is open.
        Windows key + H	Open the Share charm (Microphone recording + Online Keyboard)
        Windows key + I	Open Settings.
        Windows key + K	Open the Connect quick action.
        Windows key + L	Lock your PC or switch accounts.
        Windows key + M	Minimize all windows.
        Windows key + R	Open Run dialog box.
        Windows key + S	Open Search.
        Windows key + T	Move right on Toolbar icons.
        Windows key + Shift + T	Move left on Toolbar icons.
        Windows key + U	Open Ease of Access Center.
        Windows key + V	Open clipboard history.
        Windows key + W	Windows Ink Workspace.
        Windows key + X	Open Quick Link menu.
        Windows key + Number	Open the app pinned to the taskbar in the position indicated by the number.
        Windows key + Left arrow key	Snap app windows left.
        Windows key + Right arrow key	Snap app windows right.
        Windows key + Up arrow key	Maximize app windows.
        Windows key + Down arrow key	Minimize app windows.
        Windows key + ,	Temporarily peek at the desktop.
        Windows key + ;	Open Emoji menu.
        Windows key + .	Open Emoji menu.
        Windows key + Ctrl + D	Add a virtual desktop.
        Windows key + Ctrl + Left or Right arrow	Switch between virtual desktops.
        Windows key + Ctrl + F4	Close current virtual desktop.
        Windows key + Enter	Open Narrator.
        Windows key + Home	Minimize all but the active desktop window (restores all windows on second stroke).
        Windows key + PrtScn	Capture a screenshot and save in Screenshots folder.
        Windows key + Shift + Up arrow	Stretch the desktop window to the top and bottom of the screen.
        Windows key + Shift + Left/Right arrow	Move application window to another screen
        Windows key + Space	Change Language.
        Windows key + Tab	Open Task view.
        Windows key +  +	Zoom in using the magnifier.
        Windows key +  -	Zoom out using the magnifier.
        Ctrl + Shift + Esc	Open Task Manager.
        Alt + Tab	Switch between open apps.
        Alt + Left arrow key	Go back.
        Alt + Right arrow key	Go foward.
        Alt + Page Up	Move up one screen.
        Alt + Page down	Move down one screen.
        Ctrl + Alt + Tab	View open apps.
        Ctrl + C	Copy selected items to clipboard.
        Ctrl + X	Cut selected items.
        Ctrl + V	Paste content from clipboard.
        Ctrl + A	Select all content.
        Ctrl + Z	Undo an action.
        Ctrl + Y	Redo an action.
        Ctrl + D	Delete the selected item and move it to the Recycle Bin.
        Ctrl + Esc	Open the Start Menu.
        Ctrl + Shift	Switch the keyboard layout.
        Ctrl + Shift + Esc	Open Task Manager.
        Ctrl + F4	Close the active window.
'@  
  if (!$psboundparameters.count) {
    if (gcm rmel -ea ignore) {help -ex $PSCmdlet.MyInvocation.MyCommand.Name | Out-String | Remove-EmptyLines; return}
    else {help -ex $PSCmdlet.MyInvocation.MyCommand.Name; return}
  }
}
  process {
    if ($query) {convertfrom-csv $WinKeyHelp -delimiter "`t" | ? Action -match "$query"}
    else {convertfrom-csv $WinKeyHelp -delimiter "`t"}
  }
}
