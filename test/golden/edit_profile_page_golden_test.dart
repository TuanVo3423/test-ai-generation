import 'dart:io';

import 'package:ai_generation/src/localization/app_translations.dart';
import 'package:ai_generation/src/ui/edit_profile/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class GoldenDevice {
  const GoldenDevice(this.name, this.size);
  final String name;
  final Size size;
}

void _configureComparator() {
  const goldenBase = String.fromEnvironment(
    'GOLDEN_BASE',
    defaultValue: 'assets',
  );
  final projectRoot = Platform.environment['PWD'] ?? Directory.current.path;
  final root = Directory(projectRoot).uri;

  final baseUri = goldenBase == 'assets'
      ? root.resolve('assets/base_image_testing/golden/_baseline.dart')
      : root.resolve('test/golden/_review.dart');

  goldenFileComparator = LocalFileComparator(baseUri);
}

Future<void> _loadFonts() async {
  final loader = FontLoader('NotoSansJP')
    ..addFont(rootBundle.load('assets/fonts/NotoSansJP-Regular.ttf'))
    ..addFont(rootBundle.load('assets/fonts/NotoSansJP-Bold.ttf'));
  await loader.load();
}

Future<void> _precacheAssets(WidgetTester tester) async {
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

  await tester.pump(const Duration(milliseconds: 500));
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
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: const Locale('ja', 'JP'),
      fallbackLocale: const Locale('ja', 'JP'),
      theme: ThemeData(
        platform: platform,
        fontFamily: 'NotoSansJP',
        useMaterial3: true,
      ),
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: child,
      ),
    ),
  );

  await _precacheAssets(tester);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    Get.testMode = true;
    await _loadFonts();
  });

  const android = [GoldenDevice('galaxy_s24_ultra', Size(412, 915))];
  const ios = [GoldenDevice('iphone16_pro_max', Size(440, 956))];

  group('edit_profile page', () {
    setUp(_configureComparator);

    for (final d in android) {
      testWidgets('android - ${d.name}', (t) async {
        await pumpForGoldenDevice(
          t,
          platform: TargetPlatform.android,
          size: d.size,
          child: const EditProfilePage(),
        );

        final projectRoot = Platform.environment['PWD'] ?? Directory.current.path;
        final baseline = File(
          '$projectRoot/assets/base_image_testing/golden/goldens/edit_profile/android/edit_profile_page_${d.name}.png',
        );
        expect(
          baseline.existsSync(),
          isTrue,
          reason: 'Missing baseline: ${baseline.path}',
        );

        await expectLater(
          find.byType(EditProfilePage),
          matchesGoldenFile('goldens/edit_profile/android/edit_profile_page_${d.name}.png'),
        );
      });
    }

    for (final d in ios) {
      testWidgets('ios - ${d.name}', (t) async {
        await pumpForGoldenDevice(
          t,
          platform: TargetPlatform.iOS,
          size: d.size,
          child: const EditProfilePage(),
        );

        final projectRoot = Platform.environment['PWD'] ?? Directory.current.path;
        final baseline = File(
          '$projectRoot/assets/base_image_testing/golden/goldens/edit_profile/ios/edit_profile_page_${d.name}.png',
        );
        expect(
          baseline.existsSync(),
          isTrue,
          reason: 'Missing baseline: ${baseline.path}',
        );

        await expectLater(
          find.byType(EditProfilePage),
          matchesGoldenFile('goldens/edit_profile/ios/edit_profile_page_${d.name}.png'),
        );
      });
    }
  });
}

