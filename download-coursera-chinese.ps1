# Coursera课程下载脚本 - 只下载中文字幕
# 使用方法: .\download-coursera-chinese.ps1 [课程名]

param(
    [Parameter(Mandatory=$true)]
    [string]$CourseName
)

# 检查环境变量是否设置
if (-not $env:COURSERA_CAUTH) {
    Write-Error "环境变量 COURSERA_CAUTH 未设置"
    Write-Host "请先设置环境变量: `$env:COURSERA_CAUTH = 'your_token_here'"
    exit 1
}

Write-Host "开始下载课程: $CourseName" -ForegroundColor Green
Write-Host "使用中文字幕配置..." -ForegroundColor Yellow

# 使用环境变量中的cauth令牌和配置文件
try {
    & ".\venv39\Scripts\coursera-dl.exe" --cauth $env:COURSERA_CAUTH --config coursera-dl-chinese-only.conf $CourseName
    Write-Host "下载完成！" -ForegroundColor Green
}
catch {
    Write-Error "下载过程中出现错误: $_"
    exit 1
}
