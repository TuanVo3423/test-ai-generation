---
name: Flutter Navigation Manager (GoRouter Focus)
description: Routing strategy management with focus on GoRouter, but supporting AutoRoute, Navigator 2.0, and GetX choices.
metadata:
  labels: [navigation, go-router, routing, router, getx, navigator]
  triggers:
    files: ['**/router.dart', '**/app_router.dart', '**/routes.dart', 'main.dart']
    keywords: [GoRouter, GoRoute, router, navigation, route, Navigator, GetX, AutoRoute]
---

# Flutter Navigation Strategy

## **CRITICAL PROTOCOL**

**Before changing navigation setup, you MUST:**
1.  **FOLLOW THE EXISTING ROUTER** if the project already uses one (do not re-pick a router for a single feature).
2.  **ASK** the user which routing solution they prefer only if this is a new project or no router exists:
    *   **AutoRoute** (Typed, Code-gen)
    *   **GoRouter** (Declarative, Official support)
    *   **Navigator 2.0** (Low-level, Declarative)
    *   **GetX** (Simple, Context-less)
3.  **Proceed** with the implementation guidelines for the selected router.

---

## Option 1: GoRouter (Detailed)

Type-safe deep linking and routing system using `go_router` and `go_router_builder`.

### Structure
```text
core/router/
├── app_router.dart # Router configuration
└── routes.dart # Typed route definitions (GoRouteData)
```

### Implementation Guidelines
- **Typed Routes**: Always use `GoRouteData` from `go_router_builder`. Never use raw path strings.
- **Root Router**: One global `GoRouter` instance registered in DI.
- **Sub-Routes**: Nest related routes using `TypedGoRoute` and children lists.
- **Redirection**: Handle Auth (Login check) in the `redirect` property of the `GoRouter` config.
- **Parameters**: Use `@TypedGoRoute` to define paths with `:id` parameters.
- **Transitions**: Define standard transitions (Fade, Slide) in `buildPage`.
- **Navigation**: Use `MyRoute().go(context)` or `MyRoute().push(context)`.

### Code Example
```dart
// Route Definition
@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  @override
  Widget build(context, state) => const HomePage();
}

// Router Config
final router = GoRouter(
  routes: $appRoutes,
  redirect: (context, state) {
    if (notAuthenticated) return '/login';
    return null;
  },
);
```

---

## Option 2: AutoRoute

Type-safe routing system with code generation using `auto_route`.
- Use `@RoutePage`, `@AutoRouterConfig`.
- Use generated route classes (e.g., `HomeRoute()`).
- See `auto-route-navigation` skill for full details.

---

## Option 3: Navigator 2.0 (Raw API)

Low-level declarative API.
- Implement `RouterDelegate` and `RouteInformationParser`.
- Complex; prefer packages unless necessary.

---

## Option 4: GetX

Simple, context-less navigation.
- Use `GetMaterialApp`.
- `Get.to()`, `Get.off()`, `Get.toNamed()`.

---

## Related Topics

layer-based-clean-architecture | auto-route-navigation | security
