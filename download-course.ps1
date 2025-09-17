# Coursera Course Download Script - Chinese Subtitles Only
# Usage: .\download-course.ps1 [course_name]

param(
    [Parameter(Mandatory=$true)]
    [string]$CourseName
)

# Check if environment variable is set
if (-not $env:COURSERA_CAUTH) {
    Write-Host "Error: Environment variable COURSERA_CAUTH is not set" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please set the environment variable using:" -ForegroundColor Yellow
    Write-Host "[Environment]::SetEnvironmentVariable('COURSERA_CAUTH', 'your_token', 'User')" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Then restart PowerShell and try again." -ForegroundColor Yellow
    exit 1
}

Write-Host "Starting download for course: $CourseName" -ForegroundColor Green
Write-Host "Using Chinese subtitle configuration..." -ForegroundColor Yellow
Write-Host ""

# Use cauth token from environment variable with Chinese subtitles only
try {
    & ".\venv39\Scripts\coursera-dl.exe" --cauth $env:COURSERA_CAUTH --subtitle-language zh-CN $CourseName
    Write-Host ""
    Write-Host "Download completed!" -ForegroundColor Green
}
catch {
    Write-Host ""
    Write-Host "Error during download: $_" -ForegroundColor Red
    exit 1
}
