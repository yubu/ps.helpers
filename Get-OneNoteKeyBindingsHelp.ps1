function Get-OneNoteKeyBindingsHelp {
	<#
   .Synopsis
	   Get OneNote keybindings
   .Description
	   Get OneNote keybindings
   .Example
	   Get-OneNOteHelp paste
   .Example 
	   Get-OneNoteHelp | ? ToDo -match go
   .Example
	   "go|move" | gonh
   .Example
	   gonh "go|move"	
   .Example 
   #>
   [CmdletBinding()]
   [Alias("gonkh")]
   param (
	   [Parameter(Mandatory=$False,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]$query
   )
   begin {
     $OneNoteHelp=@'
        "ToDo","Shortcut"
        "Most useful keyboard shortcuts in OneNote 2016:"
        "Go back to the last page visited","ALT+LEFT ARROW"
        "Go forward to the next page visited","ALT+RIGHT ARROW"
        "Go to the next page in the section","CTRL+PAGE DOWN"
        "Go to the previous page in the section","CTRL+PAGE UP"
        "Go to the next section","CTRL+TAB"
        "Go to the previous section","CTRL+SHIFT+TAB"

        "Copy the formatting of selected text (Format Painter)","CTRL+SHIFT+C"
        "Paste the formatting to selected text (Format Painter)","CTRL+SHIFT+V"
        "Create a column to the right of the current column in a table","CTRL+ALT+R"
        "Create a column to the left of the current column in a table","CTRL+ALT+E"
        "Create a row above the current one in a table (when the cursor is at the beginning of any row)","ENTER"
        "Delete the current empty row in a table (when the cursor is at the beginning of the row)","DEL (press twice)"
        "Delete one word to the left","Ctrl+Backspace"
        "Delete one word to the right","Ctrl+Delete"
        "Insert a line break without starting a new paragraph","Shift+Enter"
        "Check spelling","F7"
        "Open the thesaurus for the currently selected word","Shift+F7"
        "Bring up the context menu for any note tab or any other object that currently has focus","Shift+F10"
        "Execute the action suggested on the Information Bar if it appears at the top of a page","Ctrl+Shift+W"

        "Highlight selected text","CTRL+SHIFT+H or CTRL+ALT+H"
        "Apply or remove strikethrough from the selected text","Ctrl+Hyphen"
        "Apply or remove bulleted list formatting from the selected paragraph","Ctrl+Period"
        "Apply or remove numbered list formatting from the selected paragraph","Ctrl+Slash"
        "Indent a paragraph from the left","Alt+Shift+Right Arrow"
        "Remove a paragraph indent from the left","Alt+Shift+Left Arrow"
        "Increase the font size of selected text","Ctrl+Shift+>"
        "Decrease the font size of selected text","Ctrl+Shift+<"
        "Clear all formatting applied to the selected text","Ctrl+Shift+N"
        "Show or hide rule lines on the current page","Ctrl+Shift+R"
        "Insert the current date","ALT+SHIFT+D"
        "Insert the current date and time","ALT+SHIFT+F"
        "Insert the current time","ALT+SHIFT+T"
        "Start a math equation or convert selected text to a math equation","Alt+="
        "Insert a Euro (€) symbol","Ctrl+Alt+E"
        "Create a table by adding a second column to already typed text","Tab"
        "Create another column in a table with a single row","Tab"
        "Create another row when at the end cell of a table","Enter"
        "Create a row below the current row in a table","Ctrl+Enter"
        "Create another paragraph in the same cell in a table","Alt+Enter"
        "Create a column to the right of the current column in a table","Ctrl+Alt+R"
        "Create a row above the current one in a table (when the cursor is at the beginning of any row)","Enter"
        "Delete the current empty row in a table (when the cursor is at the beginning of the row)","DEL (press twice)"
        "Set writing direction left to right","CTRL+LEFT SHIFT"
        "Set writing direction right to left","CTRL+RIGHT SHIFT"
        "Move the selected page tab up","ALT+SHIFT+UP ARROW"
        "Move the selected page tab down","ALT+SHIFT+DOWN ARROW"
        "Go to the first page in the section","ALT+HOME"
        "Go to the last page in the section","ALT+END"
        "Go to the first page in the currently visible set of page tabs","ALT+PAGE UP"
        "Go to the last page of the currently visible set of page tabs","ALT+PAGE DOWN"
        "Move the current paragraph or several selected paragraphs up","ALT+SHIFT+UP ARROW"
        "Move the current paragraph or several selected paragraphs down","ALT+SHIFT+DOWN ARROW"
        "Move the current paragraph or several selected paragraphs left (decreasing the indent)","Alt+Shift+Left Arrow"
        "Move the current paragraph or several selected paragraphs right (increasing the indent)","Alt+Shift+Right Arrow"
        "Select the current paragraph and its subordinate paragraphs","Ctrl+Shift+Hyphen"

        "Expand or collapse the tabs of a page group","Ctrl+Shift+*"
        "Increase the width of the page tabs bar","Ctrl+Shift+["
        "Decrease the width of the page tabs bar","Ctrl+Shift+]"
        "Create a new page below the current page tab at the same level","Ctrl+Alt+N"
        "Decrease indent level of the current page tab label","Ctrl+Alt+["
        "Increase indent level of the current page tab label","Ctrl+Alt+]"
        "Create a new subpage below the current page","Ctrl+Shift+Alt+N"
        "Select all items","Ctrl+A. Press Ctrl+A several times to increase the scope of the selection."
        "Select the current page","Ctrl+Shift+A. If the selected page is part of a group, press Ctrl+A to select all of the pages in the group."
        "Move the selected page tab up","Alt+Shift+Up Arrow"
        "Move the selected page tab down","Alt+Shift+Down Arrow"
        "Move the insertion point to the page title","Ctrl+Shift+T"
        "Go to the first page in the currently visible set of page tabs","Alt+PAGE Up"
        "Go to the last page in the currently visible set of page tabs","Alt+PAGE Down"
        "Scroll up in the current page","PAGE Up"
        "Scroll down in the current page","PAGE Down"
        "Scroll to the top of the current page","Ctrl+Home"
        "Scroll to the bottom of the current page","Ctrl+End"
        "Go to the next paragraph","Ctrl+Down Arrow"
        "Go to the previous paragraph","Ctrl+Up Arrow"
        "Go to the next note container","Alt+Down Arrow"
        "Zoom in","Alt+Ctrl+Plus sign (on the numeric keypad) or Alt+Ctrl+Shift+Plus sign"
        "Zoom out","Alt+Ctrl+Minus sign (on the numeric keypad) or Alt+Ctrl+Shift+Hyphen"
        "Save changes","Ctrl+S	Note: While OneNote is running"," your notes are automatically saved whenever you change them. Manually saving notes is not necessary."

        "Move the insertion point to the Search box to search all notebooks","Ctrl+E"
        "While searching all notebooks preview the next result","Down Arrow"
        "While searching all notebooks go to the selected result and dismiss Search","Enter"
        "Change the search scope","Ctrl+E Tab Space"
        "Open the Search Results pane","Alt+O after searching"
        "Search only the current page","Ctrl+F	Note: You can switch between searching everywhere and searching only the current page at any point by pressing Ctrl+E or Ctrl+F."
        "While searching the current page move to the next result","Enter or F3"
        "While searching the current page move to the previous result","Shift+F3"
        "Dismiss Search and return to the page","Esc"

        "Send the selected pages in an e-mail message","Ctrl+Shift+E"
        "Create a Today Outlook task from the currently selected note","Ctrl+Shift+1"
        "Create a Tomorrow Outlook task from the currently selected note","Ctrl+Shift+2"
        "Create a This Week Outlook task from the currently selected note","Ctrl+Shift+3"
        "Create a Next Week Outlook task from the currently selected note","Ctrl+Shift+4"
        "Create a No Date Outlook task from the currently selected note","Ctrl+Shift+5"
        "Open the selected Outlook task","Ctrl+Shift+K"
        "Mark the selected Outlook task as complete","Ctrl+Shift+9"
        "Delete the selected Outlook task","Ctrl+Shift+0"
        "Sync changes in the current shared notebook","Shift+F9"
        "Sync changes in all shared notebooks","F9"
        "Mark the current page as Unread","Ctrl+Q"
        "Lock all password-protected sections","Ctrl+Alt+L"

        "To order the images horizontally (row)","Sift+Drag the image "
'@      
   if (!$psboundparameters.count) {
      if (gcm rmel -ea ignore) {help -ex $PSCmdlet.MyInvocation.MyCommand.Name | Out-String | Remove-EmptyLines; return}
      else {help -ex $PSCmdlet.MyInvocation.MyCommand.Name; return}
   }
}
   process {
	   if ($query) {convertfrom-csv $OneNoteHelp -delimiter "," | ? ToDo -match "$query"}
	   else {convertfrom-csv $OneNoteHelp -delimiter ","}
   }
}
