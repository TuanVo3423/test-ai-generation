---
name: Flutter Assets Management
description: Standards for asset naming, organization, and synchronization with design tools.
metadata:
  labels: [assets, images, icons, figma, naming-convention]
  triggers:
    files: ["assets/**"]
    keywords: [asset, image, icon, png, svg, figma, export]
---

# Assets Management

## **Priority: P1 (HIGH)**

Strict conventions for asset filenames to ensure traceability between Design (Figma) and Code.

## Naming Convention

### **CRITICAL RULE: Figma Matching**
- **Filenames MUST match the layer/export name in Figma.**
- **Format**: `snake_case` (lowercase with underscores).
- **Prohibited**: Random strings, UUIDs, or generic names (e.g., `image_1.png`, `552ecefb...png`).

### **Examples**

| Bad (Reject)        | Good (Accept)                 |
| :------------------ | :---------------------------- |
| `552ecefb-d09c.png` | `user_avatar_placeholder.png` |
| `Group 123.svg`     | `ic_notification_badge.svg`   |
| `IMG_2024.jpg`      | `onboarding_background.jpg`   |

## Organization

```text
assets/
├── images/ # Illustrations, photos, backgrounds
├── icons/ # Vector icons (SVG)
├── base_image_testing/ # Golden testing baselines (Figma screenshots PNG)
└── fonts/ # Custom font files
```

## Workflow
1.  **Rename in Figma**: Before exporting, rename the layer in Figma to a valid `snake_case` name.
2.  **Export**: Export the asset with the correct name.
3.  **Import**: Place in the corresponding `assets/` subdirectory.
4.  **Verification**: Do not commit random filenames.

## Base Image (Golden Testing)

- **Purpose**: Store the baseline PNGs used for golden tests. These images come from **Figma screenshots** (source of truth).
- **Location**: `assets/base_image_testing/`
- **Format**: `.png` only
- **Naming**:
  - Must be `snake_case`
  - Must match the **Figma frame/screenshot export name**
- **Workflow (REQUIRED)**:
  - After saving `assets/base_image_testing/<page>.png`, ALWAYS generate the per-device baselines (android/ios device matrix) before running/reviewing golden tests.
  - Use the provided script at `.trae/skills/flutter/assets-management/scripts/generate_base_golden_assets.ps1`.
  - Reason: golden baselines are pixel-sensitive and must match the repository’s device matrix; generating them consistently avoids drift and missing-device failures.

### Generate per-device baselines (PowerShell)

Run from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\.trae\skills\flutter\assets-management\scripts\generate_base_golden_assets.ps1 `
  -Page sign_in
```

### Automation expectation (for this skill)

When a user adds/updates a base screenshot under `assets/base_image_testing/`, always propose (and if permitted, run) the script above to regenerate per-device baseline PNGs.

- **Rules**:
  - Do not compress/optimize these PNGs unless tests require it (pixel-perfect comparisons).
  - Do not generate new baselines from code output by default; only replace baselines when Figma intentionally changes.
  - Keep one canonical baseline per approved design state to avoid drift.

## Related Topics

idiomatic-flutter | feature-based-clean-architecture
