@echo off
setlocal

rem If there are no command line arguments, exit
if _%1_==__ goto :usage

rem Download and install each package whose Url is specified on the command line
:loop
if _%1_==__ goto :EOF

rem Run the script
echo Starting download and install: %~nx1
powershell -ExecutionPolicy Bypass -NoLogo -File ./Install-DownloadablePackage.ps1 %1
if %ERRORLEVEL% NEQ 0 goto :error

rem Finished with the first Url, see if there are more
shift
goto :loop

:error
echo Error running: %1
goto :EOF

:usage
echo Usage:
echo   %~nx0 Url1 [Url2 ...]
goto :EOF