Clear-Host
$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
function Show-CurrentSettings {
   Write-Host "`n=== CURRENT AUTO-LOGIN SETTINGS ==="
   $props = @('AutoAdminLogon','DefaultDomainName','DefaultUserName','DefaultPassword')
   foreach ($prop in $props) {
       try {
           $val = Get-ItemPropertyValue -Path $regPath -Name $prop -ErrorAction Stop
           Write-Host ($prop + "`t" + $val)
       } catch {
           Write-Host ($prop + "`t<Not Set>")
       }
   }
   Write-Host ""
}
function Setup-AutoLogin {
   $domainChoice = Read-Host "Is this a domain user or local user? (1 = [Redacted], 2 = local machine)"
   switch ($domainChoice) {
       '1' { $domain = '[Redacted]' }
       '2' { $domain = '' }
       default {
           Write-Host "Invalid input. Aborting setup."
           return
       }
   }
   $username = Read-Host "Enter the username"
   $password = Read-Host "Enter the password (will be stored in plain text)"
   Write-Host "`n=== Confirm Settings ==="
   Write-Host "AutoAdminLogon:`t1"
   Write-Host "DefaultDomainName:`t$domain"
   Write-Host "DefaultUserName:`t$username"
   Write-Host "DefaultPassword:`t$password"
   $confirm = Read-Host "Apply these settings? [Y/N]"
   if ($confirm -notin @('Y','y','1')) {
       Write-Host "Setup cancelled by user."
       return
   }
   # Apply only after confirmation
   Set-ItemProperty -Path $regPath -Name 'AutoAdminLogon' -Value '1' -Type String
   Set-ItemProperty -Path $regPath -Name 'DefaultDomainName' -Value $domain -Type String
   Set-ItemProperty -Path $regPath -Name 'DefaultUserName' -Value $username -Type String
   Set-ItemProperty -Path $regPath -Name 'DefaultPassword' -Value $password -Type String
   Write-Host "`nAuto-login configured successfully."
}
function Disable-AutoLogin {
   Set-ItemProperty -Path $regPath -Name 'AutoAdminLogon' -Value '0' -Type String
   Write-Host "`nAuto-login disabled. Credentials are still stored."
}
function Wipe-AutoLogin {
   Set-ItemProperty -Path $regPath -Name 'AutoAdminLogon' -Value '0' -Type String
   Set-ItemProperty -Path $regPath -Name 'DefaultDomainName' -Value '' -Type String
   Set-ItemProperty -Path $regPath -Name 'DefaultUserName' -Value '' -Type String
   Set-ItemProperty -Path $regPath -Name 'DefaultPassword' -Value '' -Type String
   Write-Host "`nAuto-login disabled and credentials wiped (set to empty)."
}
function Reactivate-AutoLogin {
   $username = Get-ItemPropertyValue -Path $regPath -Name 'DefaultUserName' -ErrorAction SilentlyContinue
   $password = Get-ItemPropertyValue -Path $regPath -Name 'DefaultPassword' -ErrorAction SilentlyContinue
   if ([string]::IsNullOrWhiteSpace($username) -or [string]::IsNullOrWhiteSpace($password)) {
       Write-Host "`nCannot re-enable auto-login. Username or password is missing."
       return
   }
   Set-ItemProperty -Path $regPath -Name 'AutoAdminLogon' -Value '1' -Type String
   Write-Host "`nAuto-login re-enabled using existing credentials."
}
# === Main Persistent Menu Loop ===
$exitMenu = $false
do {
   Show-CurrentSettings
   Write-Host "Select an option:"
   Write-Host "1 = Setup auto-login"
   Write-Host "2 = Disable auto-login (keep credentials)"
   Write-Host "3 = Disable & Wipe all auto-login data"
   Write-Host "4 = Re-enable auto-login (if settings still exist)"
   Write-Host "5 = Exit"
   $option = Read-Host "Your choice"
   switch ($option) {
       '1' { Setup-AutoLogin }
       '2' { Disable-AutoLogin }
       '3' { Wipe-AutoLogin }
       '4' { Reactivate-AutoLogin }
       '5' { $exitMenu = $true }
       default { Write-Host "Invalid selection. Please choose a valid option." }
   }
   if (-not $exitMenu) {
       Clear-Host
   }
} while (-not $exitMenu)
