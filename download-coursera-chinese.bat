@echo off
REM Coursera Course Download Script - Chinese Subtitles Only
REM Usage: download-coursera-chinese.bat [course_name]

REM Check if environment variable is set
if "%COURSERA_CAUTH%"=="" (
    echo Error: Environment variable COURSERA_CAUTH is not set
    echo.
    echo Please set the environment variable using PowerShell:
    echo [Environment]SetEnvironmentVariable("COURSERA_CAUTH", "your_token", "User")
    echo.
    echo Or using Command Prompt:
    echo setx COURSERA_CAUTH "your_token"
    echo.
    echo After setting, restart your command prompt or PowerShell.
    pause
    exit /b 1
)

REM Check if course name is provided
if "%1"=="" (
    echo Usage: download-coursera-chinese.bat [course_name]
    echo Example: download-coursera-chinese.bat product-management-an-introduction
    pause
    exit /b 1
)

echo Starting download for course: %1
echo Using Chinese subtitle configuration...
echo.

REM Use cauth token from environment variable with Chinese subtitles only
.\venv39\Scripts\coursera-dl.exe --cauth "%COURSERA_CAUTH%" --subtitle-language zh-CN "%1"

echo.
echo Download completed!
pause