# Ensure the script is running with administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw "Please run this script as an Administrator."
}

# Function to Optimize PC while maintaining stability
function Optimize-PC {
    Write-Host "Optimizing system for gaming..."

    # Disable unnecessary visual effects without disrupting stability
    $performanceOptions = New-Object -ComObject Shell.Application
    $performanceOptions.ControlPanelItem("System and Security").InvokeVerb("Open")
    Start-Sleep -Seconds 2
    $performanceOptions.ControlPanelItem("System").InvokeVerb("Advanced settings")
    Start-Sleep -Seconds 2

    # Here the user should manually adjust visual effects if desired
    Write-Host "Please manually adjust the visual effects for best performance and select 'Adjust for best performance' if suitable."

    # Clean Temp Files
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Temporary files cleaned."
}

# Install Chrome
function Install-Chrome {
    Write-Host "Installing Google Chrome..."
    $chromeInstaller = "https://dl.google.com/chrome/install/latest/chrome_installer.exe"
    Invoke-WebRequest -Uri $chromeInstaller -OutFile "$env:TEMP\chrome_installer.exe"
    Start-Process -FilePath "$env:TEMP\chrome_installer.exe" -ArgumentList "/silent" -Wait
    Remove-Item -Path "$env:TEMP\chrome_installer.exe" -ErrorAction SilentlyContinue
    Write-Host "Google Chrome installed."
}

# Install Steam
function Install-Steam {
    Write-Host "Installing Steam..."
    $steamInstaller = "https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe"
    Invoke-WebRequest -Uri $steamInstaller -OutFile "$env:TEMP\SteamSetup.exe"
    Start-Process -FilePath "$env:TEMP\SteamSetup.exe" -ArgumentList "/silent" -Wait
    Remove-Item -Path "$env:TEMP\SteamSetup.exe" -ErrorAction SilentlyContinue
    Write-Host "Steam installed."
}

# Windows Update
function Update-Windows {
    Write-Host "Checking for Windows updates..."
    # Run Windows Update
    Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser -AllowClobber -Confirm:$false -ErrorAction SilentlyContinue
    Import-Module PSWindowsUpdate
    Get-WindowsUpdate -Install -AcceptAll -AutoReboot -ErrorAction SilentlyContinue
}

# Execute Functions
Optimize-PC
Install-Chrome
Install-Steam
Update-Windows

Write-Host "Rebooting the computer..."
Restart-Computer -Force
