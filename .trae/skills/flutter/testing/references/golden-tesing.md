# Golden Testing Reference (Screen Pages)

This document defines the required golden-testing layout and naming rules for any screen/page golden request in this repository.

## Required Folder Layout

When creating goldens for a page, the `test/` folder MUST look like this:

```text
test/
└── golden/
    ├── <page>_page_golden_test.dart
    └── goldens/
        └── <page>/
            ├── android/
            │   ├── <page>_page_galaxy_a54.png
            │   ├── <page>_page_galaxy_s24_ultra.png
            │   ├── <page>_page_galaxy_tab_s9.png
            │   ├── <page>_page_oneplus12.png
            │   ├── <page>_page_pixel4.png
            │   ├── <page>_page_pixel9.png
            │   └── <page>_page_redmi_note13.png
            └── ios/
                ├── <page>_page_iphone13.png
                ├── <page>_page_iphone14.png
                ├── <page>_page_iphone15.png
                ├── <page>_page_iphone16_pro_max.png
                └── <page>_page_iphone8.png
```

Reason: keeping all page goldens in a single predictable location makes automation (and future refactors) reliable, and keeps baseline images discoverable.

## Naming Rules

- `<page>` MUST be `snake_case` and match the UI page name (example: `profile`).
- Golden test file MUST be: `test/golden/<page>_page_golden_test.dart`.
- Baseline image file MUST be: `<page>_page_<device>.png`.
- Baseline images MUST be stored under:
  - `test/golden/goldens/<page>/android/`
  - `test/golden/goldens/<page>/ios/`

Reason: stable naming prevents duplicated goldens and makes diffs readable in code reviews.

## Device Matrix (MUST Generate)

Every page golden set MUST include exactly these devices:

- Android:
  - `galaxy_a54`
  - `galaxy_s24_ultra`
  - `galaxy_tab_s9`
  - `oneplus12`
  - `pixel4`
  - `pixel9`
  - `redmi_note13`
- iOS:
  - `iphone8`
  - `iphone13`
  - `iphone14`
  - `iphone15`
  - `iphone16_pro_max`

Reason: this covers common “small / regular / large / tablet” breakpoints on both platforms and reduces visual regressions across layouts.

## Test Implementation Template (Per-Device PNGs)

Use standard Flutter golden assertions (`matchesGoldenFile`) so each device produces its own PNG file matching the required structure.

Create `test/golden/<page>_page_golden_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class GoldenDevice {
  const GoldenDevice(this.name, this.size);

  final String name;
  final Size size;
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
    await _loadGoldenFonts();
    // ... and other setup if needed
  });

  const androidDevices = <GoldenDevice>[
    GoldenDevice('galaxy_a54', Size(360, 780)),
    GoldenDevice('galaxy_s24_ultra', Size(412, 915)),
    GoldenDevice('galaxy_tab_s9', Size(800, 1280)),
    GoldenDevice('oneplus12', Size(412, 919)),
    GoldenDevice('pixel4', Size(353, 745)),
    GoldenDevice('pixel9', Size(412, 915)),
    GoldenDevice('redmi_note13', Size(393, 873)),
  ];

  const iosDevices = <GoldenDevice>[
    GoldenDevice('iphone13', Size(390, 844)),
    GoldenDevice('iphone14', Size(390, 844)),
    GoldenDevice('iphone15', Size(393, 852)),
    GoldenDevice('iphone16_pro_max', Size(440, 956)),
    GoldenDevice('iphone8', Size(375, 667)),
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

## Updating and Running Goldens

Golden PNGs are stored directly under `test/golden/goldens/...` and are the only source of truth.

### Where baseline PNGs live

Store baseline images here:

- `test/golden/goldens/<page>/android/<page>_page_<device>.png`
- `test/golden/goldens/<page>/ios/<page>_page_<device>.png`

### Create or update baselines

Run this command to generate or update all PNGs for a page:

- `fvm flutter test --update-goldens test/golden/<page>_page_golden_test.dart`

### Compare without updating (optional)

Run this command to validate goldens without changing any PNGs:

- `fvm flutter test test/golden/<page>_page_golden_test.dart`
