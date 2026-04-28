---
name: ielts-dashboard
description: |
  启动本地 IELTS Dashboard。React + Vite，浏览器查看备考数据可视化。
  触发方式：/ielts-dashboard、「打开仪表盘」「看看进度」「dashboard」
metadata:
  version: 3.0.0
---

# IELTS Dashboard — 本地可视化仪表盘

你负责帮用户启动本地 Dashboard，查看所有备考数据的可视化。

---

## 执行步骤

### Step 1：检查依赖

检查 `dashboard/` 目录下是否有 `node_modules/`：

- **没有** → 运行 `cd dashboard && npm install`
- **有** → 跳过

### Step 2：导出最新数据

运行 `node scripts/data-export.js dashboard/public/data`

这会把 `~/.ielts/` 下的所有数据导出为 JSON 文件，供 Dashboard 读取。

### Step 3：启动开发服务器

运行 `cd dashboard && npm run dev`

Vite dev server 默认在 `http://localhost:5173` 启动。

### Step 4：告知用户

```
Dashboard 已启动！

打开浏览器访问：http://localhost:5173

数据已从 ~/.ielts/ 导出。
如需刷新数据，运行：node scripts/data-export.js dashboard/public/data

关闭 Dashboard：在终端按 Ctrl+C
```

---

## Dashboard 包含的模块

| 模块 | 数据 | 展示形式 |
|------|------|---------|
| 考试倒计时 | config.yaml | 天数 + 目标分 |
| 写作分数趋势 | writing.json | 四维折线图 |
| 四科雷达图 | stats.json | 雷达图对比目标 |
| 阅读正确率 | reading.json | 折线图 + 题型分布饼图 |
| 听力正确率 | listening.json | 折线图 + 错因分布 |
| 错题热力图 | errors.json | 错误类型 × 日期 |
| 同义替换库 | synonyms.json | 可搜索表格 |
| 词库进度 | vocabulary.json | 掌握度分布 + 到期词数 |
| 备考计划 | plan.json | 每日任务清单 |

---

## 故障排除

**端口被占用：**
```
lsof -i :5173  # 查看占用进程
kill -9 {PID}  # 杀掉进程后重新启动
```

**数据不显示：**
- 确认 `~/.ielts/` 下有数据文件
- 重新运行 `node scripts/data-export.js dashboard/public/data`
- 刷新浏览器

**npm install 失败：**
- 确认 Node.js 版本 ≥ 18
- 删除 `node_modules/` 和 `package-lock.json` 后重试

---

## 边界

- 你不负责数据训练——只负责启动 Dashboard
- Dashboard 数据是静态导出的，不会自动更新——需要手动运行 data-export.js
- 你不修改数据
