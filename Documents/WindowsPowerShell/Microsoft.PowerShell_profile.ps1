cd ~

Set-PSReadLineOption -EditMode Emacs

Del Alias:curl -ErrorAction SilentlyContinue
Del Alias:wget -ErrorAction SilentlyContinue

Function git-dotfile {
	        git --git-dir=$Env:HOME/.dotfiles --work-tree=$env:HOME $Args 
}

 Function Set-HongKong-Proxy {
	 $Local:HongkongProxy='http://djn:freebird@43.128.11.210:8888'
	 $Env:http_proxy=$Local:HongkongProxy
	 $Env:https_proxy=$Local:HongkongProxy
 }

 Function Unset-Proxy {
	 $Env:http_proxy=$Null
	 $Env:https_proxy=$Null
 }

 Function nvim-vim {
	nvim $args
 }

 Function nvim-qt-vim {
	nvim-qt -- $args
 }
 
 $SiteSpecificProfile = "$env:USERPROFILE/Documents/WindowsPowerShell/SiteSpecific.ps1"

if (Test-Path $SiteSpecificProfile) {
	. $SiteSpecificProfile
}


function Run-Dotnet-Development {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Executable
    )

    # Get the directory of the executable
    $executablePath = Get-Command $Executable -ErrorAction SilentlyContinue
    if (-not $executablePath) {
        Write-Error "Executable '$Executable' not found in PATH"
        return
    }

    $executableDir = Split-Path $executablePath.Source -Parent

    # Create a new process start info with the environment variables
    $processStartInfo = New-Object System.Diagnostics.ProcessStartInfo
    $processStartInfo.FileName = $executablePath.Source
    $processStartInfo.WorkingDirectory = $executableDir
    $processStartInfo.UseShellExecute = $false
    $processStartInfo.EnvironmentVariables["DOTNET_ENVIRONMENT"] = "Development"
    $processStartInfo.EnvironmentVariables["ASPNETCORE_ENVIRONMENT"] = "Development"

    # Copy current environment variables to preserve them
    foreach ($envVar in [System.Environment]::GetEnvironmentVariables().GetEnumerator()) {
        if ($envVar.Key -ne "DOTNET_ENVIRONMENT" -and $envVar.Key -ne "ASPNETCORE_ENVIRONMENT") {
            $processStartInfo.EnvironmentVariables[$envVar.Key] = $envVar.Value
        }
    }

    # Start the process asynchronously
    $process = [System.Diagnostics.Process]::Start($processStartInfo)

    Write-Host "Started $Executable in Development environment (PID: $($process.Id))"
    return $process
}
