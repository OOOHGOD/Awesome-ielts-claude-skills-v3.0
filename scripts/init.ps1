# IELTS v3.0 - Windows PowerShell 初始化脚本
# 幂等：已存在则跳过

$IELTS_DIR = Join-Path $env:USERPROFILE ".ielts"

$dirs = @(
  "$IELTS_DIR\writing\essays",
  "$IELTS_DIR\reading\analyses",
  "$IELTS_DIR\listening\analyses",
  "$IELTS_DIR\speaking\stories",
  "$IELTS_DIR\vocabulary",
  "$IELTS_DIR\errors",
  "$IELTS_DIR\stats",
  "$IELTS_DIR\plans"
)

foreach ($dir in $dirs) {
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    Write-Host "Created: $dir"
  } else {
    Write-Host "Exists:  $dir"
  }
}

# config.yaml
$configPath = Join-Path $IELTS_DIR "config.yaml"
if (-not (Test-Path $configPath)) {
  @"
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
"@ | Set-Content -Path $configPath -Encoding UTF8
  Write-Host "Created: $configPath"
} else {
  Write-Host "Exists:  $configPath"
}

# synonym-master.md
$synPath = Join-Path $IELTS_DIR "vocabulary\synonym-master.md"
if (-not (Test-Path $synPath)) {
  @"
---
type: synonym-master
total: 0
source: [writing, reading, listening]
---

# 四科同义替换累计库

| 题目用词 | 原文/高分替换 | 来源 | 添加日期 |
|---------|-------------|------|---------|
"@ | Set-Content -Path $synPath -Encoding UTF8
  Write-Host "Created: $synPath"
} else {
  Write-Host "Exists:  $synPath"
}

# writing/synonym-library.md
$wslPath = Join-Path $IELTS_DIR "writing\synonym-library.md"
if (-not (Test-Path $wslPath)) {
  @"
---
type: synonym-library
source: writing
total: 0
---

# 写作同义替换库

| 原文用词 | 高分替换 | 添加日期 |
|---------|---------|---------|
"@ | Set-Content -Path $wslPath -Encoding UTF8
  Write-Host "Created: $wslPath"
} else {
  Write-Host "Exists:  $wslPath"
}

# reading/synonym-library.md
$rslPath = Join-Path $IELTS_DIR "reading\synonym-library.md"
if (-not (Test-Path $rslPath)) {
  @"
---
type: synonym-library
source: reading
total: 0
---

# 阅读同义替换库

| 题目用词 | 原文用词 | 添加日期 |
|---------|---------|---------|
"@ | Set-Content -Path $rslPath -Encoding UTF8
  Write-Host "Created: $rslPath"
} else {
  Write-Host "Exists:  $rslPath"
}

# error-book.md
$errPath = Join-Path $IELTS_DIR "errors\error-book.md"
if (-not (Test-Path $errPath)) {
  @"
---
type: error-book
total_errors: 0
last_updated: null
---

# 高频错题聚合

| 错误类型 | 频率 | 最近出现 | 典型案例 |
|---------|------|---------|---------|
"@ | Set-Content -Path $errPath -Encoding UTF8
  Write-Host "Created: $errPath"
} else {
  Write-Host "Exists:  $errPath"
}

# progress.md
$progPath = Join-Path $IELTS_DIR "stats\progress.md"
if (-not (Test-Path $progPath)) {
  @"
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
"@ | Set-Content -Path $progPath -Encoding UTF8
  Write-Host "Created: $progPath"
} else {
  Write-Host "Exists:  $progPath"
}

# word-bank.md
$wbPath = Join-Path $IELTS_DIR "vocabulary\word-bank.md"
if (-not (Test-Path $wbPath)) {
  @"
---
type: word-bank
total: 0
due_today: 0
---

# 间隔重复词库

## Words
"@ | Set-Content -Path $wbPath -Encoding UTF8
  Write-Host "Created: $wbPath"
} else {
  Write-Host "Exists:  $wbPath"
}

Write-Host ""
Write-Host "Done! ~/.ielts/ 初始化完成。"
Write-Host "运行 /ielts 开始使用。"
