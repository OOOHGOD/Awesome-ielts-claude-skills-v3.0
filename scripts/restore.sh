#!/usr/bin/env bash
# IELTS v3.0 — 从 zip 恢复 ~/.ielts/
set -euo pipefail

BACKUP_FILE="${1:?Usage: restore.sh <backup-zip-file>}"

if [ ! -f "$BACKUP_FILE" ]; then
  echo "Error: 文件不存在: $BACKUP_FILE"
  exit 1
fi

if [ -d "$HOME/.ielts" ]; then
  echo "Warning: ~/.ielts/ 已存在。"
  read -p "覆盖？(y/N) " confirm
  if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Cancelled."
    exit 0
  fi
  rm -rf "$HOME/.ielts"
fi

cd "$HOME"
unzip "$BACKUP_FILE"
echo "Restored from: $BACKUP_FILE"
