# Optimize Internet Speed Script
# This script aims to optimize internet performance without changing adapter settings.

# Function to log actions
function Log-Action {
    param (
        [string]$message
    )
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "[$timestamp] $message"
}

# Disable Background Intelligent Transfer Service (BITS)
Log-Action "Disabling Background Intelligent Transfer Service (BITS)..."
Stop-Service BITS -Force -ErrorAction SilentlyContinue
Set-Service BITS -StartupType Disabled -ErrorAction SilentlyContinue
Log-Action "BITS Disabled."

# Optimize TCP/IP settings
Log-Action "Optimizing TCP/IP settings..."
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "MaxUserPort" -Value 65534 -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpTimedWaitDelay" -Value 30 -ErrorAction SilentlyContinue
Log-Action "TCP/IP settings optimized."

# Set DNS to Google's Public DNS
$dns1 = "8.8.8.8"
$dns2 = "8.8.4.4"
Log-Action "Setting DNS servers to Google's Public DNS ($dns1, $dns2)..."
Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true } | ForEach-Object {
    $_.SetDNSServerSearchOrder($dns1, $dns2)
}
Log-Action "DNS settings updated."

# Flush DNS Cache
Log-Action "Flushing DNS cache..."
ipconfig /flushdns
Log-Action "DNS cache flushed."

# Disable Windows Update Delivery Optimization (optional)
Log-Action "Disabling Windows Update Delivery Optimization..."
Set-Service -Name "DoSvc" -StartupType Disabled -ErrorAction SilentlyContinue
Stop-Service -Name "DoSvc" -Force -ErrorAction SilentlyContinue
Log-Action "Windows Update Delivery Optimization disabled."

# Disable unnecessary services
Log-Action "Disabling unnecessary services for better performance..."
$servicesToDisable = @(
    "WMPNetworkSvc",  # Windows Media Player Network Sharing Service
    "Fax",            # Fax Service
    "XblGameSave",    # Xbox Live Game Save
    "XblAuthManager"  # Xbox Live Auth Manager
)

foreach ($service in $servicesToDisable) {
    try {
        Stop-Service -Name $service -Force -ErrorAction Stop
        Set-Service -Name $service -StartupType Disabled -ErrorAction Stop
        Log-Action "$service disabled."
    } catch {
        Log-Action "Failed to disable $service: $_"
    }
}

# Final log and status
Log-Action "Internet optimization script completed. Please reboot your system for changes to take effect."