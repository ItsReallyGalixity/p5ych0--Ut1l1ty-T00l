# Ensure the script is running with administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Please run this script as an Administrator."
}

# System Optimization
function Optimize-PC {
    Write-Host "Optimizing system for gaming..."

    # Disable unnecessary services
    Stop-Service -Name "WSearch" -Force
    Set-Service -Name "WSearch" -StartupType Disabled
    Set-Service -Name "SysMain" -StartupType Disabled

    # Disable Transparency effects
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "UseOLEDTaskbarTransparency" -Value 0
    Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Value 0

    # Optimize Visual Effects
    [System.Windows.Forms.SystemInformation]::UserInteractive | Out-Null
    $visualEffects = New-Object -ComObject wscript.shell
    $visualEffects.RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\VisualFX", "0", "REG_DWORD")

    # Clean Temp Files
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force
    Write-Host "System optimized."
}

# Install Chrome
function Install-Chrome {
    Write-Host "Installing Google Chrome..."
    $chromeInstaller = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
    Invoke-WebRequest -Uri $chromeInstaller -OutFile "$env:TEMP\chrome_installer.exe"
    Start-Process -FilePath "$env:TEMP\chrome_installer.exe" -ArgumentList "/silent" -Wait
    Remove-Item -Path "$env:TEMP\chrome_installer.exe"
    Write-Host "Google Chrome installed."
}

# Install Steam
function Install-Steam {
    Write-Host "Installing Steam..."
    $steamInstaller = "https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe"
    Invoke-WebRequest -Uri $steamInstaller -OutFile "$env:TEMP\SteamSetup.exe"
    Start-Process -FilePath "$env:TEMP\SteamSetup.exe" -ArgumentList "/silent" -Wait
    Remove-Item -Path "$env:TEMP\SteamSetup.exe"
    Write-Host "Steam installed."
}

# Windows Update
function Update-Windows {
    Write-Host "Checking for Windows updates..."
    # Run Windows Update
    Install-Module PSWindowsUpdate -Force -Scope CurrentUser -AllowClobber -Confirm:$false
    Import-Module PSWindowsUpdate
    Get-WindowsUpdate -Install -AcceptAll -AutoReboot
}

# Execute Functions
Optimize-PC
Install-Chrome
Install-Steam
Update-Windows

Write-Host "Rebooting the computer..."
Restart-Computer -Force
