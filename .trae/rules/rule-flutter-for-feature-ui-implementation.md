---
alwaysApply: false
---
# Rules Flutter Feature Implementation (Trae)

**SCOPE: THIS RULE APPLIES WHEN IMPLEMENTING FEATURES UI.**
(Does NOT apply to initial Project Bootstrap, FIX BUG, REFACTORING, THIS JUST ONLY FOR DO NEW UI FEATURE)

## P0 — Output Contract + Priority Gate (MANDATORY)

Any task assigned to the AI in githis project is considered **DONE** only if:
-  Golden test is ran and test passes. 
- Golden test is ran and test passes.
  **_Important:_** The golden test must pass for the feature to be considered, the maximum number of retries is 3 times. If the golden test fails after 3 retries, just consider the feature as **DONE**.

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
  - Step 1: generate target baseline assets: `.trae/skills/flutter/testing/references/asset-golden_testing.md`
  - Step 2: generate/write golden test file: `.trae/skills/flutter/testing/references/golden-tesing.md`
  - Step 3: run max 3 attempts (Attempt 1 → Attempt 2 strict vs assets, Attempt 3 `flutter test --update-goldens` for human review)

## Workflow Checklist (Enforcement)

When implementing a feature, you MUST verify:

1.  **Architecture**: Are files in `lib/src/ui/<page>/`? Is logic in `interactor`?
2.  **Dependencies**: Does UI avoid direct API calls? Is DI used correctly?
3.  **Assets**: Are filenames `snake_case`? Are they defined in `lib/utils/app_assets.dart`?
4.65→  **Localization**: Are strings in `locale_key.dart` + `lang_*.dart`?
66→  **UI Components (CRITICAL)**: Are page widgets split into `lib/src/ui/<page>/components/`?
67→    - **REJECT** if the Page file contains monolithic `build()` methods or complex widget trees.
68→  **Styles**: Are `AppColors` and `AppStyles` used instead of hardcoded values?
69→  **State**: Is `flutter_bloc` used with `Equatable` states?
7.  **State**: Is `flutter_bloc` used with `Equatable` states?
