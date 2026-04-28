# IELTS v3.0 - Windows PowerShell 恢复脚本
# Usage: .\restore.ps1 <backup-zip-file>

param(
    [Parameter(Mandatory=$true)]
    [string]$BackupFile
)

$IELTS_DIR = Join-Path $env:USERPROFILE ".ielts"

if (-not (Test-Path $BackupFile)) {
    Write-Host "Error: 文件不存在: $BackupFile" -ForegroundColor Red
    exit 1
}

if (Test-Path $IELTS_DIR) {
    Write-Host "Warning: ~/.ielts/ 已存在。" -ForegroundColor Yellow
    $confirm = Read-Host "覆盖？(y/N)"
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        Write-Host "Cancelled."
        exit 0
    }
    Remove-Item -Recurse -Force $IELTS_DIR
}

# Expand-Archive extracts to a subfolder, need to handle that
$tempDir = Join-Path $env:TEMP "ielts-restore-$(Get-Random)"
Expand-Archive -Path $BackupFile -DestinationPath $tempDir -Force

# The zip may contain .ielts/ as top-level folder or directly the contents
$extracted = Get-ChildItem $tempDir -Directory | Select-Object -First 1
if ($extracted.Name -eq ".ielts") {
    Move-Item -Path $extracted.FullName -Destination $IELTS_DIR
} else {
    New-Item -ItemType Directory -Path $IELTS_DIR -Force | Out-Null
    Get-ChildItem $tempDir | Move-Item -Destination $IELTS_DIR
}

Remove-Item -Recurse -Force $tempDir
Write-Host "Restored from: $BackupFile" -ForegroundColor Green
