# Walter Codex Pet

Walter is a q-bouncy gray-blue dumpling pet for Codex.

## Files

- `pet/pet.json` - Codex pet manifest, `spriteVersionNumber: 2`.
- `pet/spritesheet.webp` - 8 x 11 v2 animated spritesheet, 192 x 208 per cell.
- `qa/contact-sheet-extended.png` - full contact sheet for visual review.
- `qa/focused-pupil-flatness-check.png` - focused QA sheet for the latest fixes.
- `qa/validation-extended.json` - deterministic atlas validation report.
- `notify/codex_notify.ps1` - Windows PowerShell notification player.
- `notify/codex_notify.bat` - convenience launcher for the notification script.
- `notify/run_with_codex_notify.ps1` - runs a command and plays the notification when it exits.
- `notify/[毒の語り手]終わったぞ......でいいか？.mp3` - bundled voice notification source.

## Install

### Pet

Copy the contents of `pet/` into:

```text
~/.codex/pets/walter/
```

The installed folder should contain:

```text
~/.codex/pets/walter/pet.json
~/.codex/pets/walter/spritesheet.webp
```

If Codex is already running and still shows an older Walter, switch pets once or restart Codex so the desktop app reloads the spritesheet.

Windows PowerShell example:

```powershell
git clone https://github.com/chinheki/walter-codex-pet.git
cd walter-codex-pet
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.codex\pets\walter"
Copy-Item -LiteralPath ".\pet\pet.json" -Destination "$env:USERPROFILE\.codex\pets\walter\pet.json" -Force
Copy-Item -LiteralPath ".\pet\spritesheet.webp" -Destination "$env:USERPROFILE\.codex\pets\walter\spritesheet.webp" -Force
```

### Voice Notification

The notification script plays the bundled MP3 from `notify/` by default:

```powershell
.\notify\codex_notify.bat done
.\notify\codex_notify.bat approval
```

Use `done` when a task finishes and `approval` when a task needs user approval. The current Codex desktop app may not automatically run repository hooks for every task state, so call this script from your own wrapper, automation, or agent workflow when those events happen.

To run a command and play the notification after it exits:

```powershell
.\notify\run_with_codex_notify.ps1 -Command "python .\your_script.py"
```

To use a different audio file:

```powershell
.\notify\codex_notify.ps1 -Event done -SoundPath "C:\path\to\sound.mp3"
```

## Agent Guidance

When installing Walter on another computer, do not regenerate or modify the pet art. Install the packaged v2 pet exactly as committed in this repository.

Recommended steps for an agent:

```bash
git clone https://github.com/chinheki/walter-codex-pet.git
mkdir -p "$HOME/.codex/pets/walter"
cp walter-codex-pet/pet/pet.json "$HOME/.codex/pets/walter/pet.json"
cp walter-codex-pet/pet/spritesheet.webp "$HOME/.codex/pets/walter/spritesheet.webp"
```

After copying, verify the manifest still points to the local spritesheet:

```bash
cat "$HOME/.codex/pets/walter/pet.json"
```

Expected manifest shape:

```json
{
  "id": "walter",
  "displayName": "Walter",
  "spriteVersionNumber": 2,
  "spritesheetPath": "spritesheet.webp"
}
```

The actual `description` field may be present and should be preserved. Keep `spriteVersionNumber` set to `2`; otherwise Codex may treat the asset as an older 9-row pet instead of the full 11-row v2 spritesheet.

## Notes

Walter's eyes intentionally have no black pupils. Look direction is represented by moving the whole pale-blue eye panels.
