import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home_page.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.home, // Temporary for development/preview
  routes: <RouteBase>[
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
