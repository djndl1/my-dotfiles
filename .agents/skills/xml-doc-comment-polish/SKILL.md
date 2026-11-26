---
name: xml-doc-comment-polish
description: Polishes C# XML documentation comments to follow standard formatting rules: multi-line summary tags, no Markdown bold markers, member-specific descriptions (not design-doc copy-paste), and complete param/returns/remarks sections. Use when editing C# source files with XML doc comments that need standardization.
---

# C# XML 文档注释润色 (XML Doc Comment Polish)

## Quick start

对 C# 源代码中的 XML 文档注释（`/// <summary>` 等）进行标准化润色，使其符合团队规范，避免将设计文档直接复制粘贴到代码注释中。

核心操作：逐个文件检查 → 提请用户确认 → 执行替换。每批修改不超过 3–5 个文件，每个文件给出位置、原文、建议改写、修改理由。

## Workflows

### 1. `<summary>` 标签换行

**错误示例：**
```csharp
/// <summary>这是一个摘要。</summary>
```

**正确示例：**
```csharp
/// <summary>
/// 这是一个摘要。
/// </summary>
```

**规则：** `<summary>`、`</summary>` 必须各自占一行，内容也在中间行，不要写在同一行。

### 2. 去掉 Markdown 粗体标记 `**`

**错误示例：**
```csharp
/// <summary>这是**重要**说明。</summary>
```

**正确示例：**
```csharp
/// <summary>这是重要说明。</summary>
```

**规则：** XML 文档注释中不使用 `**` 等 Markdown 标记，直接用中文表达强调。

### 3. 成员专属说明，不复制粘贴设计文档

**错误示例：**
```csharp
/// <summary>
/// 设计文档第 5 节：系统整体架构说明……
/// </summary>
public void SomeMethod() { }
```

**正确示例：**
```csharp
/// <summary>
/// 解析设备位置读数。
/// </summary>
/// <param name="status">设备实时状态。</param>
/// <returns>位置读数；缺失时返回 null。</returns>
public int? ParsePosition(DevStatus status) { }
```

**规则：** 每个类/方法/属性的 XML 注释应描述**该成员本身**的作用、参数、返回值、行为，而不是设计文档的章节摘要。

### 4. 完整的参数与返回值说明

公开或内部方法应当包含：
- `<param name="xxx">`：说明每个参数的含义和约束
- `<returns>`：说明返回值的含义和可能的 null 情况
- `<remarks>`（可选）：补充行为细节、边界条件、线程安全等

**模板：**
```csharp
/// <summary>
/// 方法的一句话概述。
/// </summary>
/// <param name="param1">参数1说明。</param>
/// <param name="param2">参数2说明。</param>
/// <returns>返回值说明。</returns>
/// <remarks>
/// 补充行为细节（可选）。
/// </remarks>
```

## Review checklist

- [ ] `<summary>` 标签是否各自占一行？
- [ ] 注释中是否仍有 `**` Markdown 标记？
- [ ] 注释内容是否描述该成员本身，而非设计文档摘要？
- [ ] 公有/内部方法是否有 `<param>` 和 `<returns>`？
- [ ] 类/接口/枚举是否有 `<summary>`？
- <summary> 是否避免了 `⇒`、`①②` 等符号？

## Advanced features

参见 `REFERENCE.md` 中的前后对照表；参见 `EXAMPLES.md` 中基于 `FlowCtrl.Tracker.Service` 的真实修改示例。
