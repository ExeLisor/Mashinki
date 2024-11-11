import 'package:autoverse/exports.dart';

class AccountScreen extends GetView<SettingsController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeScreen(),
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

  Widget _language() =>
      AccountSettingsSelector(controller: LanguageController());

  Widget _disbaleAds() => _button("Отключить рекламу", controller.disableAds);

  Widget _rateApp() => _button("Оценить приложение", controller.rateApp);

  Widget _contactDevs() =>
      _button("Связаться с разработчиками", controller.contactDevs);

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

class AccountSettingsSelector extends StatelessWidget {
  const AccountSettingsSelector({
    super.key,
    required this.controller,
  });

  final SettingsMixin controller;

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

  Widget _title() => Text(
        controller.title.value,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: primaryColor,
          fontSize: 16.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
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
                  value,
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
    title.value = 'Тема';
    selectedSetting.value = "Светлая";
    settings.addAll(['Светлая', 'Темная', 'Системная']);
  }
}

class LanguageController extends GetxController with SettingsMixin {
  LanguageController() {
    title.value = 'Язык';
    selectedSetting.value = "Русский";
    settings.addAll(['Русский', 'Английский']);
  }

  @override
  void onInit() {
    super.onInit();
    ever(selectedSetting, (_) => changeLocalization());
  }

  void changeLocalization() => selectedSetting.value == 'Русский'
      ? Get.updateLocale(const Locale('en'))
      : Get.updateLocale(const Locale('ru'));
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
