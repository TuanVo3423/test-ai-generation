import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/core/di/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const App());
}

