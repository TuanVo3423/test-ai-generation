---
name: Flutter Error Handling
description: Typed error handling without exceptions crossing into UI/BLoC. Invoke when designing Failures, repository return types, or mapping Dio errors.
metadata:
  labels: [error-handling, result, failure, equatable]
  triggers:
    files: ['lib/src/**']
    keywords: [Result, Success, Failure, map, fold, DioException]
---

# Error Handling

## **Priority: P1 (HIGH)**

Standardized typed error handling using `Result<T>` and `Failure` models (no `dartz`, no `freezed` required).

## Implementation Guidelines

- **Result Pattern**: Return `Result<T>` from repositories. No exceptions in UI/BLoC.
- **Failures**: Define domain-specific failures as plain immutable classes (use `Equatable` when needed).
- **Mapping**: Infrastructure catches `Exception` and returns `FailureResult(Failure)`.
- **Consumption**: In BLoC, branch on success/failure to emit corresponding states.

## Reference & Examples

For Failure definitions and API error mapping:
See [references/REFERENCE.md](references/REFERENCE.md).

## Related Topics

layer-based-clean-architecture | bloc-state-management
