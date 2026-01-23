# New Page Localization Template (GetX)

## 1) Add keys (locale_key.dart)

Example for `customer_detail` page:

```dart
class LocaleKey {
  const LocaleKey._();

  static const String customerDetailTitle = 'customer_detail_title';
  static const String customerDetailSave = 'customer_detail_save';
  static const String customerDetailDelete = 'customer_detail_delete';
}
```

## 2) Add translations (ALL languages)

`lang_en.dart`
```dart
const Map<String, String> langEn = {
  LocaleKey.customerDetailTitle: 'Customer detail',
  LocaleKey.customerDetailSave: 'Save',
  LocaleKey.customerDetailDelete: 'Delete',
};
```

`lang_ja.dart`
```dart
const Map<String, String> langJa = {
  LocaleKey.customerDetailTitle: '顧客詳細',
  LocaleKey.customerDetailSave: '保存',
  LocaleKey.customerDetailDelete: '削除',
};
```

## 3) Use in UI

```dart
Text(LocaleKey.customerDetailTitle.tr)
```

