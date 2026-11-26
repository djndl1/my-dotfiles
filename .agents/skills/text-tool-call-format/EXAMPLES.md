# Text Tool Call Format Examples

## Example 1: Simple bash command

**Model output:**
```xml
<bash>
<param=command>echo "hello world"</param>
</bash>
```

**Extension behavior:** Shows confirm dialog → on approval runs `echo "hello world"` → displays result.

## Example 2: dotnet build

**Model output:**
```xml
<bash>
<param=command>dotnet build IronMakingIntegration/IronMakingIntegration.csproj -f net8.0 2>&1 | tail -20</param>
</bash>
```

## Example 3: Read a file

**Model output:**
```xml
<read>
<param=path>IronMakingIntegration/DatabaseModels/UploadDirectory.cs</param>
</read>
```

## Example 4: Multiple calls

**Model output:**
```xml
<bash>
<param=command>pwd</param>
</bash>

<bash>
<param=command>ls -la</param>
</bash>
```

## Example 5: Write with multi-line content

**Model output:**
```xml
<write>
<param=path>/tmp/test.txt</param>
<param=content>Hello
This is multi-line content
With several lines</param>
</write>
```
