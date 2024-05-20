Set-ExecutionPolicy Bypass Process -Force
$ProgressPreference = 'SilentlyContinue'
& ((Split-Path $MyInvocation.InvocationName) + "/Install-DownloadablePackage.ps1") https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx
& ((Split-Path $MyInvocation.InvocationName) + "/Install-DownloadablePackage.ps1") https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx
& ((Split-Path $MyInvocation.InvocationName) + "/Install-DownloadablePackage.ps1") https://github.com/microsoft/terminal/releases/download/v1.20.11271.0/Microsoft.WindowsTerminal_1.20.11271.0_8wekyb3d8bbwe.msixbundle
