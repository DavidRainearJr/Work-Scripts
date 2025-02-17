#this script is purely to add to other powershell scripts that need to be run as admin.

# Check if running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
   Write-Host "Script is not running as Administrator. Restarting as Administrator..."
   Start-Process powershell -ArgumentList "-File `"$PSCommandPath`"" -Verb RunAs
   exit
}
