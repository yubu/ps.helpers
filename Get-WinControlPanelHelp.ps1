function Get-WinControlPanelHelp {
   <#
  .Synopsis
	  Get Control Panel CLI commands
  .Description
	  Get Control Panel CLI commands
  .Example
	  Get-WinControlPanelHelp control
  .Example
    gwincontrol date -start 
  .Example 
	  Get-WinControlPanelHelp | ? Command -match sched
  .Example
	  "sched|network" | gwincontrol -start
  .Example
	  gwincontrol "sched|network" 	
  .Example 
    (gwincontrol index).command | select -Skip 1 | %{iex $_}
  #>
  [CmdletBinding()]
  [Alias("gwincontrol")]
  param (
	  [Parameter(Mandatory=$False,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]$query,
    [switch]$start
  )
  
  begin {
    $WinControlCommandHelp=@'
    "Control Panel Applet","Command"
    "Action Center","control /name Microsoft.ActionCenter"
    "Add Features to Windows 8","control /name Microsoft.WindowsAnytimeUpgrade"
    "Add Hardware","control /name Microsoft.AddHardware"
    "Administrative Tools","control admintools"
    "AutoPlay","control /name Microsoft.AutoPlay"
    "Backup and Restore Center","control /name Microsoft.BackupAndRestoreCenter"
    "Backup and Restore","control /name Microsoft.BackupAndRestore"
    "Biometric Devices","control /name Microsoft.BiometricDevices"
    "BitLocker Drive Encryption","control /name Microsoft.BitLockerDriveEncryption"
    "BitLocker Drive Encryption","control /name Microsoft.BluetoothDevices"
    "Color Management","control /name Microsoft.ColorManagement"
    "Color","control color"
    "Control Panel","control"
    "Credential Manager","control /name Microsoft.CredentialManager"
    "Date and Time","control /name Microsoft.DateAndTime"
    "Date and Time","control date/time"
    "Default Location","control /name Microsoft.DefaultLocation"
    "Default Programs","control /name Microsoft.DefaultPrograms"
    "Desktop Gadgets","control /name Microsoft.DesktopGadgets"
    "Device Manager","control /name Microsoft.DeviceManager"
    "Device Manager","devmgmt.msc"
    "Devices and Printers","control /name Microsoft.DevicesAndPrinters"
    "Devices and Printers","control printers"
    "Display","control /name Microsoft.Display"
    "Display","control desktop"
    "Ease of Access Center","control /name Microsoft.EaseOfAccessCenter"
    "Family Safety","control /name Microsoft.ParentalControls"
    "File History","control /name Microsoft.FileHistory"
    "Folder Options","control /name Microsoft.FolderOptions"
    "Folder Options","control folders"
    "Fonts","control /name Microsoft.Fonts"
    "Fonts","control fonts"
    "Game Controllers","control /name Microsoft.GameControllers"
    "Get Programs","control /name Microsoft.GetPrograms"
    "Getting Started","control /name Microsoft.GettingStarted"
    "Home Group","control /name Microsoft.HomeGroup"
    "Indexing Options","control /name Microsoft.IndexingOptions"
    "Indexing Options","rundll32.exe shell32.dll,Control_RunDLL srchadmin.dll"
    "Infrared","control /name Microsoft.Infrared"
    "Infrared","control /name Microsoft.InfraredOptions"
    "Internet Options","control /name Microsoft.InternetOptions"
    "iSCSI Initiator","control /name Microsoft.iSCSIInitiator"
    "Keyboard","control /name Microsoft.Keyboard"
    "Keyboard","control keyboard"
    "Language","control /name Microsoft.Language"
    "Location and Other Sensors","control /name Microsoft.LocationAndOtherSensors"
    "Location Settings","control /name Microsoft.LocationSettings"
    "Mouse","control /name Microsoft.Mouse"
    "Mouse","control mouse"
    "Network and Sharing Center","control /name Microsoft.NetworkAndSharingCenter"
    "Network and Sharing Center","control netconnections"
    "Notification Area Icons","control /name Microsoft.NotificationAreaIcons"
    "Offline Files","control /name Microsoft.OfflineFiles"
    "Parental Controls","control /name Microsoft.ParentalControls"
    "Pen and Input Devices","control /name Microsoft.PenAndInputDevices"
    "Pen and Touch","control /name Microsoft.PenAndTouch"
    "People Near Me","control /name Microsoft.PeopleNearMe"
    "Performance Information and Tools","control /name Microsoft.PerformanceInformationAndTools"
    "Personalization","control /name Microsoft.Personalization"
    "Personalization","control desktop"
    "Phone and Modem Options","control /name Microsoft.PhoneAndModemOptions"
    "Phone and Modem","control /name Microsoft.PhoneAndModem"
    "Power Options","control /name Microsoft.PowerOptions"
    "Printers and Faxes","control printers"
    "Printers","control /name Microsoft.Printers"
    "Printers","control printers"
    "Problem Reports and Solutions","control /name Microsoft.ProblemReportsAndSolutions"
    "Programs and Features","control /name Microsoft.ProgramsAndFeatures"
    "Recovery","control /name Microsoft.Recovery"
    "Region","control /name Microsoft.RegionAndLanguage"
    "Region","control international"
    "Region and Language","control /name Microsoft.RegionAndLanguage"
    "Region and Language","control international"
    "Regional and Language Options","control /name Microsoft.RegionalAndLanguageOptions"
    "Regional and Language Options","control international"
    "RemoteApp and Desktop Connections","control /name Microsoft.RemoteAppAndDesktopConnections"
    "Scanners and Cameras","control /name Microsoft.ScannersAndCameras"
    "Scheduled Tasks","control schedtasks"
    "Security Center","control /name Microsoft.SecurityCenter"
    "Sound","control /name Microsoft.Sound"
    "Sound","control /name Microsoft.AudioDevicesAndSoundThemes"
    "Speech Recognition Options","control /name Microsoft.SpeechRecognitionOptions"
    "Speech Recognition","control /name Microsoft.SpeechRecognition"
    "Storage Spaces","control /name Microsoft.StorageSpaces"
    "Sync Center","control /name Microsoft.SyncCenter"
    "System","control /name Microsoft.System"
    "System","control system"
    "Tablet PC Settings","control /name Microsoft.TabletPCSettings"
    "Task Scheduler","control schedtasks"
    "Taskbar","control /name Microsoft.Taskbar"
    "Taskbar","rundll32.exe shell32.dll,Options_RunDLL 1"
    "Taskbar and Start Menu","control /name Microsoft.TaskbarAndStartMenu"
    "Taskbar and Start Menu","rundll32.exe shell32.dll,Options_RunDLL 1"
    "Text to Speech","control /name Microsoft.TextToSpeech"
    "Troubleshooting","control /name Microsoft.Troubleshooting"
    "User Accounts","control /name Microsoft.UserAccounts"
    "User Accounts","control userpasswords"
    "Welcome Center","control /name Microsoft.WelcomeCenter"
    "Windows 7 File Recovery","control /name Microsoft.BackupAndRestore"
    "Windows Anytime Upgrade","control /name Microsoft.WindowsAnytimeUpgrade"
    "Windows CardSpace","control /name Microsoft.CardSpace"
    "Windows Defender","control /name Microsoft.WindowsDefender"
    "Windows Firewall","control /name Microsoft.WindowsFirewall"
    "Windows Marketplace","control /name Microsoft.GetProgramsOnline"
    "Windows Mobility Center","control /name Microsoft.MobilityCenter"
    "Windows Sidebar Properties","control /name Microsoft.WindowsSidebarProperties"
    "Windows SideShow","control /name Microsoft.WindowsSideShow"
    "Windows Update","control /name Microsoft.WindowsUpdate"
'@
  if (!$psboundparameters.count) {
    if (gcm rmel -ea ignore) {help -ex $PSCmdlet.MyInvocation.MyCommand.Name | Out-String | Remove-EmptyLines; return}
    else {help -ex $PSCmdlet.MyInvocation.MyCommand.Name; return}
  }
}
  process {
    if ($query -and $start) {(convertfrom-csv $WinControlCommandHelp -delimiter "," | ? 'Control Panel Applet' -match $query).command | %{iex $_}}
    elseif ($query) {convertfrom-csv $WinControlCommandHelp -delimiter "," | ? "Control Panel Applet" -match $query}
	  else {convertfrom-csv $WinControlCommandHelp -delimiter ","}
  }
}
