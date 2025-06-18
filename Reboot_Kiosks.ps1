for ($var = 1; $var -le 18; $var++) {
    if ($var -lt 10) 
    {
        Restart-computer -computername [REDACTED]0$var -force
    }
    else 
    {
        Restart-computer -computername [REDACTED]$var -force
    }
}
$var--
Write-Host Kiosks 1 - $var have been rebooted.
pause
