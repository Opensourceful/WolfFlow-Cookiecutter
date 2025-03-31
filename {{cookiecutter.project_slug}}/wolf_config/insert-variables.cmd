@echo off
setlocal enabledelayedexpansion

echo wolfFlow Environment Setup Script (Windows)
echo =========================================
echo.
echo This script will update system prompt files with your local environment details.
echo.

REM Get system information
for /f "tokens=*" %%a in ('ver') do set OS_INFO=%%a
for /f "tokens=*" %%a in ('echo %COMSPEC%') do set SHELL_INFO=%%a
set HOME_DIR=%USERPROFILE%
set WORKSPACE_DIR=%CD%

echo Detected Environment:
echo - OS: %OS_INFO%
echo - Shell: %SHELL_INFO%
echo - Home Directory: %HOME_DIR%
echo - Workspace Directory: %WORKSPACE_DIR%
echo.

REM Create .wolf directory if it doesn't exist
if not exist ".wolf" (
    mkdir .wolf
    echo Created .wolf directory
)

REM Process system prompt files
echo Processing system prompt files...

REM Check if wolf_config\.wolf directory exists with system prompt files
if exist "wolf_config\.wolf\*" (
    echo Found system prompt files in wolf_config/.wolf
    for %%f in (wolf_config\.wolf\*) do (
        echo Processing %%f
        
        REM Read file content
        set "content="
        for /f "tokens=* delims=" %%l in (%%f) do (
            set "line=%%l"
            set "line=!line:OS_PLACEHOLDER=%OS_INFO%!"
            set "line=!line:SHELL_PLACEHOLDER=%SHELL_INFO%!"
            set "line=!line:HOME_PLACEHOLDER=%HOME_DIR%!"
            set "line=!line:WORKSPACE_PLACEHOLDER=%WORKSPACE_DIR%!"
            set "content=!content!!line!^

"
        )
        
        REM Get filename without path
        for %%i in (%%f) do set "filename=%%~nxi"
        
        REM Write updated content to .wolf directory
        echo !content! > .wolf\!filename!
        echo Updated .wolf\!filename!
    )
) else (
    echo No system prompt files found in wolf_config/.wolf
    
    REM Check if default-system-prompt.md exists
    if exist "default-system-prompt.md" (
        echo Found default-system-prompt.md
        
        REM Read file content
        set "content="
        for /f "tokens=* delims=" %%l in (default-system-prompt.md) do (
            set "line=%%l"
            set "line=!line:OS_PLACEHOLDER=%OS_INFO%!"
            set "line=!line:SHELL_PLACEHOLDER=%SHELL_INFO%!"
            set "line=!line:HOME_PLACEHOLDER=%HOME_DIR%!"
            set "line=!line:WORKSPACE_PLACEHOLDER=%WORKSPACE_DIR%!"
            set "content=!content!!line!^

"
        )
        
        REM Create system prompt files for each mode
        for %%m in (code architect ask debug test) do (
            echo !content! > .wolf\system-prompt-%%m
            echo Created .wolf\system-prompt-%%m
        )
    ) else (
        echo No default system prompt found. Please create system prompt files manually.
    )
)

echo.
echo Setup complete!
echo You can now use wolfFlow with your local environment settings.
echo.

endlocal