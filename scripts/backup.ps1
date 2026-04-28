# IELTS v3.0 - Windows PowerShell 备份脚本
# Usage: .\backup.ps1 [output-dir]

$IELTS_DIR = Join-Path $env:USERPROFILE ".ielts"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backupName = "ielts-backup-$timestamp.zip"
$outputDir = if ($args[0]) { $args[0] } else { "." }

if (-not (Test-Path $IELTS_DIR)) {
    Write-Host "Error: ~/.ielts/ 不存在。先运行 init.ps1。" -ForegroundColor Red
    exit 1
}

$backupPath = Join-Path (Resolve-Path $outputDir) $backupName

Compress-Archive -Path $IELTS_DIR -DestinationPath $backupPath -Force
Write-Host "Backup saved: $backupPath" -ForegroundColor Green
