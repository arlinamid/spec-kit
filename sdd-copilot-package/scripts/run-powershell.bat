@echo off
REM Batch wrapper to run PowerShell scripts from Command Prompt
REM Usage: run-powershell.bat script-name [arguments]

if "%~1"=="" (
    echo Usage: run-powershell.bat script-name [arguments]
    echo.
    echo Available scripts:
    echo   get-feature-paths
    echo   check-task-prerequisites  
    echo   create-new-feature
    echo   setup-plan
    echo   update-agent-context
    echo   test-powershell-scripts
    echo.
    echo Example: run-powershell.bat get-feature-paths
    echo Example: run-powershell.bat create-new-feature "user authentication"
    exit /b 1
)

set SCRIPT_NAME=%~1
shift

REM Check if PowerShell is available
powershell -Command "Get-Host" >nul 2>&1
if errorlevel 1 (
    echo Error: PowerShell is not available or not in PATH
    exit /b 1
)

REM Run the PowerShell script
powershell -ExecutionPolicy Bypass -File "%~dp0%SCRIPT_NAME%.ps1" %*

exit /b %errorlevel%
