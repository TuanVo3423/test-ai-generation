---
name: Flutter UI Implementation Standard
description: Strict rules for UI implementation, assets, and page component composition. Invoke when building screens/widgets or adding assets.
metadata:
  labels: [ui, widgets, assets, components, standards]
  triggers:
    files: ['lib/src/**/*.dart', 'assets/**', 'pubspec.yaml']
    keywords: [Widget, build, assets, SvgPicture, AppTheme, components, widgets]
---

# Flutter UI & Asset Implementation Standard

This skill defines the STRICT rules for implementing UI and handling assets to ensure consistency and prevent errors.

## 1. Asset Management (CRITICAL)
**Goal**: Prevent "random string" filenames and ensure design fidelity.

- **Rule 1.1: Rename on Ingestion**: NEVER leave assets with raw Figma export names (e.g., `mkl6t7hq...svg`).
  - **Action**: You MUST rename assets to semantic `snake_case` names before using them.
  - **Prefixes**:
    - Icons: `icon_<name>.svg` (e.g., `icon_user.svg`, `icon_back.svg`)
    - Navigation: `nav_<name>.svg` (e.g., `nav_home.svg`)
    - Images: `img_<name>.png`
    - Backgrounds: `bg_<name>.png`
- **Rule 1.2: Design Fidelity**: ALWAYS use the provided SVG/PNG assets from the design.
  - **FORBIDDEN**: Do NOT substitute design assets with Flutter's built-in `Icons.*` unless explicitly requested or if the asset is missing.
- **Rule 1.3: SvgPicture**: Use `flutter_svg` package and `SvgPicture.asset()` for all vector icons.

## 2. Coding Standards
**Goal**: Prevent common lint errors (like `const_with_non_const`) and ensure clean code.

- **Rule 2.1: Const Correctness**:
  - `BorderRadius.circular(N)` is **NOT CONST**.
  - **Correct (Const)**: `BorderRadius.all(Radius.circular(N))`
  - **Correct (Non-Const)**: Remove `const` keyword if using `BorderRadius.circular`.
- **Rule 2.2: Theming**:
  - Define all colors and gradients in `AppTheme` / `AppColors` first.
  - Use `ShaderMask` for gradient text.
  - Use `Container` with `BoxDecoration` for gradient backgrounds.

## 3. Implementation Process
1. **Analyze**: Review design screenshots and raw asset files.
2. **Prepare Assets**: Rename and move all required assets to `assets/images/`.
3. **Prepare Theme**: Update `AppTheme` with necessary colors and styles.
4. **Implement**: Build Widgets using the renamed assets and theme.

## 4. PAGE Components (CRITICAL)
**Goal**: Keep each screen maintainable by splitting page-specific UI blocks into `components/`.

- **PAGE component path (this repo)**: `lib/src/features/<feature>/presentation/components/`
- **PAGE components**: layout blocks and UI pieces only used by that page
- **Rule**: Page file is a composition root; delegate blocks to `components/` widgets
