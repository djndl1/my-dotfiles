---
name: chinese-tech-doc-polish
description: Polishes Chinese technical documentation to follow standard written Chinese conventions, replacing colloquial expressions, English arrows, circled numbers, and mixed symbols with proper Chinese phrasing. Use when editing Chinese Markdown technical docs that contain `⇒`, `→`, `①②`, colloquial phrases like "怎么" or "不挑", or need symbol-to-text conversion.
---

# 中文技术文档润色 (Chinese Tech Doc Polish)

## Quick start

用本 skill 对中文技术文档进行润色，使其符合一般中文书面语习惯。主要针对夹杂大量英文标识符、箭头符号、带圈数字、口语表达的中文 Markdown 文档。

核心操作：逐条检查 → 提请用户确认 → 执行替换。每批修改不超过 3 条，每条给出位置、原文、建议改写、修改理由。

## Workflows

### 1. 符号替换（优先处理）
- `⇒` → 改为“则”“所以”“若……则……”
- `→` → 改为中文冒号、“属于”、“即”
- `&&` → 改为“且”
- `①②` → 改为完整中文术语（如“观测子地址”“运输子地址”）
- 不要在正文段落中使用箭头符号，保留仅限代码块或伪代码

### 2. 用词替换
- “怎么”→“如何”
- “不挑/不猜/不丢”→“不做推断/不任选其一/状态不会丢失”
- “没配”→“未配”
- “看”→“依据/参考/查看”
- “里”→省略或改为“中”
- 技术文档默认描述当前版本，避免反复强调“现在”“当前行为”

### 3. 句式与叙述
- 避免第一人称“我们”
- 主语明确，避免“它”指代不明
- 长句拆分为 2–3 个短句
- “只用于：”→“只用于以下场景：”
- 避免破折号碎句，改用逗号或分句

### 4. 结构调整
- “文件职责”建议前移至第 2 节之后，或作为附录
- 表格标题不保留带圈数字
- 名词表中加上“表”字（如“终点表”“起点表”）

## Review checklist

- [ ] 正文中是否仍有 `⇒`、`→`、`①②`？
- [ ] 是否还有“怎么”“不猜”“不挑”等口语表达？
- [ ] 句子是否可拆分为更短的句子？
- [ ] 主语是否明确？
- [ ] 文件职责是否前移？

## Advanced features

See [REFERENCE.md](REFERENCE.md) for a detailed before/after replacement table. See [EXAMPLES.md](EXAMPLES.md) for worked examples from `FlowCtrl.Tracker.Service/Docs/MovableDeviceTracking.md`.
