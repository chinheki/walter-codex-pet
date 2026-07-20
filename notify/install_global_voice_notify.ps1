param(
    [string]$CodexHome = (Join-Path $env:USERPROFILE ".codex")
)

$ErrorActionPreference = "Stop"

$sourceDir = $PSScriptRoot
$targetDir = Join-Path $CodexHome "notify"
$configPath = Join-Path $CodexHome "config.toml"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backupPath = "$configPath.bak-voice-notify-$timestamp"

$scriptName = "codex_notify.ps1"
$batName = "codex_notify.bat"
$hookScriptName = "codex_notify_hook.ps1"
$soundName = "[毒の語り手]終わったぞ......でいいか？.mp3"

foreach ($name in @($scriptName, $batName, $hookScriptName, $soundName)) {
    $path = Join-Path $sourceDir $name
    if (-not (Test-Path -LiteralPath $path)) {
        Write-Error "Required notification file is missing: $path"
        exit 1
    }
}

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

Copy-Item -LiteralPath (Join-Path $sourceDir $scriptName) -Destination (Join-Path $targetDir $scriptName) -Force
Copy-Item -LiteralPath (Join-Path $sourceDir $batName) -Destination (Join-Path $targetDir $batName) -Force
Copy-Item -LiteralPath (Join-Path $sourceDir $hookScriptName) -Destination (Join-Path $targetDir $hookScriptName) -Force
Copy-Item -LiteralPath (Join-Path $sourceDir $soundName) -Destination (Join-Path $targetDir $soundName) -Force

if (Test-Path -LiteralPath $configPath) {
    Copy-Item -LiteralPath $configPath -Destination $backupPath -Force
    $lines = Get-Content -LiteralPath $configPath
} else {
    New-Item -ItemType Directory -Force -Path $CodexHome | Out-Null
    $lines = @()
}

$playerPath = Join-Path $targetDir $scriptName
$notifyLine = "notify = [ 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe', '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', '$playerPath', '-Event', 'done' ]"
$updated = $false

$output = foreach ($line in $lines) {
    if ($line -match '^\s*notify\s*=') {
        $updated = $true
        $notifyLine
    } else {
        $line
    }
}

if (-not $updated) {
    $output = @($notifyLine, "") + $lines
}

Set-Content -LiteralPath $configPath -Value $output -Encoding UTF8

$hooksPath = Join-Path $CodexHome "hooks.json"
$hooksBackupPath = "$hooksPath.bak-voice-notify-$timestamp"
$hookScriptPath = Join-Path $targetDir $hookScriptName

if (Test-Path -LiteralPath $hooksPath) {
    Copy-Item -LiteralPath $hooksPath -Destination $hooksBackupPath -Force
}

$hookCommandDone = "powershell -NoProfile -ExecutionPolicy Bypass -File `"$hookScriptPath`" -Event done"
$hookCommandApproval = "powershell -NoProfile -ExecutionPolicy Bypass -File `"$hookScriptPath`" -Event approval"

$hooksJson = [ordered]@{
    description = "Walter voice notifications for Codex turn completion and approval requests."
    hooks = [ordered]@{
        Stop = @(
            [ordered]@{
                hooks = @(
                    [ordered]@{
                        type = "command"
                        command = $hookCommandDone
                        commandWindows = $hookCommandDone
                        timeout = 5
                        statusMessage = "Playing Walter completion voice"
                    }
                )
            }
        )
        PermissionRequest = @(
            [ordered]@{
                matcher = ".*"
                hooks = @(
                    [ordered]@{
                        type = "command"
                        command = $hookCommandApproval
                        commandWindows = $hookCommandApproval
                        timeout = 5
                        statusMessage = "Playing Walter approval voice"
                    }
                )
            }
        )
    }
}

$hooksJson | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $hooksPath -Encoding UTF8

Write-Host "Installed Codex voice notification files to: $targetDir"
Write-Host "Updated global Codex config: $configPath"
if (Test-Path -LiteralPath $backupPath) {
    Write-Host "Backup written to: $backupPath"
}
Write-Host "Updated global Codex hooks: $hooksPath"
if (Test-Path -LiteralPath $hooksBackupPath) {
    Write-Host "Hooks backup written to: $hooksBackupPath"
}
