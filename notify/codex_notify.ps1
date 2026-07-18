param(
    [ValidateSet("done", "approval")]
    [string]$Event = "done",

    [string]$SoundPath = ""
)

$ErrorActionPreference = "Stop"

if (-not $SoundPath) {
    $SoundPath = Join-Path $PSScriptRoot "[毒の語り手]終わったぞ......でいいか？.mp3"
}

if (-not (Test-Path -LiteralPath $SoundPath)) {
    Write-Error "Sound file not found: $SoundPath"
    exit 1
}

Add-Type -AssemblyName presentationCore

$player = New-Object System.Windows.Media.MediaPlayer
$player.Open([Uri]::new($SoundPath))

while (-not $player.NaturalDuration.HasTimeSpan) {
    Start-Sleep -Milliseconds 50
}

$player.Play()
Start-Sleep -Milliseconds ([Math]::Ceiling($player.NaturalDuration.TimeSpan.TotalMilliseconds) + 300)
$player.Close()

Write-Host "Codex notification played for: $Event"
