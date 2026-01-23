# Shared vs Core

Use this rule to decide where code should live in a feature-based codebase.

## Core (`lib/src/core/`)

Put code here when it is:
- Cross-cutting infrastructure (router, theme, localization, networking base, logging)
- App-wide and not tied to any business feature
- Safe to be imported by any feature

## Shared (`lib/src/shared/`)

Put code here when it is:
- UI building blocks reused by multiple features (buttons, form fields, empty states)
- Shared domain models that are truly common across multiple features
- Not “infrastructure”, but still reusable

## Feature-local (`lib/src/features/<feature>/...`)

Default choice. Keep code inside the feature when it is:
- Only used by one feature (UI widgets, mappers, DTOs, validators, helpers)
- Business-specific (entities/use cases) or tightly coupled to the feature flows

## Rule of Thumb

- If only one feature uses it → keep it in that feature.
- If many features use it and it’s infrastructure-like → `core/`.
- If many features use it and it’s UI/shared model → `shared/`.

