import 'package:ai_generation/src/localization/lang_en.dart';
import 'package:ai_generation/src/localization/lang_ja.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  AppTranslations();

  @override
  Map<String, Map<String, String>> get keys => <String, Map<String, String>>{
        'en_US': langEn,
        'ja_JP': langJa,
      };
}
