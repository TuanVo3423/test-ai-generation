---
name: Flutter Navigation Manager
description: Routing strategy management including AutoRoute, Navigator 2.0, GoRouter, and GetX.
metadata:
  labels: [navigation, routing, router, autoroute, gorouter, getx, navigator]
  triggers:
    files: ['**/router.dart', '**/app_router.dart', '**/routes.dart', 'main.dart']
    keywords: [router, navigation, route, Navigator, GoRouter, GetX, AutoRoute]
---

# Flutter Navigation Strategy

## **CRITICAL PROTOCOL**

**Before starting any UI implementation or navigation setup, you MUST:**
1.  **ASK** the user which routing solution they prefer for this feature/project:
    *   **AutoRoute** (Typed, Code-gen)
    *   **GoRouter** (Declarative, Official support)
    *   **Navigator 2.0** (Low-level, Declarative)
    *   **GetX** (Simple, Context-less)
2.  **Proceed** with the implementation guidelines for the selected router.

---

## Option 1: AutoRoute

Type-safe routing system with code generation using `auto_route`.

### Structure

```text
core/router/
├── app_router.dart # Router configuration
└── app_router.gr.dart # Generated routes
```

### Implementation Guidelines

- **@RoutePage**: Annotate all screen/page widgets with `@RoutePage()`.
- **Router Config**: Extend `_$AppRouter` and annotate with `@AutoRouterConfig`.
- **Typed Navigation**: Use generated route classes (e.g., `HomeRoute()`). Never use strings.
- **Nested Routes & Tabs**: Use `children` in `AutoRoute` for tabs. When navigating to a route with nested tabs, use the `children` parameter to define the initial active sub-route.
- **Guards**: Implement `AutoRouteGuard` for authentication/authorization logic.
- **Parameters**: Constructors of `@RoutePage` widgets automatically become route parameters.
- **Declarative**: Prefer `context.pushRoute()` or `context.replaceRoute()`.

For full AutoRoute configuration, see [references/REFERENCE.md](references/REFERENCE.md).

---

## Option 2: GoRouter

Declarative routing package supported by the Flutter team.

### Guidelines
- Define a `GoRouter` instance with `routes`.
- Use `context.go()` for declarative navigation (stack replacement).
- Use `context.push()` to push to the stack.
- Use `GoRoute` with `path` and `builder`.
- Handle redirection using `redirect`.

---

## Option 3: Navigator 2.0 (Raw API)

Low-level declarative API (`Router`, `Navigator`, `Pages`).

### Guidelines
- Implement `RouterDelegate` to manage the navigation stack.
- Implement `RouteInformationParser` to parse URLs.
- Use `Page` objects (e.g., `MaterialPage`) to describe the history stack.
- **Note**: Complex to implement from scratch; prefer packages like GoRouter or AutoRoute unless strictly necessary.

---

## Option 4: GetX

Simple, context-less navigation.

### Guidelines
- Use `GetMaterialApp` instead of `MaterialApp`.
- **Navigation**:
  - `Get.to(NextScreen())`: Push a new screen.
  - `Get.off(NextScreen())`: Replace current screen.
  - `Get.offAll(NextScreen())`: Remove all previous screens (e.g., Logout).
- **Named Routes**: Define `getPages` in `GetMaterialApp` and use `Get.toNamed('/next')`.

---

## Related Topics

go-router-navigation | layer-based-clean-architecture | getx-state-management
