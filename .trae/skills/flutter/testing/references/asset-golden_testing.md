### asset_golden_testing

- This is ALWAYS step 1 for page goldens.
- Source of truth: full-screen UI screenshots exported from Figma.
- Each base image file must be named `<page>.png` (snake_case).
- Put base images in: `assets/base_image_testing/<page>.png`.
- Run the PowerShell script to generate the device-specific target baselines:

```powershell
.\.trae\skills\flutter\testing\scripts\generate_base_golden_assets.ps1 `
  -Page "<page>" `
  [-Mode "fit_width"|"fit_width_fill"|"contain"|"cover"|"contain_fill"]
```

- Requirements:
  - ImageMagick (`magick`) installed and on PATH.
  - Base image exists at `assets/base_image_testing/<page>.png`.

- Output (used by Attempt 1 & 2 strict comparisons):
  - `assets/base_image_testing/golden/goldens/<page>/<platform>/`
