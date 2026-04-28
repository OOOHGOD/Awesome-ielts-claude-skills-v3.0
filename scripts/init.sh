#!/usr/bin/env bash
# IELTS v3.0 — 初始化 ~/.ielts/ 目录结构
# 幂等：已存在则跳过

set -euo pipefail

IELTS_DIR="$HOME/.ielts"

dirs=(
  "$IELTS_DIR/writing/essays"
  "$IELTS_DIR/reading/analyses"
  "$IELTS_DIR/listening/analyses"
  "$IELTS_DIR/speaking/stories"
  "$IELTS_DIR/vocabulary"
  "$IELTS_DIR/errors"
  "$IELTS_DIR/stats"
  "$IELTS_DIR/plans"
)

for dir in "${dirs[@]}"; do
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "Created: $dir"
  else
    echo "Exists:  $dir"
  fi
done

# 初始化 config.yaml（仅首次）
if [ ! -f "$IELTS_DIR/config.yaml" ]; then
  cat > "$IELTS_DIR/config.yaml" << 'EOF'
target:
  overall: 7.0
  listening: 7.5
  reading: 7.5
  writing: 6.5
  speaking: 6.5

exam:
  date: "2026-07-15"

level:
  current: intermediate
  mock_scores:
    listening: 6.5
    reading: 7.0
    writing: 5.5
    speaking: 6.0

preferences:
  study_hours_per_day: 3
  focus: writing
EOF
  echo "Created: $IELTS_DIR/config.yaml"
else
  echo "Exists:  $IELTS_DIR/config.yaml"
fi

# 初始化同义替换主库
if [ ! -f "$IELTS_DIR/vocabulary/synonym-master.md" ]; then
  cat > "$IELTS_DIR/vocabulary/synonym-master.md" << 'EOF'
---
type: synonym-master
total: 0
source: [writing, reading, listening]
---

# 四科同义替换累计库

| 题目用词 | 原文/高分替换 | 来源 | 添加日期 |
|---------|-------------|------|---------|
EOF
  echo "Created: $IELTS_DIR/vocabulary/synonym-master.md"
else
  echo "Exists:  $IELTS_DIR/vocabulary/synonym-master.md"
fi

# 初始化写作同义替换库
if [ ! -f "$IELTS_DIR/writing/synonym-library.md" ]; then
  cat > "$IELTS_DIR/writing/synonym-library.md" << 'EOF'
---
type: synonym-library
source: writing
total: 0
---

# 写作同义替换库

| 原文用词 | 高分替换 | 添加日期 |
|---------|---------|---------|
EOF
  echo "Created: $IELTS_DIR/writing/synonym-library.md"
else
  echo "Exists:  $IELTS_DIR/writing/synonym-library.md"
fi

# 初始化阅读同义替换库
if [ ! -f "$IELTS_DIR/reading/synonym-library.md" ]; then
  cat > "$IELTS_DIR/reading/synonym-library.md" << 'EOF'
---
type: synonym-library
source: reading
total: 0
---

# 阅读同义替换库

| 题目用词 | 原文用词 | 添加日期 |
|---------|---------|---------|
EOF
  echo "Created: $IELTS_DIR/reading/synonym-library.md"
else
  echo "Exists:  $IELTS_DIR/reading/synonym-library.md"
fi

# 初始化错题本
if [ ! -f "$IELTS_DIR/errors/error-book.md" ]; then
  cat > "$IELTS_DIR/errors/error-book.md" << 'EOF'
---
type: error-book
total_errors: 0
last_updated: null
---

# 高频错题聚合

按错误类型聚合，按频率排序。

| 错误类型 | 频率 | 最近出现 | 典型案例 |
|---------|------|---------|---------|
EOF
  echo "Created: $IELTS_DIR/errors/error-book.md"
else
  echo "Exists:  $IELTS_DIR/errors/error-book.md"
fi

# 初始化进度文件
if [ ! -f "$IELTS_DIR/stats/progress.md" ]; then
  cat > "$IELTS_DIR/stats/progress.md" << 'EOF'
---
type: progress
---

# 训练进度追踪

## 写作
| 日期 | Task | TR | CC | LR | GRA | 总分 | 目标 |
|------|------|----|----|----|-----|------|------|

## 阅读
| 日期 | 文章 | 正确/总题 | 分数 |
|------|------|----------|------|

## 听力
| 日期 | Section | 正确/总题 | 分数 |
|------|---------|----------|------|

## 口语
| 日期 | 话题 | 万能故事组 |
|------|------|----------|
EOF
  echo "Created: $IELTS_DIR/stats/progress.md"
else
  echo "Exists:  $IELTS_DIR/stats/progress.md"
fi

# 初始化词库
if [ ! -f "$IELTS_DIR/vocabulary/word-bank.md" ]; then
  cat > "$IELTS_DIR/vocabulary/word-bank.md" << 'EOF'
---
type: word-bank
total: 0
due_today: 0
---

# 间隔重复词库

## Words
EOF
  echo "Created: $IELTS_DIR/vocabulary/word-bank.md"
else
  echo "Exists:  $IELTS_DIR/vocabulary/word-bank.md"
fi

echo ""
echo "Done! ~/.ielts/ 初始化完成。"
echo "运行 /ielts 开始使用。"
