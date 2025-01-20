# Check if running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
   Write-Host "Script is not running as Administrator. Restarting as Administrator..."
   Start-Process powershell "-File `"$PSCommandPath`"" -Verb RunAs
   exit
}
# Target computer and folder
$RemoteComputer = "\\[Redacted]"
$RemoteFolder = "$RemoteComputer\c$"
# Search for and delete files and folders with "[Redacted]" in the name
Get-ChildItem -Path $RemoteFolder -Recurse -Force -ErrorAction SilentlyContinue |
   Where-Object { $_.Name -like "*[Redacted]*" } |
   ForEach-Object {
       if ($_.PSIsContainer) {
           Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
       } else {
           Remove-Item -Path $_.FullName -Force -ErrorAction SilentlyContinue
       }
   }
Write-Host "Cleanup complete."
