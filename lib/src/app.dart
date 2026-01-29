import 'package:ai_generation/src/localization/app_translations.dart';
import 'package:ai_generation/src/ui/edit_profile/edit_profile_page.dart';
import 'package:ai_generation/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/edit-profile',
      routes: [
        GoRoute(
          path: '/edit-profile',
          builder: (context, state) => const EditProfilePage(),
        ),
      ],
    );

    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'NotoSansJP',
        scaffoldBackgroundColor: AppColors.transparent,
      ),
      translations: AppTranslations(),
      locale: const Locale('ja', 'JP'),
      fallbackLocale: const Locale('ja', 'JP'),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
