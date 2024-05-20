# Windows Sandbox Utilities
Utilities, scripts, setup, information etc. for the Windows Sandbox

## Background
The Sandbox is great, but excludes some items that I typically require and this repo is meant to provide a quick and easy way to set up the Sandbox whenever we need it with the minimal of effort.

Example issues to solve:
* There is no Windows Store, meaning some things are difficult to set up
* Certain base packages are missing, meaning that installing other things may fail due to missing dependencies
* Windows Terminal is not installed
* Notepad is not installed

## PowerShell
Things reliant on the same infrastructure as the Windows Store - i.e. things that are not delivered by an 'msi' or similar installer - can often be set up using PowerShell. This requires extra effort and manually taking care of dependencies and so on, but is our best approach for this.

### Admin priviliges
The Windows Sandbox opens as though the logged-on user is an administrator and so the things we try and do are running with admin rights, but the following bit of PowerShell script is useful anyway as a general practice in this sort of situation.

```powershell
if (-not([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You need to have Administrator rights to run this script!`nPlease re-run this script as an Administrator in an elevated powershell prompt!"
    break
}
```

### Execution policies
Script execution requires an appropriate execution policy to be set onto the machine, for example:
```powershell
Set-ExecutionPolicy Bypass Process -Force
```
or
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

### Downloading files
A lot of the information below uses `Invoke-WebRequest` to download files from the internet. This is quite a slow process unless the progress bar is turned off first with the following command:
```powershell
$ProgressPreference = 'SilentlyContinue'
```

### Scripting hints and tips
Examine [preference variables](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables?view=powershell-7.4) for useful things to improve scripts.

## Software setup
When installing the packages listed below, we can use the script file contained in this repo, for example:
```shell
./Install-DownloadablePackage.ps1 https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx
```

### VC libs
It may be necessary to install VC libs. See [here](https://learn.microsoft.com/en-us/troubleshoot/developer/visualstudio/cpp/libraries/c-runtime-packages-desktop-bridge#how-to-install-and-update-desktop-framework-packages) for the latest appx links

```powershell
Invoke-WebRequest -Uri 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx' -OutFile "$env:temp\Microsoft.VCLibs.x64.14.00.Desktop.appx"
Add-AppxPackage -Path "$env:temp\Microsoft.VCLibs.x64.14.00.Desktop.appx"
```

### XAML
Packages requiring XAML support require a Microsoft package to be installed. It is necessary to specify the precise version here.

```powershell
# Invoke-WebRequest -Uri 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx' -OutFile 'Microsoft.UI.Xaml.2.7.x64.appx'
# Invoke-WebRequest -Uri 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.5/Microsoft.UI.Xaml.2.8.x64.appx' -OutFile 'Microsoft.UI.Xaml.2.8.x64.appx'
Invoke-WebRequest -Uri 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx' -OutFile "$env:temp\Microsoft.UI.Xaml.2.8.x64.appx"

# Add-AppxPackage Microsoft.UI.Xaml.2.7.x64.appx
# Add-AppxPackage Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage -Path "$env:temp\Microsoft.UI.Xaml.2.8.x64.appx"
```

### Windows Terminal
* Requires [XAML](#xaml) to have already been installed
* May require [VC libs](#vc-libs) to have already been installed

```powershell
Invoke-WebRequest -Uri 'https://github.com/microsoft/terminal/releases/download/v1.20.11271.0/Microsoft.WindowsTerminal_1.20.11271.0_8wekyb3d8bbwe.msixbundle' -OutFile "$env:temp\Microsoft.WindowsTerminal_1.20.msixbundle"
Add-AppxPackage -Path "$env:temp\Microsoft.WindowsTerminal_1.20.msixbundle"
```
Or:
```shell
./Install-DownloadablePackage.ps1 https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx
./Install-DownloadablePackage.ps1 https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx
./Install-DownloadablePackage.ps1 https://github.com/microsoft/terminal/releases/download/v1.20.11271.0/Microsoft.WindowsTerminal_1.20.11271.0_8wekyb3d8bbwe.msixbundle
```

### VS Code
```bat
REM Download Visual Studio Code
curl -L "https://update.code.visualstudio.com/latest/win32-x64-user/stable" --output C:\users\WDAGUtilityAccount\Downloads\vscode.exe

REM Install and run Visual Studio Code
C:\users\WDAGUtilityAccount\Downloads\vscode.exe /verysilent /suppressmsgboxes
```
or
```powershell
Invoke-WebRequest -Uri 'https://update.code.visualstudio.com/latest/win32-x64-user/stable' -OutFile "$env:temp\vscode.exe"
& "$env:temp\vscode.exe" /verysilent /suppressmsgboxes
```

### Notepad
Now this is a Store-based app, the Sandbox does not have Notepad installed by default. 

It seems that it must now be downloaded from the Windows Store or, if the store is not available, the [Notepad page in the online Windows Store](https://apps.microsoft.com/detail/9msmlrh6lzf3?hl=en-gb&gl=UK) provides a __Download__ button for an installer.

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
  * [Windows Sandbox Configuration](https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-configure-using-wsb-file)