# Walter Codex Pet

Walter is a q-bouncy gray-blue dumpling pet for Codex.

## Files

- `pet/pet.json` - Codex pet manifest, `spriteVersionNumber: 2`.
- `pet/spritesheet.webp` - 8 x 11 v2 animated spritesheet, 192 x 208 per cell.
- `qa/contact-sheet-extended.png` - full contact sheet for visual review.
- `qa/focused-pupil-flatness-check.png` - focused QA sheet for the latest fixes.
- `qa/validation-extended.json` - deterministic atlas validation report.

## Install

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
