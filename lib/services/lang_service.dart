import 'package:autoverse/exports.dart';

class LocalizationService extends Translations {
  static const locale = Locale('en', 'US');
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {};

  Future<void> loadTranslations() async {
    final enData = await rootBundle.loadString('assets/langs/en.json');
    final ruData = await rootBundle.loadString('assets/langs/ru.json');

    keys.addAll({
      'en_US': Map<String, String>.from(jsonDecode(enData)),
      'ru_RU': Map<String, String>.from(jsonDecode(ruData)),
    });
  }

  void changeLocale(Locale locale) => Get.updateLocale(locale);
}
