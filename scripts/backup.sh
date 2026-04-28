#!/usr/bin/env bash
# IELTS v3.0 — 备份 ~/.ielts/ 到 zip
set -euo pipefail

IELTS_DIR="$HOME/.ielts"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_NAME="ielts-backup-${TIMESTAMP}.zip"
BACKUP_DIR="${1:-.}"

if [ ! -d "$IELTS_DIR" ]; then
  echo "Error: ~/.ielts/ 不存在。先运行 init.sh。"
  exit 1
fi

cd "$HOME"
zip -r "$BACKUP_DIR/$BACKUP_NAME" .ielts/ -x "*.log"
echo "Backup saved: $BACKUP_DIR/$BACKUP_NAME"
