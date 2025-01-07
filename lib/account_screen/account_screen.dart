import 'package:autoverse/exports.dart';

import 'package:autoverse/services/lang_service.dart';

class AccountScreen extends GetView<SettingsController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _homeScreen(),
        backgroundColor: AppThemeController.to.whiteColor,
        bottomNavigationBar: HomeScreenBottomBarWidget(),
      ),
    );
  }

  Widget _homeScreen() => SingleChildScrollView(
        child: Column(
          children: [
            _appBar(),
            _theme(),
            _language(),
            _disbaleAds(),
            _rateApp(),
            _contactDevs(),
          ],
        ),
      );

  Widget _appBar() => Obx(() => AppBar(
        backgroundColor: AppThemeController.to.whiteColor,
        title: _appBarText(),
        leading: _iconBack(),
        centerTitle: true,
      ));

  Widget _appBarText() => Obx(
        () => Text(
          'Профиль'.tr,
          style: TextStyle(
            color:
                AppThemeController.to.isDarkTheme ? Colors.white : primaryColor,
            fontSize: 20.fs,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
  Widget _iconBack() => Obx(
        () => GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: EdgeInsets.only(left: 4.0.w),
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              child: Center(
                child: SvgPicture.asset(
                  "assets/svg/back.svg",
                  color: AppThemeController.to.isDarkTheme
                      ? Colors.white
                      : primaryColor,
                ),
              ),
            ),
          ),
        ),
      );

  Widget _theme() => const ThemeSelector();

  Widget _language() => const LanguageSelector();

  Widget _disbaleAds() => _button("disableAds".tr, controller.disableAds);

  Widget _rateApp() => _button("rateApp".tr, controller.rateApp);

  Widget _contactDevs() => _button("contactDevs".tr, controller.contactDevs);

  Widget _button(String title, VoidCallback? onTap) => Column(
        children: [
          InkWell(
            onTap: onTap,
            splashColor: paleColor,
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                child: Row(
                  children: [
                    Obx(
                      () => Text(
                        title,
                        style: TextStyle(
                          color: AppThemeController.to.isDarkTheme
                              ? paleColor
                              : primaryColor,
                          fontSize: 16.fs,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SettingsDivider(),
        ],
      );
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: 0.50,
        child: Container(
          width: 362.w,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.5.w,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: paleColor,
              ),
            ),
          ),
        ),
      );
}

class LanguageSelector extends GetView<LanguageController> {
  const LanguageSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          _title(),
          SizedBox(height: 12.h),
          _settings(),
          _divider(),
        ],
      ),
    );
  }

  Widget _divider() => const SettingsDivider();

  Widget _title() => Obx(
        () => Text(
          controller.title.value, // Слушаем изменения title
          textAlign: TextAlign.start,
          style: TextStyle(
            color: AppThemeController.to.isDarkTheme ? paleColor : primaryColor,
            fontSize: 16.fs,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _settings() {
    return Column(
      children: List.generate(controller.settings.length,
          (index) => _settingItem(controller.settings[index])),
    );
  }

  Widget _settingItem(String value) {
    return GestureDetector(
      onTap: () => controller.select(value),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    value.tr,
                    style: TextStyle(
                      color: AppThemeController.to.blackColor,
                      fontSize: 16.fs,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                controller.isSelected(value)
                    ? SvgPicture.asset("assets/svg/check.svg",
                        width: 12.w, height: 24.h)
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeSelector extends GetView<ThemeController> {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          _title(),
          SizedBox(height: 12.h),
          _settings(),
          _divider(),
        ],
      ),
    );
  }

  Widget _divider() => const SettingsDivider();

  Widget _title() => Obx(
        () => Text(
          controller.title.value, // Слушаем изменения title
          textAlign: TextAlign.start,
          style: TextStyle(
            color: AppThemeController.to.isDarkTheme ? paleColor : primaryColor,
            fontSize: 16.fs,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _settings() {
    return Column(
      children: List.generate(controller.settings.length,
          (index) => _settingItem(controller.settings[index])),
    );
  }

  Widget _settingItem(String value) {
    return GestureDetector(
      onTap: () => controller.select(value),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    value.tr,
                    style: TextStyle(
                      color: AppThemeController.to.blackColor,
                      fontSize: 16.fs,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                controller.isSelected(value)
                    ? SvgPicture.asset("assets/svg/check.svg",
                        width: 12.w, height: 24.h)
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

mixin SettingsMixin on GetxController {
  final RxList<String> settings = <String>[].obs;
  final RxString title = ''.obs;
  final RxString selectedSetting = ''.obs;

  void select(String value) => selectedSetting.value = value;

  bool isSelected(String value) => selectedSetting.value == value;
}

class ThemeController extends GetxController with SettingsMixin {
  ThemeController() {
    title.value = "Тема".tr;
    selectedSetting.value = "theme-light";
    settings.addAll(['theme-light', 'theme-dark']);
  }

  @override
  void onInit() async {
    super.onInit();
    String? theme = await loadData("theme");

    if (theme != null) return select(theme);

    if (theme == null) return select("theme-light");
  }

  @override
  void select(String value) {
    super.select(value);

    changeTheme(value == "theme-dark");
    AppThemeController.to.toggleTheme(theme: value == "theme-dark");

    saveData("theme", value);
  }

  void changeTheme(bool? theme) =>
      AppThemeController.to.toggleTheme(theme: theme);
}

class LanguageController extends GetxController with SettingsMixin {
  LanguageController() {
    title.value = "language".tr;
    selectedSetting.value = "ru";
    settings.addAll(['ru', 'en']);
  }

  @override
  void onInit() async {
    super.onInit();
    String? language = await loadData("language");

    if (language != null) select(language);

    if (language == null) select(Get.deviceLocale.toString());
  }

  @override
  void select(String value) {
    super.select(value);
    changeLocalization(value);
    saveData("language", value);
  }

  void changeLocalization(String value) => value == 'en' || value == "en_US"
      ? LocalizationService.to.updateLocale(const Locale('en', 'US'))
      : LocalizationService.to.updateLocale(const Locale('ru', 'RU'));
}

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LanguageController(), permanent: true);
  }
}

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  @override
  void onInit() {
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => LanguageController());
    super.onInit();
  }

  void disableAds() {
    log("Отключить рекламу");
  }

  void rateApp() {
    log("Оценить приложение");
  }

  void contactDevs() {
    log("Связаться с разработчиками");
  }
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
