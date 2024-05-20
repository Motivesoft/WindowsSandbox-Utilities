@echo off
setlocal

rem If there are no command line arguments, exit
if _%1_==__ goto :usage

rem Run each script specified on the command line
:loop
if _%1_==__ goto :EOF

rem Report and stop if the next script to execute is missing
if not exist %1 goto :missing

rem Run the script
echo Running script: %~nx1
powershell -ExecutionPolicy Bypass -NoLogo -File %1
if %ERRORLEVEL% NEQ 0 goto :error

rem Finished with the first script, see if there are more
shift
goto :loop

:missing
echo File not found: %1
goto :EOF

:error
echo Error running: %1
goto :EOF

:usage
echo Usage:
echo   %~nx0 script1.ps1 [script2.ps1 ...]
goto :EOF