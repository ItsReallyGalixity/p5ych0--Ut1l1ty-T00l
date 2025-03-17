# PowerShell script to remove unnecessary Microsoft-installed apps
# Intended to declutter Windows 11 if executed with caution.

# Get a list of packages to remove
$appList = @(
    # Common apps to remove
    "Microsoft.XboxApp",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxGameOverlay",
    "Microsoft.BingNews",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "Microsoft.MicrosoftSolitaireCollection",
    "Microsoft.Office.Desktop",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",
    "Microsoft.SkypeApp",
    "Microsoft.MicrosoftStickyNotes",
    "Microsoft.Windows.Photos",
    "Microsoft.YourPhone",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.MixedReality.Portal",
    "Microsoft.MicrosoftEdge.Stable",
    "Microsoft.WindowsMaps",
    "Microsoft.MicrosoftWhiteboard",
    "Microsoft.MicrosoftToDo",
    "Microsoft.MinecraftUWP",
    "Microsoft.MicrosoftTeams",
    "Microsoft.Palm",
    "Microsoft.WindowsSoundRecorder"
)

# Function to remove the app
function Remove-App {
    param (
        [string]$AppName
    )
    try {
        Get-AppxPackage -Name $AppName | Remove-AppxPackage -ErrorAction Stop
        Write-Host "$AppName has been removed successfully."
    } catch {
        Write-Host "Failed to remove $AppName. $_"
    }
}

# Loop through the app list and remove each app
foreach ($app in $appList) {
    Remove-App -AppName $app
}

Write-Host "Completed removal of specified apps. Please review the output for any errors."