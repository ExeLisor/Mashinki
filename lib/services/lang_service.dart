import 'package:autoverse/exports.dart';

class LocalizationService extends GetxController {
  static LocalizationService get to => Get.find();

  final RxMap<String, String> enLocalized = <String, String>{}.obs;
  final RxMap<String, String> ruLocalized = <String, String>{}.obs;

  @override
  void onInit() async {
    await loadLocalizations();
    updateLocale(Get.deviceLocale ?? const Locale('en', 'US'));
    super.onInit();
  }

  Future<void> loadLocalizations() async {
    await loadEnUsLocalization();
    await loadRuRuLocalization();
  }

  Future<void> loadEnUsLocalization() async {
    String jsonString = await rootBundle.loadString('assets/langs/en.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    enLocalized.value =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  Future<void> loadRuRuLocalization() async {
    String jsonString = await rootBundle.loadString('assets/langs/ru.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    ruLocalized.value =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  void updateLocale(Locale locale) => Get.updateLocale(locale);
}

class Languages extends Translations {
  final LocalizationService localizationService = LocalizationService.to;

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': localizationService.enLocalized,
        'ru_RU': localizationService.ruLocalized,
      };
}
