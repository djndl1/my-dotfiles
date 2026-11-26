# Text Tool Call Format Reference

## Format specification

```
<tool-name>
  <param=arg1>value1</param>
  <param=arg2>value2</param>
</tool-name>
```

| Element | Syntax | Required | Notes |
|---------|--------|----------|-------|
| Opening tag | `<tool-name>` | Yes | Tool name: bash, read, write, edit, etc. |
| Parameter | `<param=name>value</param>` | Yes | One per argument |
| Closing tag | `</tool-name>` | Yes | Must match opening tag name |
| Value | Any text | Yes | Can span multiple lines |

## Supported pi tools and their parameters

| Tool | Parameters | Example |
|------|-----------|---------|
| bash | `command`, `timeout` | `<param=command>ls -la</param>` |
| read | `path`, `offset`, `limit` | `<param=path>src/main.cs</param>` |
| write | `path`, `content` | `<param=content>...</param>` |
| edit | `path`, `edits` | See EXAMPLES.md |
| lsp_diagnostics | `paths` | `<param=paths>[\"src/main.cs\"]</param>` |

## Regex used by the extension

Block: `/<([A-Za-z_][\w\-]*)>([\s\S]*?)<\/\1>/g`
Param: `/<param=([\w\-]+)>([\s\S]*?)<\/param>/g`

## Extension location

`~/.pi/agent/extensions/text-tool-call-interceptor.ts`

Load with: restart pi, `/reload`, or `pi -e ~/.pi/agent/extensions/text-tool-call-interceptor.ts`
