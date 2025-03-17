# Create a PowerShell script to optimize the PC for gaming

# Prompt user for confirmation
$confirmation = Read-Host "This script will optimize your PC for gaming. Do you want to proceed? (Y/N)"
if ($confirmation -ne "Y") { 
    Write-Host "Exiting script." -ForegroundColor Red
    exit
}

# Set power plan to High Performance
Write-Host "Setting power plan to High Performance..." -ForegroundColor Green
powercfg /setactive SCHEME_MIN

# Disable unnecessary startup services
$servicesToDisable = @("SysMain", "WMPNetworkSvc", "Spooler", "Fax")
foreach ($service in $servicesToDisable) {
    Write-Host "Disabling service: $service" -ForegroundColor Green
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
}

# Close background applications
$appsToClose = @("OneDrive.exe", "Skype.exe", "Teams.exe")
foreach ($app in $appsToClose) {
    Write-Host "Closing application: $app" -ForegroundColor Green
    Stop-Process -Name $app -Force -ErrorAction SilentlyContinue
}

# Disable visual effects for performance
Write-Host "Disabling visual effects..." -ForegroundColor Green
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
Set-ItemProperty -Path $regPath -Name "VisualFXSetting" -Value 2
Start-Process "SystemPropertiesPerformance.exe"

# Clear temporary files
Write-Host "Clearing temporary files..." -ForegroundColor Green
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

# Optimize network settings
Write-Host "Optimizing network settings..." -ForegroundColor Green
netsh int tcp set global autotuninglevel=disabled
netsh int tcp set global congestionprovider=none

# Clear crash dumps
Write-Host "Clearing crash dump files..." -ForegroundColor Green
Remove-Item "C:\Windows\Minidump\*" -Recurse -Force -ErrorAction SilentlyContinue

# Adjust Game Mode Settings
Write-Host "Setting Game Mode to On..." -ForegroundColor Green
$gameBarRegPath = "HKCU:\Software\Microsoft\GameBar"
New-Item -Path $gameBarRegPath -Force | Out-Null
Set-ItemProperty -Path $gameBarRegPath -Name "AutoGameMode" -Value 1

# Finish
Write-Host "Optimization complete! Please restart your PC for all changes to take effect." -ForegroundColor Yellow