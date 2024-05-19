# WindowsSandbox-Utilities
Utilities, scripts, setup, information etc. for the Windows Sandbox

## Background
The Sandbox is great, but excludes some items that I typically require and this repo is meant to provide a quick and easy way to set up the Sandbox whenever we need it with the minimal of effort.

Example issues to solve:
* There is no Windows Store, meaning some things are difficult to set up
* Certain base packages are missing, meaning that installing other things may fail due to missing dependencies
* Windows Terminal is not installed
* Notepad is not installed

### PowerShell
Things reliant on the same infrastructure as the Windows Store - i.e. things that are not delivered by an 'msi' or similar installer - can often be set up using PowerShell. This requires extra effort and manually taking care of dependencies and so on, but is our best approach for this.

#### Admin priviliges
The Windows Sandbox opens as though the logged-on user is an administrator and so the things we try and do are running with admin rights, but the following bit of PowerShell script is useful anyway as a general practice in this sort of situation.

```powershell
if (-not([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You need to have Administrator rights to run this script!`nPlease re-run this script as an Administrator in an elevated powershell prompt!"
    break
}
```

#### Scripting hints and tips
Examine [preference variables](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-7.4) for useful things to improve scripts.

## Software setup
### Base packages
#### XAML
Packages requiring XAML support require a Microsoft package to be installed. It is necessary to specify the precise version here.

```powershell
$ProgressPreference='Silent'
# Invoke-WebRequest -Uri 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx' -OutFile 'Microsoft.UI.Xaml.2.7.x64.appx'
# Invoke-WebRequest -Uri 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.5/Microsoft.UI.Xaml.2.8.x64.appx' -OutFile 'Microsoft.UI.Xaml.2.8.x64.appx'
Invoke-WebRequest -Uri 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx' -OutFile "$env:temp\Microsoft.UI.Xaml.2.8.x64.appx"

# Add-AppxPackage Microsoft.UI.Xaml.2.7.x64.appx
# Add-AppxPackage Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage -Path "$env:temp\Microsoft.UI.Xaml.2.8.x64.appx" -ErrorAction SilentlyContinue | Out-Null
```

### Windows Terminal
* Requires [XAML](#xaml)

### Notepad

# Resources
* [Installing Windows Store](https://bonguides.com/how-to-install-apps-in-microsoft-store-in-windows-sandbox/)
  * [Main PowerShell script](https://raw.githubusercontent.com/bonguides25/PowerShell/main/WindowsSandbox/sandbox-store.ps1)
  * [XAML script](https://raw.githubusercontent.com/bonguides25/PowerShell/main/Utilities/microsoft.ui.xaml.ps1)
* [Clink](https://chrisant996.github.io/clink/clink.html)  
  * [github](https://github.com/chrisant996/clink)
* [Oh-My-Posh](https://ohmyposh.dev/)
  * [Installation on Windows](https://ohmyposh.dev/docs/installation/windows)
  * [Installing fonts](https://ohmyposh.dev/docs/installation/fonts)
  * [Nerd Fonts](https://www.nerdfonts.com/font-downloads)
* Windows Terminal
  * [Releases](https://github.com/microsoft/terminal/releases)