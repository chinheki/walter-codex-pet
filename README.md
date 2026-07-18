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

## Notes

Walter's eyes intentionally have no black pupils. Look direction is represented by moving the whole pale-blue eye panels.
