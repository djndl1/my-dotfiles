---
name: text-tool-call-format
description: Instructs the model to emit tool calls as plain text in XML blocks (<tool-name><param=name>value</param></tool-name>) so the text-tool-call-interceptor pi extension can detect and execute them. Use when native tool calls are stripped or unsupported by the model provider.
---

# Text Tool Call Format Skill

## Quick start

When native tool calls are not reaching pi (they appear as empty or stripped in your view), use this skill to tell the model to emit tool calls as plain text inside assistant message content. The `text-tool-call-interceptor` extension detects these blocks, shows you a confirm dialog, and executes them via `pi.exec()`.

**Correct format:**
```xml
<bash>
<param=command>echo hello</param>
</bash>
```

**Rules:**
- Opening tag: `<tool-name>` — any tool name (bash, read, write, edit, etc.)
- Parameters: `<param=name>value</param>` — one per argument
- Closing tag: `</tool-name>` — must match the opening tag name
- Values can span multiple lines

## Workflows

### 1. Emit a bash tool call as text

When you need to run a shell command and native tool calls are unavailable:

```xml
<bash>
<param=command>dotnet build IronMakingIntegration/IronMakingIntegration.csproj -f net8.0</param>
</bash>
```

### 2. Emit a read tool call as text

```xml
<read>
<param=path>IronMakingIntegration/Startup.cs</param>
</read>
```

### 3. Multiple tool calls in one message

You can emit several blocks in sequence:

```xml
<bash>
<param=command>pwd</param>
</bash>

<read>
<param=path>appsettings.json</param>
</read>
```

## Review checklist

- [ ] Each block uses matching open/close tags (`<bash>...</bash>`)
- [ ] Each parameter uses `<param=name>value</param>` syntax
- [ ] No `...` placeholder values — use real values
- [ ] Tool name is a valid pi tool (bash, read, write, edit, etc.)
- [ ] The `text-tool-call-interceptor` extension is loaded in pi

## Advanced features

See `EXAMPLES.md` for more usage examples. See the `text-tool-call-interceptor` extension at `~/.pi/agent/extensions/text-tool-call-interceptor.ts` for the implementation that detects and executes these blocks.
