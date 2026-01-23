# Modular Injection (Per Feature)

This describes how to keep dependency wiring modular in a feature-based architecture.

## Goal

- Each feature owns its own DI registration.
- App composition wires features together without cross-feature concrete imports.

## Suggested Structure

```text
lib/src/
├── core/
│   └── di/
│       ├── di.dart
│       └── modules/
└── features/
    └── <feature>/
        └── di/
            └── <feature>_module.dart
```

## Rules

- Feature module registers only its own implementations (repos, data sources, services).
- Other features depend on the feature’s domain interfaces only.
- Third-party libs (Dio, storage, etc.) are registered in `core/di/modules/`.

