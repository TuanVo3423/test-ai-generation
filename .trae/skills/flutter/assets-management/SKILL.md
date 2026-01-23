---
name: Flutter Assets Management
description: Standards for asset naming, organization, and synchronization with design tools.
metadata:
  labels: [assets, images, icons, figma, naming-convention]
  triggers:
    files: ['assets/**']
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
| Bad (Reject) | Good (Accept) |
| :--- | :--- |
| `552ecefb-d09c.png` | `user_avatar_placeholder.png` |
| `Group 123.svg` | `ic_notification_badge.svg` |
| `IMG_2024.jpg` | `onboarding_background.jpg` |

## Organization

```text
assets/
├── images/ # Illustrations, photos, backgrounds
├── icons/ # Vector icons (SVG)
└── fonts/ # Custom font files
```

## Workflow
1.  **Rename in Figma**: Before exporting, rename the layer in Figma to a valid `snake_case` name.
2.  **Export**: Export the asset with the correct name.
3.  **Import**: Place in the corresponding `assets/` subdirectory.
4.  **Verification**: Do not commit random filenames.

## Related Topics

idiomatic-flutter | feature-based-clean-architecture
