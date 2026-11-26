# Text Tool Call Format Reference

## Format specification (DeepSeek DSML)

```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="TOOLNAME">
<｜DSML｜parameter name="arg1" string="true">value1</｜DSML｜parameter>
<｜DSML｜parameter name="arg2" string="true">value2</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

| Element | Syntax | Required | Notes |
|---------|--------|----------|-------|
| Block wrapper | `<｜DSML｜tool_calls>` | Yes | DSML block wrapper |
| Invoke tag | `<｜DSML｜invoke name="TOOLNAME">` | Yes | Tool name: bash, read, write, edit, etc. |
| Parameter | `<｜DSML｜parameter name="key" string="true">VALUE</｜DSML｜parameter>` | Yes | One per argument |
| string attribute | true = raw string, false = JSON value | No | Defaults to true |
| Value | Any text | Yes | Can span multiple lines |

## Supported pi tools and their parameters

| Tool | Parameters | Example |
|------|-----------|---------|
| bash | command, timeout | See below |
| read | path, offset, limit | See below |
| write | path, content | See below |
| edit | path, edits | See EXAMPLES.md |
| lsp_diagnostics | paths | See below |

**bash example:**
```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="bash">
<｜DSML｜parameter name="command" string="true">ls -la</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

**read example:**
```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="read">
<｜DSML｜parameter name="path" string="true">src/main.cs</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

**write example:**
```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="write">
<｜DSML｜parameter name="path" string="true">out.txt</｜DSML｜parameter>
<｜DSML｜parameter name="content" string="true">hello</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

**lsp_diagnostics example:**
```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="lsp_diagnostics">
<｜DSML｜parameter name="paths" string="true">["src/main.cs"]</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

## Execution behavior

pi-dsml recovers DSML text blocks into real tool calls at `message_end`. All tool types are recovered equally — pi-dsml does not distinguish between bash and non-bash tools. Pi's normal execution pipeline then handles each tool call, including `pi-permission-system` checks for bash commands and other tools.

## pi-dsml extension config

Create `~/.pi/agent/extensions/pi-dsml.json`:

| Key | Default | Meaning |
|-----|---------|---------|
| `enabled` | `true` | Turn the extension off without uninstalling |
| `models` | unset | Case-insensitive regex fragments; unset = all models |
| `hideWhileStreaming` | `true` | Hide DSML spans behind `⟨tool call⟩` while streaming |
| `debug` | `false` | Log `[pi-dsml] recovered=… stripped=…` to stderr |

## Extension location

`~/.pi/agent/npm/node_modules/pi-dsml/extensions/index.ts`

Load with: restart pi, `/reload`, or `pi -e ~/.pi/agent/npm/node_modules/pi-dsml/extensions/index.ts`

## pi-permission-system config

Read from `~/.pi/agent/extensions/pi-permission-system/config.json`:
- `permission.bash.<command>` or `permission.bash.*` → allow/deny/ask for bash commands
- `permission.<tool>` → allow/deny/ask for non-bash tools
- `permission.*` → global fallback
- Most specific (longest) glob pattern wins