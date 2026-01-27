# Golden Testing Reference (Screen Pages)

This document defines the required golden-testing layout, naming rules, and the mandatory 3-attempt retry policy for any screen/page golden request in this repository.

Reason: keeping all page goldens in a single predictable location makes automation (and future refactors) reliable, and keeps baseline images discoverable.

## Attempt Artifacts (AI Workflow, Must Keep)

During each attempt, store failure artifacts under `.trae/skills/flutter/testing/` so the next retry can fix UI based on the latest failure output:

```text
.trae/skills/flutter/testing/
├── attempt_1/
│   └── failured/<page>/...
    └── goldens/
            └── <page>/
                ├── android/
                │   ├── <page>_page_galaxy_s24_ultra.png
                └── ios/
                    ├── <page>_page_iphone16_pro_max.png
├── attempt_2/
│   └── failured/<page>/...
    └── goldens/
            └── <page>/
                ├── android/
                │   ├── <page>_page_galaxy_s24_ultra.png
                └── ios/
                    ├── <page>_page_iphone16_pro_max.png
├── attempt_3/
    └── failured/<page>/...   
    └── goldens/
            └── <page>/
                ├── android/
                │   ├── <page>_page_galaxy_s24_ultra.png
                └── ios/
                    ├── <page>_page_iphone16_pro_max.png
```

## Generated Baseline Folder Layout (Attempt 1 & 2)

For Attempt 1 and Attempt 2, the expected baseline images MUST come from the generated directory produced by `generate_base_golden_assets.ps1`:

```text
assets/
└── base_image_testing/
    ├── <page>.png
    └── golden/
        └── goldens/
            └── <page>/
                ├── android/
                │   ├── <page>_page_galaxy_s24_ultra.png
                └── ios/
                    ├── <page>_page_iphone16_pro_max.png
```

Reason: Attempt 1 & 2 are strict comparisons against a deterministic baseline generated from a single base image.

## Naming Rules

- `<page>` MUST be `snake_case` and match the UI page name (example: `profile`).
- Golden test file MUST be: `test/golden/<page>_page_golden_test.dart`.
- Baseline image file MUST be: `<page>_page_<device>.png`.
- Generated baseline images (Attempt 1 & 2) MUST be stored under:
  - `assets/base_image_testing/golden/goldens/<page>/android/`
  - `assets/base_image_testing/golden/goldens/<page>/ios/`
- Review/output images (Attempt 3) MUST be stored under:
  - `test/golden/goldens/<page>/android/`
  - `test/golden/goldens/<page>/ios/`

Reason: stable naming prevents duplicated goldens and makes diffs readable in code reviews.

## Device Matrix (MUST Generate)

Every page golden set MUST include exactly these devices:

- Android:
  - `galaxy_s24_ultra`
- iOS:
  - `iphone16_pro_max`

Reason: this covers common “small / regular / large / tablet” breakpoints on both platforms and reduces visual regressions across layouts.

## Test Implementation Template (Per-Device PNGs)

Use standard Flutter golden assertions (`matchesGoldenFile`) so each device produces its own PNG file matching the required structure.

Create `test/golden/<page>_page_golden_test.dart`:

```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class GoldenDevice {
  const GoldenDevice(this.name, this.size);

  final String name;
  final Size size;
}

void _configureGoldenComparator() {
  const goldenBase = String.fromEnvironment('GOLDEN_BASE', defaultValue: 'assets');

  final projectRoot = Directory.current.uri;

  if (goldenBase == 'assets') {
    goldenFileComparator = LocalFileComparator(
      projectRoot.resolve('assets/base_image_testing/golden/'),
    );
    return;
  }

  goldenFileComparator = LocalFileComparator(
    projectRoot.resolve('test/golden/'),
  );
}

Future<void> _loadGoldenFonts() async {
  final fontLoader = FontLoader('NotoSansJP')
    ..addFont(rootBundle.load('assets/fonts/NotoSansJP-Regular.ttf'))
    ..addFont(rootBundle.load('assets/fonts/NotoSansJP-Bold.ttf'));
  await fontLoader.load();
}
// link: https://pub.dev/documentation/alchemist/latest/alchemist/precacheImages.html
Future<void> _precacheImages(WidgetTester tester) async {
  await tester.runAsync(() async {
    final images = <Future<void>>[];
    for (final element in find.byType(Image).evaluate()) {
      final widget = element.widget as Image;
      final image = widget.image;
      images.add(precacheImage(image, element));
    }
    for (final element in find.byType(FadeInImage).evaluate()) {
      final widget = element.widget as FadeInImage;
      final image = widget.image;
      images.add(precacheImage(image, element));
    }
    for (final element in find.byType(DecoratedBox).evaluate()) {
      final widget = element.widget as DecoratedBox;
      final decoration = widget.decoration;
      if (decoration is BoxDecoration && decoration.image != null) {
        final image = decoration.image!.image;
        images.add(precacheImage(image, element));
      }
    }
    await Future.wait(images);
  });
  await tester.pumpAndSettle();
}

Future<void> pumpForGoldenDevice(
  WidgetTester tester, {
  required TargetPlatform platform,
  required Size size,
  required Widget child,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;

  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData(platform: platform),
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: child,
      ),
    ),
  );
  // for precache images
  await _precacheImages(tester);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    _configureGoldenComparator();
    await _loadGoldenFonts();
    // ... and other setup if needed
  });

  const androidDevices = <GoldenDevice>[
    GoldenDevice('galaxy_s24_ultra', Size(412, 915)),
  ];

  const iosDevices = <GoldenDevice>[
    GoldenDevice('iphone16_pro_max', Size(440, 956)),
  ];

  group('<PageName> goldens', () {
    for (final device in androidDevices) {
      testWidgets('android - ${device.name}', (tester) async {
        await pumpForGoldenDevice(
          tester,
          platform: TargetPlatform.android,
          size: device.size,
          child: const Placeholder(),
        );

        await expectLater(
          find.byType(Placeholder),
          matchesGoldenFile(
            'goldens/<page>/android/<page>_page_${device.name}.png',
          ),
        );
      });
    }

    for (final device in iosDevices) {
      testWidgets('ios - ${device.name}', (tester) async {
        await pumpForGoldenDevice(
          tester,
          platform: TargetPlatform.iOS,
          size: device.size,
          child: const Placeholder(),
        );

        await expectLater(
          find.byType(Placeholder),
          matchesGoldenFile(
            'goldens/<page>/ios/<page>_page_${device.name}.png',
          ),
        );
      });
    }
  });
}
```

Reason: `matchesGoldenFile` gives precise control over the output path, which is required to enforce the `android/` and `ios/` folder split and per-device PNG files.

## Retry Policy (MUST Follow)

Every golden run for a page is limited to **max 3 attempts**:

1. **Attempt 1 (strict)**
   - Compare against generated baselines in `assets/base_image_testing/golden/goldens/`.
   - Command **MUST** use `--dart-define=GOLDEN_BASE=assets`.
   - If it fails, copy the generated failure artifacts into:
     - `.trae/skills/flutter/testing/attempt_1/failured/<page>/`
   - Use those failure artifacts as the primary input to fix UI for Attempt 2.
2. **Attempt 2 (strict retry)**
   - Same comparison as Attempt 1 after fixing layout issues.
   - Command **MUST** still use `--dart-define=GOLDEN_BASE=assets`.
   - If it fails, copy the generated failure artifacts into:
     - `.trae/skills/flutter/testing/attempt_2/failured/<page>/`
   - Use those failure artifacts as the primary input to fix UI for Attempt 3.
3. **Attempt 3 (escape hatch, last resort)**
   - Do NOT compare with target baselines in assets.
   - Generate review images using `--update-goldens` (should always succeed) with `--dart-define=GOLDEN_BASE=test`.
   - Output images are for human review under `test/golden/goldens/<page>/{android,ios}/`.
   - This attempt is allowed exactly once and must not be retried further.

Reason: Attempts 1–2 strictly guard against regressions using deterministic baselines. Attempt 3 is only for unblocking the pipeline while still generating artifacts for manual visual review.

## Running Goldens

- Prerequisite (Attempt 1 & 2): baseline PNGs MUST exist in `assets/base_image_testing/golden/goldens/<page>/{android,ios}/`.
- If baselines are missing, generate them first (from Figma base image):
  - Follow: `asset-golden_testing.md`
  - Requirements: ImageMagick (`magick`) installed; base image exists at `assets/base_image_testing/<page>.png`.
  - Windows PowerShell example:
    - `powershell -ExecutionPolicy Bypass -File .\.trae\skills\flutter\testing\scripts\generate_base_golden_assets.ps1 -Page <page>`
  - Output: `assets/base_image_testing/golden/goldens/<page>/{android,ios}/`.

- Attempt 1 (strict, required):
  - `fvm flutter test test/golden/<page>_page_golden_test.dart --dart-define=GOLDEN_BASE=assets`
- Attempt 2 (strict retry, required if Attempt 1 fails):
  - `fvm flutter test test/golden/<page>_page_golden_test.dart --dart-define=GOLDEN_BASE=assets`
- Attempt 3 (final fallback, only if Attempt 2 still fails):
  - `fvm flutter test --update-goldens test/golden/<page>_page_golden_test.dart --dart-define=GOLDEN_BASE=test`
  - Should always succeed and write review images under `test/golden/goldens/<page>/{android,ios}/`.
