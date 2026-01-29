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
- **Golden Tests**: Use for complex UI layouts to prevent visual regressions (flutter_test).

## Navigation & Routing Tests

**CRITICAL**: Widget tests requiring navigation context must adapt to the selected Navigation Strategy.

- **AutoRoute**: Use `MockStackRouter` from `auto_route_generator` or wrap with a minimal `AutoRouter`.
- **GoRouter**: Wrap widgets in a `GoRouter` instance or mock the `GoRouter` provider.
- **Navigator 2.0**: Wrap in `MaterialApp` (provides basic Navigator) or use `RouterDelegate` mocks.
- **GetX**: Wrap in `GetMaterialApp` for named route testing.

## Implementation Process

### 1. Golden Workflow (MANDATORY ORDER)

1. Generate target golden assets (from Figma base image): [asset-golden_testing.md](references/asset-golden_testing.md)
2. Create/Update the page golden test file: [golden-tesing.md](references/golden-tesing.md)
3. Run goldens using the 2-attempt policy (Attempt 1 → 2).

### 2. Golden Attempts (Max 2, AI Retry Policy)

- Attempt 1 (strict): compare against target baselines (assets).
- If Attempt 1 fails: inspect golden diff images, identify all UI mismatches, update UI/layout code or test setup so the screen matches the Figma design at every diff, then rerun strict.
- Attempt 2 (strict retry): run the same strict comparison after fixing the UI; do not update golden images yet.
- If Attempt 2 still fails after code fixes: run `flutter test --update-goldens` to generate review images for human review.

### 3. Failure Artifacts

- Flutter writes strict mismatch diffs into: `assets/base_image_testing/golden/failures/`
- Before rerunning strict, clear `assets/base_image_testing/golden/failures/` so artifacts do not mix across runs.

## Reference & Examples

Golden references:

- [asset-golden_testing.md](references/asset-golden_testing.md)
- [golden-tesing.md](references/golden-tesing.md)

## Related Topics

layer-based-clean-architecture | dependency-injection | auto-route-navigation | go-router-navigation
