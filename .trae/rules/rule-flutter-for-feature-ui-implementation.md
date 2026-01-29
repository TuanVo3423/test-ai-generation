---
alwaysApply: false
---

# Rules Flutter Feature Implementation (Trae)

**SCOPE: THIS RULE APPLIES WHEN IMPLEMENTING FEATURES UI.**
(Does NOT apply to initial Project Bootstrap, FIX BUG, REFACTORING, THIS JUST ONLY FOR DO NEW UI FEATURE)

## P0 — Output Contract + Priority Gate (MANDATORY)

Any task assigned to the AI in this project is considered **DONE** only if:
 - the final output fully complies with the Output Contract and passes the Priority Gate.

### Output Contract (Post-LLM) — always runs last

The final response MUST contain **exactly two blocks** in this order:

1. `LOC_JSON` (machine-readable)
2. `LOC_HUMAN` (human-readable)
   If any required field/section is missing, the output is **INVALID** and must be regenerated.

## P1 — Architecture & Standards (MUST FOLLOW)

You MUST follow the standards defined in the following skills. Use these documents as the "Source of Truth" for your implementation.

### 1. Architecture & Core Logic

- **Structure**: `.trae/skills/flutter/feature-based-clean-architecture/SKILL.md`
- **Dependency Rules**: `.trae/skills/flutter/layer-based-clean-architecture/SKILL.md`
- **State Management (BLoC)**: `.trae/skills/flutter/bloc-state-management/SKILL.md`
- **Navigation (GoRouter)**: `.trae/skills/flutter/go-router-navigation/SKILL.md`

### 2. UI & Interaction

- **UI Implementation Standard**: `.trae/skills/flutter/ui-implementation-standard/SKILL.md`
- **Widget Best Practices**: `.trae/skills/flutter/widgets/SKILL.md`
- **Idiomatic Flutter**: `.trae/skills/flutter/idiomatic-flutter/SKILL.md`
- **Performance**: `.trae/skills/flutter/performance/SKILL.md`

### 3. Assets & Localization

- **Assets Management**: `.trae/skills/flutter/assets-management/SKILL.md`
  - Create/Update `lib/utils/app_assets.dart` manually.
  - Define static strings for all asset paths (e.g. `static const String iconUser = 'assets/icons/icon_user.svg';`).
- **Localization (GetX)**: `.trae/skills/flutter/getx-localization/SKILL.md`

### 4. UI Styling & Theming (MANDATORY)

- **AppColors**: All colors MUST be defined in `lib/src/utils/app_colors.dart`.
  - NO hardcoded hex codes in widgets (e.g. `Color(0xFF...)`). Use `AppColors.colorF7F7FA` instead.
- **AppStyles**: All text styles MUST be defined in `lib/src/utils/app_styles.dart`.
  - Use `AppStyles.h40(...)` instead of `TextStyle(...)`.
  - Detailed guideline: `.trae/skills/flutter/ui-implementation-standard/SKILL.md`

### 5. Quality Assurance

- **Testing (Golden-first)**: `.trae/skills/flutter/testing/SKILL.md`
  - This section is enforced. For every new UI feature page, you MUST execute all steps below yourself (do not just describe them).
  - Step 1: generate target baseline assets: `.trae/skills/flutter/testing/references/asset-golden_testing.md`
  - Step 2: generate/write golden test file: `.trae/skills/flutter/testing/references/golden-tesing.md`
  - Step 3: After retry, return a detailed result report including:
    - **Success**: If the golden test passes.
    - **Failure**: If the golden test fails, describe the differences and the expected behavior.
    - **Fixes**: List of changes made to fix the test.

## Workflow Checklist (Enforcement)

When implementing a feature, you MUST verify:

1.  **Architecture**: Are files in `lib/src/ui/<page>/`? Is logic in `interactor`?
2.  **Dependencies**: Does UI avoid direct API calls? Is DI used correctly?
3.  **Assets**: Are filenames `snake_case`? Are they defined in `lib/utils/app_assets.dart`?
    4.65→ **Localization**: Are strings in `locale_key.dart` + `lang_*.dart`?
    66→ **UI Components (CRITICAL)**: Are page widgets split into `lib/src/ui/<page>/components/`?
    67→ - **REJECT** if the Page file contains monolithic `build()` methods or complex widget trees.
    68→ **Styles**: Are `AppColors` and `AppStyles` used instead of hardcoded values?
    69→ **State**: Is `flutter_bloc` used with `Equatable` states?
4.  **State**: Is `flutter_bloc` used with `Equatable` states?
