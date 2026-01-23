---
name: GetX Localization Standard
description: Standards for GetX-based multi-language (locale_key + lang_*.dart). Invoke when generating a new page/feature or adding any user-facing text.
metadata:
  labels: [localization, getx, translations, i18n, multi-language]
  triggers:
    files: ['lib/**/locale_key.dart', 'lib/**/lang_*.dart', 'lib/**/app_translations.dart', 'lib/**/app.dart']
    keywords: [locale_key, lang_en, lang_ja, translate, translation, .tr, GetMaterialApp, Translations]
---

# GetX Localization Standard

## **Priority: P1 (HIGH)**

All user-facing text MUST be localized via **GetX Translations** using `locale_key.dart` + `lang_*.dart`.

## Core Rules (When generating a page)

### 1) locale_key.dart MUST be updated
- Add every new key used by the new page.
- Keys MUST be stable and semantic.
- Key naming format: `<feature>_<screen>_<element>` in `snake_case` (e.g. `customer_detail_title`).

### 2) ALL language files MUST be updated
Whenever a new key is added, you MUST update:
- `lang_en.dart`
- `lang_ja.dart`
- Any existing `lang_*.dart` languages in the project

No language is allowed to miss keys.

### 3) UI MUST use `.tr` (no raw strings)
- Always write: `LocaleKey.someKey.tr`
- Never hardcode labels like `'Home'`, `'ホーム'`, `'Trang chủ'` in widgets.

## Project Implementation (Source of Truth)

- Keys: `lib/src/core/localization/locale_key.dart`
- Translations:
  - `lib/src/core/localization/lang_en.dart`
  - `lib/src/core/localization/lang_ja.dart`
  - `lib/src/core/localization/lang_vi.dart`
- Registry: `lib/src/core/localization/app_translations.dart`
- App wiring: `lib/src/app.dart` uses `GetMaterialApp.router(...)` with `translations`, `supportedLocales`, `fallbackLocale`.

## Adding a New Language

1. Create `lang_<code>.dart` (e.g. `lang_ko.dart`) as `Map<String, String>`.
2. Register it in `AppTranslations.keys` using `<lang>_<COUNTRY>` (e.g. `ko_KR`).
3. Add the corresponding `Locale('<lang>', '<COUNTRY>')` to `supportedLocales`.
4. Ensure every key in `locale_key.dart` exists in the new language map.

## Quality Gates (Reject if violated)

- Any new page introduces raw strings in UI.
- `locale_key.dart` is changed but any `lang_*.dart` misses the same keys.
- Key names are generic or unstable (e.g. `title1`, `text_2`, random ids).

