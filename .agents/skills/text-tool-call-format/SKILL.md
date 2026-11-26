---
name: text-tool-call-format
description: Instructs the model to emit tool calls as plain text in DeepSeek DSML format so the pi-dsml extension can recover them into real tool calls. Use when native tool calls are stripped or unsupported by the model provider.
---

# Text Tool Call Format Skill

## Quick start

Once this skill is loaded, ALWAYS USE DSML tool calls instead of whatever tool calls you understand.

When native tool calls are not reaching pi (they appear as empty or stripped in your view), use this skill to emit tool calls as plain text in DeepSeek DSML format. The `pi-dsml` extension detects these blocks at `message_end` and recovers them into real tool calls so pi's agent loop can execute them.

**Correct format (canonical):**
```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="bash">
<｜DSML｜parameter name="command" string="true">echo hello</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

**Rules:**
- Block wrapper: `<｜DSML｜tool_calls>`
- Invoke tag: `<｜DSML｜invoke name="TOOLNAME">`
- Parameter: `<｜DSML｜parameter name="key" string="true">VALUE</｜DSML｜parameter>`
- `string="true"` means a raw string value; `string="false"` means a JSON value
- Values can span multiple lines
- All tool types are recovered equally (bash, read, write, edit, etc.)

## Workflows

### 1. Emit a bash tool call as text

When you need to run a shell command and native tool calls are unavailable:

```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="bash">
<｜DSML｜parameter name="command" string="true">dotnet build IronMakingIntegration/IronMakingIntegration.csproj -f net8.0</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

The pi-dsml extension recovers this into a real tool call, and pi's normal execution pipeline runs it (subject to `pi-permission-system` rules for bash commands).

### 2. Emit a non-bash tool call as text

Non-bash tools are recovered just like bash — they become real tool calls and pi handles execution normally:

```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="read">
<｜DSML｜parameter name="path" string="true">IronMakingIntegration/Startup.cs</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

### 3. Multiple tool calls in one message

You can emit several blocks in sequence. All are recovered into real tool calls:

```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="bash">
<｜DSML｜parameter name="command" string="true">pwd</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>

<｜DSML｜tool_calls>
<｜DSML｜invoke name="read">
<｜DSML｜parameter name="path" string="true">appsettings.json</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

## Review checklist

- [ ] Each block uses DSML format with `<｜DSML｜tool_calls>` wrapper
- [ ] Each invoke uses `<｜DSML｜invoke name="TOOLNAME">`
- [ ] Each parameter uses `<｜DSML｜parameter name="key" string="true">VALUE</｜DSML｜parameter>`
- [ ] No placeholder values — use real values
- [ ] All tool types are supported; pi-dsml recovers them equally
- [ ] The pi-dsml extension is loaded in pi
- [ ] pi-permission-system config governs allow/deny/ask for actual tool execution

## Configuration

Create `~/.pi/agent/extensions/pi-dsml.json`:

```json
{
  "enabled": true,
  "models": [],
  "hideWhileStreaming": true,
  "debug": false
}
```

| Key | Default | Meaning |
|-----|---------|---------|
| `enabled` | `true` | Turn the extension off without uninstalling |
| `models` | unset | Case-insensitive regex fragments; unset = all models |
| `hideWhileStreaming` | `true` | Hide DSML spans behind `⟨tool call⟩` while streaming |
| `debug` | `false` | Log `[pi-dsml] recovered=… stripped=…` to stderr |

## Advanced features

See EXAMPLES.md for more usage examples. See REFERENCE.md for the DSML grammar reference.

See the pi-dsml extension at `~/.pi/agent/npm/node_modules/pi-dsml/extensions/index.ts` for the implementation.

## System Prompt Reference (DSML Format)

This is the schema block that pi injects when tools are present. It tells the model to emit DSML tool calls:

```
You have access to a set of tools to help answer the user's question. You can invoke tools by writing a "<｜DSML｜tool_calls>" block like the following:
<｜DSML｜tool_calls>
<｜DSML｜invoke name="$TOOL_NAME">
<｜DSML｜parameter name="$PARAMETER_NAME" string="true|false">$PARAMETER_VALUE</｜DSML｜parameter>
...
</｜DSML｜invoke>
<｜DSML｜invoke name="$TOOL_NAME2">
...
</｜DSML｜invoke>
</｜DSML｜tool_calls>

String parameters should be specified as is and set `string="true"`. For all other types (numbers, booleans, arrays, objects), pass the value in JSON format and set `string="false"`.

An actual tool call in the assistant turn looks like:
<｜DSML｜tool_calls>
<｜DSML｜invoke name="function_name">
<｜DSML｜parameter name="param" string="true">string_value</｜DSML｜parameter>
<｜DSML｜parameter name="count" string="false">5</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls><｜｜end▁of▁sentence｜｜>

    string="true": the parameter value is a raw string.
    string="false": the parameter value is JSON (number, boolean, array, object).

Tool execution results are wrapped in <tool_result> tags within user messages:

<｜User｜><tool_result>{result_json}</tool_result><｜Assistant｜>

When multiple tool results are present, they are sorted by the order of the corresponding tool_calls in the preceding assistant message.
```

Tool results come back as `<tool_result>` tags in user messages — pi-dsml handles the recovery, pi's normal execution pipeline runs the tools.