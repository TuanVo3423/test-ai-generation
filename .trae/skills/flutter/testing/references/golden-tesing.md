# Golden Tests for Screens (Checklist)

Goal: create a screen/page golden test with a strict baseline (Attempt 1–2) and a 3-attempt retry policy.

## 0) Mandatory conventions

- `<page>`: snake_case (e.g. `sign_in`)
- Test file: `test/golden/<page>_page_golden_test.dart`
- Baselines (Attempt 1&2): `assets/base_image_testing/golden/goldens/<page>/{android,ios}/`
- Review output (Attempt 3): `test/golden/goldens/<page>/{android,ios}/`
- PNG name: `<page>_page_<device>.png`
- Device matrix (fixed):
  - android: `galaxy_s24_ultra` (412x915)
  - ios: `iphone16_pro_max` (440x956)

## 1) Step 1 — Generate target baseline assets (required for Attempt 1&2)

Follow: `.trae/skills/flutter/testing/references/asset-golden_testing.md`

Verify these files exist after Step 1:

```text
assets/base_image_testing/<page>.png
assets/base_image_testing/golden/goldens/<page>/android/<page>_page_galaxy_s24_ultra.png
assets/base_image_testing/golden/goldens/<page>/ios/<page>_page_iphone16_pro_max.png
```

## 2) Step 2 — Write the test (short template)

Create `test/golden/<page>_page_golden_test.dart` using this template:

```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class GoldenDevice {
  const GoldenDevice(this.name, this.size);
  final String name;
  final Size size;
}

void _configureComparator() {
  const goldenBase = String.fromEnvironment('GOLDEN_BASE', defaultValue: 'assets');
  final root = Directory.current.uri;
  goldenFileComparator = LocalFileComparator(
    goldenBase == 'assets'
        ? root.resolve('assets/base_image_testing/golden/')
        : root.resolve('test/golden/'),
  );
}

Future<void> _loadFonts() async {
  final loader = FontLoader('NotoSansJP')
    ..addFont(rootBundle.load('assets/fonts/NotoSansJP-Regular.ttf'))
    ..addFont(rootBundle.load('assets/fonts/NotoSansJP-Bold.ttf'));
  await loader.load();
}

Future<void> _precacheImages(WidgetTester tester) async {
  await tester.runAsync(() async {
    final futures = <Future<void>>[];
    for (final e in find.byType(Image).evaluate()) {
      futures.add(precacheImage((e.widget as Image).image, e));
    }
    for (final e in find.byType(FadeInImage).evaluate()) {
      futures.add(precacheImage((e.widget as FadeInImage).image, e));
    }
    for (final e in find.byType(DecoratedBox).evaluate()) {
      final d = (e.widget as DecoratedBox).decoration;
      if (d is BoxDecoration && d.image != null) {
        futures.add(precacheImage(d.image!.image, e));
      }
    }
    await Future.wait(futures);
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(platform: platform, fontFamily: 'NotoSansJP', useMaterial3: true),
      home: MediaQuery(data: MediaQueryData(size: size), child: child),
    ),
  );
  await _precacheImages(tester);
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    _configureComparator();
    await _loadFonts();
  });

  const android = [GoldenDevice('galaxy_s24_ultra', Size(412, 915))];
  const ios = [GoldenDevice('iphone16_pro_max', Size(440, 956))];

  group('<page> page', () {
    for (final d in android) {
      testWidgets('android - ${d.name}', (t) async {
        await pumpForGoldenDevice(t, platform: TargetPlatform.android, size: d.size, child: const Placeholder());
        await expectLater(find.byType(Placeholder), matchesGoldenFile('goldens/<page>/android/<page>_page_${d.name}.png'));
      });
    }
    for (final d in ios) {
      testWidgets('ios - ${d.name}', (t) async {
        await pumpForGoldenDevice(t, platform: TargetPlatform.iOS, size: d.size, child: const Placeholder());
        await expectLater(find.byType(Placeholder), matchesGoldenFile('goldens/<page>/ios/<page>_page_${d.name}.png'));
      });
    }
  });
}
```

## 3) Retry policy (max 3 attempts)

Attempt 1 (strict):

```powershell
flutter test test/golden/<page>_page_golden_test.dart --dart-define=GOLDEN_BASE=assets
```

If it fails: snapshot + clear failures:

```powershell
.\.trae\skills\flutter\testing\scripts\collect_golden_failures.ps1 -Attempt 1 -Page "<page>"
```

Attempt 2 (strict retry): rerun Attempt 1 after fixing UI.

Attempt 3 (escape hatch): generate review images (no strict compare):

```powershell
flutter test --update-goldens test/golden/<page>_page_golden_test.dart --dart-define=GOLDEN_BASE=test
```

## 4) Failure artifacts (required when there is a mismatch)

- Mismatch source: `assets/base_image_testing/golden/failures/`
- Snapshot into:
  - `.trae/skills/flutter/testing/attempt_1/failured/<page>/`
  - `.trae/skills/flutter/testing/attempt_2/failured/<page>/`
  - `.trae/skills/flutter/testing/attempt_3/failured/<page>/`
