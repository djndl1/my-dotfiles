# XML 文档注释润色示例

以下示例基于 `FlowCtrl.Tracker.Service` 项目的实际修改。

## 示例 1：summary 换行

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

## 示例 2：去掉 Markdown 粗体

**原文：**
```csharp
/// <summary>
/// 账本变化**档位**：决定“写不写账本、发哪条消息”。
/// </summary>
```

**改写：**
```csharp
/// <summary>
/// 账本变化档位：决定“写不写账本、发哪条消息”。
/// </summary>
```

## 示例 3：设计文档复制 → 成员专属说明

**原文：**
```csharp
/// <summary>
/// "(设备, 位置, 方向) → 地址 + 地址类型"的**内存解析器**（纯函数：无 IO、无 Redis、无 DB、不记日志）。
/// <para>
/// `FlFpDestination` 是唯一的"(设备, 位置, 方向) → 地址 + 类型"来源……
/// </para>
/// </summary>
public static class DestinationResolver
```

**改写：**
```csharp
/// <summary>
/// 纯函数内存解析器，将设备的 (位置, 方向) 读数解析为匹配的终点配置行及其子地址。
/// 类不维护状态、不做 IO、不记日志；告警通过可选的 <c>warnings</c> 集合回传给调用方。
/// </summary>
/// <remarks>
/// 本解析器提供两个入口：
/// <list type="bullet">
/// <item><see cref="Resolve"/>：把设备请求的位置/方向解析为一条地址 + 子地址。</item>
/// <item><see cref="Observe"/>：把一条地址自己的读数解析为观测子地址与是否落到该地址上。</item>
/// </list>
/// 轨位地址不经本解析器，由轨位定位算法负责。
/// </remarks>
public static class DestinationResolver
```
