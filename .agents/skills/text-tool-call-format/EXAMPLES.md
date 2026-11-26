# Text Tool Call Format Examples

## Example 1: Simple bash command

**Model output:**
```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="bash">
<｜DSML｜parameter name="command" string="true">echo "hello world"</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

**Extension behavior:** pi-dsml recovers this into a real tool call at `message_end`. Pi's normal execution pipeline runs `echo "hello world"` (subject to `pi-permission-system` bash rules).

## Example 2: dotnet build

**Model output:**
```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="bash">
<｜DSML｜parameter name="command" string="true">dotnet build IronMakingIntegration/IronMakingIntegration.csproj -f net8.0 2>&1 | tail -20</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

## Example 3: Read a file

**Model output:**
```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="read">
<｜DSML｜parameter name="path" string="true">IronMakingIntegration/DatabaseModels/UploadDirectory.cs</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

## Example 4: Multiple calls

**Model output:**
```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="bash">
<｜DSML｜parameter name="command" string="true">pwd</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>

<｜DSML｜tool_calls>
<｜DSML｜invoke name="bash">
<｜DSML｜parameter name="command" string="true">ls -la</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```

## Example 5: Write with multi-line content

**Model output:**
```
<｜DSML｜tool_calls>
<｜DSML｜invoke name="write">
<｜DSML｜parameter name="path" string="true">PATH</｜DSML｜parameter>
<｜DSML｜parameter name="content" string="true">CONTENT</｜DSML｜parameter>
</｜DSML｜invoke>
</｜DSML｜tool_calls>
```