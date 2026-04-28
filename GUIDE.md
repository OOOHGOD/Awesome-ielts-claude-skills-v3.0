# IELTS Claude Skills v3.0 使用指南

---

## 一、前置条件

| 需要什么 | 怎么确认 |
|---------|---------|
| Claude Code 已安装 | 终端输入 `claude` 能启动 |
| Node.js ≥ 18 | 终端输入 `node -v` 看版本 |
| 8 个 Skill 已复制 | 检查 `~/.claude/skills/` 下有 8 个文件夹 |
| 数据目录已初始化 | 检查 `~/.ielts/config.yaml` 是否存在 |

---

## 二、首次安装（一次性）

### 步骤 1：复制 Skills

```powershell
# Windows PowerShell
$skills = @('ielts','ielts-writing','ielts-reading','ielts-speaking','ielts-listening','ielts-vocab','ielts-diagnosis','ielts-dashboard')
foreach ($s in $skills) {
    Copy-Item -Recurse "A:\ielts-claude-skills-main\$s" "$env:USERPROFILE\.claude\skills\$s"
}
```

```bash
# Mac / Linux
for s in ielts ielts-writing ielts-reading ielts-speaking ielts-listening ielts-vocab ielts-diagnosis ielts-dashboard; do
  cp -r "$s" ~/.claude/skills/
done
```

### 步骤 2：初始化数据目录

```powershell
# Windows
.\scripts\init.ps1
```

```bash
# Mac / Linux
bash scripts/init.sh
```

### 步骤 3：安装 Dashboard

```bash
cd dashboard
npm install
```

### 步骤 4：重启 Claude Code

关闭并重新打开 Claude Code，输入 `/ielts` 验证能看到入口。

---

## 三、8 个 Skill 速查

| 命令 | 干什么 | 你需要提供什么 |
|------|--------|--------------|
| `/ielts` | 入口：摸底、路由、显示状态 | 不需要，直接输入 |
| `/ielts-writing` | 批改作文（四维评分 + 改写对比） | 题目 + 你的作文 |
| `/ielts-reading` | 分析阅读错题 | 文章 + 题目 + 你的答案 |
| `/ielts-speaking` | 生成口语素材（Part 2 + Part 3） | 话题，如"描述一次旅行" |
| `/ielts-listening` | 分析听力错题 | 听力题 + 你的答案 + 正确答案 |
| `/ielts-vocab` | 背单词（间隔重复 + 同义替换） | "复习单词"或"练同义替换" |
| `/ielts-diagnosis` | 全面诊断 + 生成备考计划 | 不需要，直接输入 |
| `/ielts-dashboard` | 启动浏览器可视化面板 | 不需要，直接输入 |

---

## 四、日常使用流程

### 场景 A：写作训练

```
1. 在 Claude Code 输入：
   /ielts-writing

2. 粘贴你的题目和作文：
   题目：Some people think technology has made our lives more stressful...
   作文：Many people believe that technology has a bad effect...

3. AI 输出：
   - 四维评分（TR/CC/LR/GRA，各 0-9 分）
   - 每个句子的具体问题标注
   - 改写成你目标分数的版本（对比学习）
   - 历史趋势："这是你第 5 篇，TR 从 5.0 → 5.5"
   - 提分优先级

4. 数据自动存档到 ~/.ielts/writing/essays/
```

也可以直接说"给我一道题"进入练习模式。

### 场景 B：阅读训练

```
1. 在 Claude Code 输入：
   /ielts-reading

2. 粘贴文章、题目、你的答案（和正确答案）：
   [粘贴剑桥真题的阅读文章]
   [粘贴题目]
   我的答案：1.A 2.C 3.TRUE ...
   正确答案：1.B 2.C 4.FALSE ...

3. AI 输出：
   - 每道错题的错因分析
   - 同义替换词表（核心产出）
   - T/F/NG 逻辑推导过程
   - 正确率统计

4. 数据自动存档到 ~/.ielts/reading/analyses/
```

### 场景 C：口语素材准备

```
1. 在 Claude Code 输入：
   /ielts-speaking

2. 告诉 AI 你的需求，比如：
   "帮我准备 Part 2：描述一次旅行"
   或
   "帮我分组这 50 个话题"（粘贴题库）

3. AI 输出：
   - 200-250 词的 Part 2 回答
   - 4-6 个 Part 3 追问预测 + 参考回答
   - 关键表达标注
   - 5 个万能故事覆盖 80% 话题

4. 素材自动存档到 ~/.ielts/speaking/stories/
```

### 场景 D：听力训练

```
1. 在 Claude Code 输入：
   /ielts-listening

2. 粘贴听力题和你的答案：
   [粘贴听力题目]
   我的答案：1.accommodation 2.C 3.thirty ...
   正确答案：1.accommodation 2.C 3.13 ...

3. AI 输出：
   - 每道错题的错因分类（拼写/同义替换/干扰/速度）
   - 拼写错误汇总
   - 精听训练建议

4. 数据自动存档到 ~/.ielts/listening/analyses/
```

### 场景 E：背单词

```
1. 在 Claude Code 输入：
   /ielts-vocab

2. 选择模式：
   "复习单词" → 间隔重复出题（SM-2 算法）
   "练同义替换" → 同义替换专练
   "写作词汇" → 按话题的高分表达
   "添加新词 significant" → 加到词库

3. AI 根据你的掌握程度调整复习间隔
   - 答对 → 间隔拉长
   - 答错 → 明天再来
```

### 场景 F：看诊断报告

```
1. 在 Claude Code 输入：
   /ielts-diagnosis

2. AI 读取你所有历史数据，输出：
   - 目标 vs 现状差距表
   - 四科趋势（上升/持平/下降）
   - 高频错误 Top 10
   - 提分优先级排序
   - 个性化每日备考计划
```

### 场景 G：打开 Dashboard

```
1. 先导出最新数据：
   cd A:\ielts-claude-skills-main
   node scripts/data-export.js dashboard/public/data

2. 启动：
   cd dashboard
   npm run dev

3. 浏览器自动打开 http://localhost:5173

4. 看到什么：
   - 考试倒计时
   - 写作四维分数走势图
   - 四科雷达图（当前 vs 目标）
   - 阅读/听力正确率趋势
   - 同义替换累计库（可搜索）
   - 高频错误排行
   - 词汇掌握进度
```

---

## 五、数据文件说明

所有训练数据存在 `~/.ielts/` 目录下（Windows 是 `C:\Users\你的用户名\.ielts\`）。

```
~/.ielts/
├── config.yaml                     ← 你的档案（目标分、考试日期）
│                                     可直接编辑修改
├── writing/
│   ├── essays/                      ← 每篇作文存档
│   │   └── 2026-04-28-task2-001.md
│   └── synonym-library.md           ← 写作同义替换库（自动累计）
├── reading/
│   ├── analyses/                    ← 每次阅读分析存档
│   │   └── 2026-04-28-passage-001.md
│   └── synonym-library.md           ← 阅读同义替换库
├── listening/
│   └── analyses/                    ← 每次听力分析存档
│       └── 2026-04-28-section3-001.md
├── speaking/
│   └── stories/                     ← 口语素材存档
│       └── 2026-04-28-travel.md
├── vocabulary/
│   ├── word-bank.md                 ← 间隔重复词库（自动更新间隔）
│   └── synonym-master.md            ← 四科汇总同义替换库
├── errors/
│   └── error-book.md                ← 高频错误聚合（自动更新）
├── stats/
│   └── progress.md                  ← 训练进度表（自动追加）
└── plans/
    └── study-plan.md                ← 备考计划（/ielts-diagnosis 生成）
```

### 修改配置

直接编辑 `~/.ielts/config.yaml`：

```yaml
target:
  overall: 7.0          # 改你的目标总分
  listening: 7.5        # 改各科目标
  reading: 7.5
  writing: 6.5
  speaking: 6.5

exam:
  date: "2026-08-16"    # 改你的考试日期

level:
  current: intermediate # beginner / intermediate / advanced
  mock_scores:          # 改你的模考成绩
    listening: 6.5
    reading: 7.0
    writing: 5.5
    speaking: 6.0

preferences:
  study_hours_per_day: 3  # 每天可用学习时间
  focus: writing           # 当前最想练的科目
```

---

## 六、刷新 Dashboard 数据

Dashboard 不会自动更新。每次训练完想看最新数据：

```bash
# 导出最新数据
cd A:\ielts-claude-skills-main
node scripts/data-export.js dashboard/public/data

# 如果 Dashboard 已经开着，刷新浏览器（F5）即可
# 如果没开：
cd dashboard
npm run dev
```

---

## 七、备份与恢复

### 备份

```powershell
# Windows PowerShell
.\scripts\backup.ps1
# 生成 ielts-backup-20260428-143000.zip
```

### 恢复（换电脑时）

```powershell
# Windows PowerShell
.\scripts\restore.ps1 ielts-backup-20260428-143000.zip
```

---

## 八、常见问题

**Q: 输入 /ielts 没反应？**
A: 检查 Skills 是否复制到了 `~/.claude/skills/`，并重启 Claude Code。

**Q: Dashboard 打开是空白的？**
A: 需要先导出数据：`node scripts/data-export.js dashboard/public/data`，然后刷新浏览器。

**Q: 想改目标分数？**
A: 直接编辑 `~/.ielts/config.yaml` 中的 `target` 部分。

**Q: 想清空所有数据重新开始？**
A: 删除 `~/.ielts/` 文件夹，重新运行 `init.ps1`。

**Q: Skill 批改的准不准？**
A: AI 评分普遍偏高 0.5 分。建议同时用 2-3 个工具交叉验证。

**Q: 数据存在哪里？会丢吗？**
A: 全部存在你电脑本地 `~/.ielts/`，不上传云端。定期用 `backup.ps1` 备份。

**Q: 口语怎么练？**
A: `/ielts-speaking` 只生成素材。实际开口练推荐用 Gemini Live 或 ChatGPT Voice。

**Q: 听力怎么做精听？**
A: `/ielts-listening` 输入"练精听"，AI 会给完整的精听步骤（盲听 → 做题 → 逐句写 → 分析 → 跟读）。

---

## 九、推荐每日备考节奏

```
早上：
  /ielts-vocab "复习单词"        ← 15-20 分钟

下午：
  /ielts-writing 批改 1 篇作文    ← 40-50 分钟
  或
  /ielts-reading 分析 1 篇阅读   ← 30-40 分钟

晚上：
  /ielts-speaking 准备 1 个话题   ← 20 分钟
  去 Gemini Live 模拟口语练习     ← 15 分钟

每周：
  /ielts-diagnosis                ← 看诊断报告，调整计划
  打开 Dashboard 看趋势图         ← 检查进度
```

---

## 十、文件结构速查

```
ielts-claude-skills/
├── ielts/                  ← /ielts     入口路由
├── ielts-writing/          ← /ielts-writing  写作批改
├── ielts-reading/          ← /ielts-reading  阅读分析
├── ielts-speaking/         ← /ielts-speaking 口语素材
├── ielts-listening/        ← /ielts-listening 听力分析
├── ielts-vocab/            ← /ielts-vocab    词汇训练
├── ielts-diagnosis/        ← /ielts-diagnosis 诊断+计划
├── ielts-dashboard/        ← /ielts-dashboard 启动面板
├── schemas/                ← 数据格式校验
├── scripts/
│   ├── init.sh / init.ps1  ← 初始化数据目录
│   ├── backup.sh / .ps1    ← 备份
│   ├── restore.sh / .ps1   ← 恢复
│   └── data-export.js      ← 导出数据到 Dashboard
├── dashboard/              ← React 可视化面板
└── GUIDE.md                ← 本文件
```
