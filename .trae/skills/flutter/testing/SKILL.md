---
name: Flutter Testing Standards
description: Unit, widget, and integration testing using mocktail and bloc_test.
metadata:
  labels: [testing, junit, mocktail, bloc_test, golden-tests]
  triggers:
    files: ["**/test/**.dart"]
    keywords: [test, group, expect, mocktail, blocTest, when, any]
---

# Testing Standards

## **Priority: P1 (HIGH)**

Ensuring code reliability through multi-layered testing strategies.

## Structure

```text
test/
├── widget/ # UI component behavior
└── golden/ # Golden tests
```

## Implementation Guidelines

- **Mocks**: Use `mocktail` for type-safe, boilerplate-free mocking.
- **Unit Tests**: Focus on Repositories and Use Cases. Verify all success/failure paths.
- **BLoC Tests**: Use `blocTest` to verify state emission sequences.
- **Widget Tests**: Test high-value components (Buttons clicking, Loading indicators showing).
- **Robot Pattern**: Encapsulate widget interaction logic in "Robot" classes for readable tests.
- **Code Coverage**: Aim for 80%+ coverage on Domain and Presentation (Logic) layers.
- **Golden Tests**: Use for complex UI layouts to prevent visual regressions (Alchemist).

## Navigation & Routing Tests

**CRITICAL**: Widget tests requiring navigation context must adapt to the selected Navigation Strategy.

- **AutoRoute**: Use `MockStackRouter` from `auto_route_generator` or wrap with a minimal `AutoRouter`.
- **GoRouter**: Wrap widgets in a `GoRouter` instance or mock the `GoRouter` provider.
- **Navigator 2.0**: Wrap in `MaterialApp` (provides basic Navigator) or use `RouterDelegate` mocks.
- **GetX**: Wrap in `GetMaterialApp` for named route testing.

## Implementation Process

- **Always do golden test**: Follow the guidelines in `references/golden-testing.md` to ensure visual regressions are caught.


## Reference & Examples

For Golden testing templates examples:
See [references/golden-testing.md](references/golden-testing.md).

## Related Topics

layer-based-clean-architecture | dependency-injection | auto-route-navigation | go-router-navigation
