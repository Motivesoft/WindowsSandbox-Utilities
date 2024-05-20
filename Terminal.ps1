# Installs Windows Terminal and dependencies
#
# Run with:
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Make sure the progress bar doesn't show up - improves download time significantly
$ProgressPreference = 'SilentlyContinue'

& ((Split-Path $MyInvocation.InvocationName) + "/Install-DownloadablePackage.ps1") https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx
& ((Split-Path $MyInvocation.InvocationName) + "/Install-DownloadablePackage.ps1") https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx
& ((Split-Path $MyInvocation.InvocationName) + "/Install-DownloadablePackage.ps1") https://github.com/microsoft/terminal/releases/download/v1.20.11271.0/Microsoft.WindowsTerminal_1.20.11271.0_8wekyb3d8bbwe.msixbundle
