---
name: Flutter Asset Generation (flutter_gen)
description: Standards for using flutter_gen to generate strongly-typed asset access. Invoke when adding/using image/svg assets or when updating pubspec assets.
metadata:
  labels: [assets, flutter_gen, build_runner, images, icons, svg]
  triggers:
    files: ['pubspec.yaml', 'assets/**', 'lib/gen/**']
    keywords: [flutter_gen, fluttergen, build_runner, assets.gen.dart, gen, image, svg]
---

# Flutter Asset Generation (flutter_gen)

## **Priority: P1 (HIGH)**

Always use **flutter_gen** to access assets via generated, strongly-typed APIs. Do not hardcode asset paths in UI code.

## Rules

### 1) Naming & placement
- Follow the naming rules in **Assets Management**: all asset files MUST be semantic `snake_case`.
- Organize assets under:
  - `assets/images/` (photos, backgrounds, illustrations)
  - `assets/icons/` (SVG icons)
- Never reference assets with raw strings like `'assets/images/foo.png'`.

### 2) Required dependencies
Add these to `pubspec.yaml`:

```yaml
dev_dependencies:
  build_runner: ^2.0.0
  flutter_gen_runner: ^5.0.0
```

If the project uses SVG assets, ensure `flutter_svg` is in `dependencies` (flutter_gen will generate SVG helpers when available).

### 3) pubspec.yaml configuration
Declare assets as usual and configure flutter_gen output.

```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/

flutter_gen:
  output: lib/gen/
  line_length: 100
  integrations:
    flutter_svg: true
```

### 4) Generation workflow
After adding/renaming/removing any asset or changing `pubspec.yaml`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

During development (optional):

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### 5) Usage in code
- Import generated assets from `lib/gen/` and use the generated APIs.
- Prefer generated helpers for SVG instead of manual `SvgPicture.asset(...)` paths.

Examples (actual API names depend on your folder/file names):

```dart
Assets.images.onboardingBackground.image(fit: BoxFit.cover);
Assets.icons.icNotificationBadge.svg(width: 24, height: 24);
```

## Quality Gates (Reject if violated)
- Any new UI code references asset paths as raw strings.
- Assets are added with non-semantic filenames (UUIDs, `image_1.png`, `Group 123.svg`).
- `pubspec.yaml` assets change without re-generating `lib/gen/`.

## Related Topics

assets-management | ui-implementation-standard | security

