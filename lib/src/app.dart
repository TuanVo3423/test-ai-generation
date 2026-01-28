import 'package:ai_generation/src/router/app_router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'NotoSansJP', useMaterial3: true),
      routerConfig: appRouter,
    );
  }
}
