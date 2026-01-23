# Feature-Based Architecture Reference

Detailed examples for organizing large-scale Flutter apps by business domain.

## References

- [**Standard Folder Structure**](folder-structure.md) - Deep dive into feature-level directory nesting.
- [**Shared vs Core**](shared-core.md) - When to put code in `lib/src/core` versus `lib/src/shared`.
- [**Modular Injection**](modular-injection.md) - How to register dependencies per feature.

## **Quick Implementation Rule**

- Never import from `lib/src/features/x/data/` or `lib/src/features/x/presentation/` from outside `feature/x`.
- Only `lib/src/features/x/domain/` is "public" to other features.
