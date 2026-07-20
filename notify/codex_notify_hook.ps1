param(
    [ValidateSet("done", "approval")]
    [string]$Event = "done"
)

$ErrorActionPreference = "Continue"

$notifyDir = $PSScriptRoot
$logPath = Join-Path $env:TEMP "codex_notify_hook.log"
$payload = [Console]::In.ReadToEnd()

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"[$timestamp] hook event=$Event payload_length=$($payload.Length)" | Add-Content -LiteralPath $logPath -Encoding UTF8 -ErrorAction SilentlyContinue

$player = Join-Path $notifyDir "codex_notify.ps1"
Start-Process -FilePath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -ArgumentList @(
    "-NoProfile",
    "-ExecutionPolicy",
    "Bypass",
    "-File",
    $player,
    "-Event",
    $Event
) -WindowStyle Hidden -ErrorAction SilentlyContinue | Out-Null

exit 0
