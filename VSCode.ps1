# Installs User version of VS Code
#
# Run with:
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Make sure the progress bar doesn't show up - improves download time significantly
$ProgressPreference = 'SilentlyContinue'

Invoke-WebRequest -Uri 'https://update.code.visualstudio.com/latest/win32-x64-user/stable' -OutFile "$env:temp\vscode.exe"
& "$env:temp\vscode.exe" /verysilent /suppressmsgboxes
