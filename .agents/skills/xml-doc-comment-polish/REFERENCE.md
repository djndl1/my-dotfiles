# XML 文档注释替换对照表

本表基于对 `FlowCtrl.Tracker.Service` 项目的实际修改整理。

## 格式规范

| 项目 | 错误示例 | 正确示例 |
|------|---------|---------|
| `<summary>` 换行 | `/// <summary>摘要。</summary>` | `/// <summary>\n/// 摘要。\n/// </summary>` |
| Markdown 粗体 | `/// <summary>这是**重要**项。</summary>` | `/// <summary>这是重要项。</summary>` |
| 设计文档复制 | `/// <summary>设计文档第 5 节：系统架构……</summary>` | `/// <summary>本类用于解析设备位置。</summary>` |

## 符号替换

| 原文 | 建议改写 | 说明 |
|------|---------|------|
| `⇒` | “则”“所以”“若……则……” | 避免英文箭头 |
| `①` | “观测子地址”等完整术语 | 避免带圈数字 |
| `②` | “服务子地址”等完整术语 | 避免带圈数字 |

## 方法注释模板

```csharp
/// <summary>
/// 方法的一句话概述，描述该方法做什么。
/// </summary>
/// <param name="parameterName">参数说明，包括约束和可空性。</param>
/// <returns>返回值说明，包括 null 的含义。</returns>
/// <remarks>
/// 补充行为细节、边界条件、性能注意事项等（可选）。
/// </remarks>
```

## 实际修改案例（摘录）

### 案例 1：类注释从设计文本改为成员说明

**原文：**
```csharp
/// <summary>
/// 从 `DeviceBasic`（配置）+ `DevStatus`（实况）解析设备方向状态：
/// 形态看 `DirectionTagNames.Count`（1 ⇒ 单方向点……
/// </summary>
public static class DeviceDirectionAnalyzer
```

**改写：**
```csharp
/// <summary>
/// 从设备配置（<see cref="DeviceBasic"/>）与实时状态（<see cref="DevStatus"/>）解析设备方向状态。
/// 类为纯函数，不维护状态，仅基于输入参数计算结果。
/// </summary>
public static class DeviceDirectionAnalyzer
```

### 案例 2：方法补充 param/returns

**原文：**
```csharp
/// <summary>方向 OK 位（按配置选 `DirOK` 或 `DirOk2`）。</summary>
public static bool DirectionOk(DeviceBasic? basic, DevStatus? status)
```

**改写：**
```csharp
/// <summary>
/// 获取方向 OK 位。
/// </summary>
/// <param name="basic">设备配置，用于确定方向 OK 点位名。</param>
/// <param name="status">设备实时状态。</param>
/// <returns>方向 OK 位是否置位；设备或状态为 null 时返回 <c>false</c>。</returns>
public static bool DirectionOk(DeviceBasic? basic, DevStatus? status)
```
