# Check if running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
   Write-Host "Script is not running as Administrator. Restarting as Administrator..."
   Start-Process powershell "-File `"$PSCommandPath`"" -Verb RunAs
   exit
}
# Prompt user to choose the Windows version
Write-Host "Which Windows ISO do you want to use for .NET Framework installation?"
Write-Host "1) Windows 11"
Write-Host "2) Windows 10"
$choice = Read-Host "Enter 1 for Windows 11 or 2 for Windows 10"
switch ($choice) {
   "1" {
       # Windows 11 ISO path
       $isoPath = "[Redacted]"
       Write-Host "You chose Windows 11."
   }
   "2" {
       # Windows 10 ISO path
       $isoPath = "[Redacted]"
       Write-Host "You chose Windows 10."
   }
   Default {
       Write-Host "Invalid choice. Exiting..."
       exit
   }
}
# Attempt to mount the disk image
try {
   $mountResult = Mount-DiskImage -ImagePath $isoPath -PassThru
   $driveLetter = ($mountResult | Get-Volume).DriveLetter
} catch {
   Write-Host "Failed to mount the ISO. Error details: $($_.Exception.Message)"
   exit
}
if (-not $driveLetter) {
   Write-Host "Failed to retrieve a drive letter. Exiting script."
   exit
}
cls
Write-Host "Drive $driveLetter mounted. .NET Framework 3.5 will now be installed..."
# Install .NET Framework
$sourcePath = "${driveLetter}:\sources\sxs"
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:$sourcePath
Write-Host ".NET Framework installation completed."
# Dismount the disk image
try {
   Dismount-DiskImage -ImagePath $isoPath
   Write-Host "ISO unmounted."
} catch {
   Write-Host "Error while unmounting the ISO: $($_.Exception.Message)"
}
pause
