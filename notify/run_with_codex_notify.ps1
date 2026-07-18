param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Command,

    [string]$SoundPath = ""
)

$ErrorActionPreference = "Continue"

powershell -NoProfile -Command $Command
$exitCode = $LASTEXITCODE

if ($SoundPath) {
    & "$PSScriptRoot\codex_notify.ps1" -Event done -SoundPath $SoundPath
} else {
    & "$PSScriptRoot\codex_notify.ps1" -Event done
}

exit $exitCode
