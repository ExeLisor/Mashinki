import 'package:autoverse/exports.dart';
import 'package:autoverse/services/lang_service.dart';

class AccountScreen extends GetView<SettingsController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeScreen(),
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              LocalizationService.to.updateLocale(const Locale('en', 'US'))),
      bottomNavigationBar: HomeScreenBottomBarWidget(),
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

  AppBar _appBar() => AppBar(
        title: _appBarText(),
        leading: _iconBack(),
        centerTitle: true,
      );

  Widget _appBarText() => Text(
        'Профиль',
        style: TextStyle(
          color: primaryColor,
          fontSize: 20.fs,
          fontWeight: FontWeight.w700,
        ),
      );
  Widget _iconBack() => GestureDetector(
        onTap: Get.back,
        child: Padding(
          padding: EdgeInsets.only(left: 4.0.w),
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.transparent)),
            child: Center(
              child: SvgPicture.asset(
                "assets/svg/back.svg",
              ),
            ),
          ),
        ),
      );

  Widget _theme() => AccountSettingsSelector(controller: ThemeController());

  Widget _language() => const LanguageSelector();

  Widget _disbaleAds() => _button("disableAds".tr, controller.disableAds);

  Widget _rateApp() => _button("rateApp".tr, controller.rateApp);

  Widget _contactDevs() => _button("contactDevs".tr, controller.contactDevs);

  Widget _button(String title, VoidCallback? onTap) => Column(
        children: [
          InkWell(
            onTap: onTap,
            splashColor: const Color(0xff7974FF),
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.transparent)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16.fs,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
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
                color: const Color(0xFF7974FF),
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
            color: primaryColor,
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
                Text(
                  value.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.fs,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
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

class AccountSettingsSelector<T extends SettingsMixin> extends StatelessWidget {
  const AccountSettingsSelector({
    super.key,
    required this.controller,
  });

  final T controller;

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
            color: primaryColor,
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
                Text(
                  value.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.fs,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
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
    title.value = 'theme'.tr;
    selectedSetting.value = "theme-light";
    settings.addAll(['theme-light', 'theme-dark', 'theme-system']);
  }
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
