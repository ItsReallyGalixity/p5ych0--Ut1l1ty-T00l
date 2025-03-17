# Set-ExecutionPolicy RemoteSigned -Force
# This line can be uncommented to ensure the script can run, if needed.

# Function to set registry values
function Set-RegistryValue {
    param (
        [string]$key,
        [string]$name,
        [string]$value,
        [string]$type = "DWord" # Default to DWord
    )

    if ($type -eq "DWord") {
        Set-ItemProperty -Path $key -Name $name -Value $value -Type DWord
    } elseif ($type -eq "String") {
        Set-ItemProperty -Path $key -Name $name -Value $value -Type String
    }
}

# Disable Telemetry
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0

# Disable Diagnostics and Feedback
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Feedback" "Disabled" 1

# Disable Inking & Typing Personalization
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC" "AllowInputPersonalization" 0

# Disable Advertising ID
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0
Set-RegistryValue "HKLM:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0

# Disable Cloud-Based Clipboard
Set-RegistryValue "HKCU:\Software\Microsoft\Clipboard" "Enabled" 0

# Disable Windows Location Service
Set-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" "Value" 0

# Disable app access to camera
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\camera" "Value" 0
# Disable app access to microphone
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" "Value" 0
# Disable app access to contacts
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" "Value" 0
# Disable app access to calendar
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\calendar" "Value" 0
# Disable app access to call history
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\callhistory" "Value" 0
# Disable app access to email
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" "Value" 0
# Disable app access to messaging
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\message" "Value" 0

# Disable Background Apps
Set-RegistryValue "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" "BackgroundAccessApplications" 0

# Disable Windows Feedback
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Feedback" "Disabled" 1

# Disable Cortana
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" "AllowCortana" 0

# Disable Microsoft OneDrive
Stop-Process -Name OneDrive -Force -ErrorAction SilentlyContinue
Set-RegistryValue "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" "DisableFileSyncNGSC" 1

# Inform the user
Write-Host "All privacy settings have been applied. Please restart your computer for changes to take effect."

# Optional: Restart the computer
# Restart-Computer -Force