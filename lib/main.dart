import 'package:autoverse/exports.dart';
import 'package:autoverse/services/lang_service.dart';

import 'screens/filters_screen/widgets/option_selector.dart';
import 'screens/marks_screen/select_marks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseController = Get.put(FirebaseController(), permanent: true);
  final supabaseController = Get.put(SupabaseController(), permanent: true);
  Get.put(AppThemeController(), permanent: true);
  final localizationService = Get.put(LocalizationService());
  await localizationService
      .loadLocalizations(); // Гарантируем загрузку локализации

  await firebaseController.onInitComplete();
  await supabaseController.onInitComplete();

  MobileAds.instance.initialize();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    if (!ScreenSize().isInitializated) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return GetMaterialApp(
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      translations: Languages(),
      locale: Get.deviceLocale,
      initialRoute: '/home',
      getPages: _pages,
      initialBinding: InititalBindingsClass(),
      routingCallback: (routing) {
        const routes = {
          '/home': 0,
          '/compare': 1,
          '/favorites': 2,
          '/account': 3,
        };
        final current =
            routes[routing?.current] ?? routes[routing?.previous] ?? 0;
        BarController.to.currentPageIndex(current);
      },
    );
  }

  final List<GetPage> _pages = [
    // GetPage(name: '/', page: () => const Home()),
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/account',
      page: () => const AccountScreen(),
      transition: Transition.noTransition,
      binding: SettingsBinding(),
    ),
    GetPage(
      name: '/filters',
      page: () => const FiltersScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/:mark/models',
      page: () => ModelsScreen(),
      transition: Transition.cupertino,
      bindings: [
        ModelsBinding(),
        ModelsSearchBinding(),
        ModelsSelectorBinding(),
        BodyTypeSelectorBinding(),
        FiltersBinding(),
        CarBinding(),
      ],
      children: [
        GetPage(
          name: '/filters',
          page: () => const ModelsFiltersWidget(),
          transition: Transition.cupertino,
          bindings: [FilterBinding(), OptionSelectorBinding()],
        ),
      ],
    ),
    GetPage(
        name: '/favorites',
        page: () => const FavoritesScreen(),
        transition: Transition.cupertino,
        bindings: [
          FavoriteBinding(),
          CarBinding(),
        ]),
    GetPage(
        name: '/marks',
        page: () => const MarksScreen(),
        transition: Transition.cupertino,
        bindings: [AlphabetBinding(), MarksSearchBinding()]),
    GetPage(
        name: '/selectMarks',
        page: () => const SelectMarksScreen(),
        transition: Transition.cupertino,
        bindings: [AlphabetBinding(), MarksSearchBinding()]),
    GetPage(
      name: '/compare',
      page: () => const CompareScreen(),
      transition: Transition.cupertino,
      bindings: [
        CompareBinding(),
        CompareAppBarBinding(),
      ],
    ),
    GetPage(
      name: '/models/:car',
      page: () => const CarScreen(),
      transition: Transition.cupertino,
      bindings: [
        CarBinding(),
        SpecsSelectorBinding(),
        CarAppBarBinding(),
        ModsGroupBinding(),
        CompareBinding(),
        FavoriteBinding(),
      ],
    ),
  ];
}

class InititalBindingsClass extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterController(), fenix: true);
    Get.lazyPut(() => OptionSelectorController(), fenix: true);
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => BarController());
    Get.lazyPut(() => CompareController());
    Get.lazyPut(() => MarksController());
    Get.put(ModelsController(), permanent: true);
    Get.put(AdsController(), permanent: true);
    Get.put(LinkController(), permanent: true);
    Get.lazyPut(() => FirebaseController());
    Get.lazyPut(() => MarksSearchController());
    Get.put(MarkSelectController());
    WeeklyCarsBinding().dependencies();
    CarCatalogBinding().dependencies();
    FavoriteBinding().dependencies();
    FiltersBinding().dependencies();
    CarBinding().dependencies();
    LanguageBinding().dependencies();
  }
}

class AppThemeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    String? theme = await loadData("theme");
    if (theme != null) return toggleTheme(theme: theme == "theme-dark");

    if (theme == null || theme == "theme-system") return useSystemTheme();
  }

  void useSystemTheme() {
    var brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .platformBrightness;
    toggleTheme(theme: brightness != Brightness.light);
  }

  static AppThemeController get to => Get.find();

  final RxBool _isDarkTheme = false.obs;

  bool get isDarkTheme => _isDarkTheme.value;

  // Rx-цвета, которые будут автоматически обновляться
  final Rx<Color> _primaryColor = const Color(0xFF4038FF).obs;
  final Rx<Color> _paleColor = const Color(0xff7974FF).obs;
  final Rx<Color> _unactiveColor = const Color(0xffA7A7A7).obs;
  final Rx<Color> _boneColor = const Color(0xffF3F3F3).obs;
  final Rx<Color> _whiteColor = Colors.white.obs;
  final Rx<Color> _blackColor = Colors.black.obs;
  final Rx<Color> _greyColor = const Color(0xff848484).obs;
  final Rx<Color> _boxShadowColor = const Color(0x0F000000).obs;
  final Rx<Color> _greySurface = const Color(0xffE2E2E2).obs;
  final Rx<Color> _greyBackground = const Color(0xffEEEEEE).obs;
  final Rx<Color> _searchContainerColor = Colors.white.obs;
  final Rx<Color> _appBarItemsColor = const Color(0xFF4038FF).obs;
  final Rx<Color> _textColor = Colors.black.obs;
  Color get textColor => _textColor.value;

  Color get primaryColor => _primaryColor.value;
  Color get paleColor => _paleColor.value;
  Color get unactiveColor => _unactiveColor.value;
  Color get boneColor => _boneColor.value;
  Color get whiteColor => _whiteColor.value;
  Color get blackColor => _blackColor.value;
  Color get greyColor => _greyColor.value;
  Color get boxShadowColor => _boxShadowColor.value;
  Color get greySurface => _greySurface.value;
  Color get greyBackground => _greyBackground.value;
  Color get searchContainerColor => _searchContainerColor.value;
  Color get appBarItemsColor => _appBarItemsColor.value;

  // Метод для переключения темы и обновления значений цветов
  void toggleTheme({bool? theme}) {
    _isDarkTheme.value = theme ?? !_isDarkTheme.value;

    if (isDarkTheme) {
      _primaryColor.value = const Color(0xFF303F9F);
      _paleColor.value = const Color(0xff616161);
      _unactiveColor.value = const Color(0xffBDBDBD);
      _boneColor.value = const Color(0xff212121);
      _whiteColor.value = const Color(0xff19191B);
      _blackColor.value = Colors.white;
      _greyColor.value = const Color(0xff757575);
      _boxShadowColor.value = const Color(0x0F000000);
      _greySurface.value = const Color(0xff424242);
      _greyBackground.value = const Color(0xff292929);
      _searchContainerColor.value = const Color(0xff292929);
      _appBarItemsColor.value = Colors.white;
      _textColor.value = Colors.white;
    } else {
      _primaryColor.value = const Color(0xFF4038FF);
      _paleColor.value = const Color(0xff7974FF);
      _unactiveColor.value = const Color(0xffA7A7A7);
      _boneColor.value = const Color(0xffF3F3F3);
      _whiteColor.value = Colors.white;
      _blackColor.value = Colors.black;
      _greyColor.value = const Color(0xff848484);
      _boxShadowColor.value = const Color(0x0F000000);
      _greySurface.value = const Color(0xffE2E2E2);
      _greyBackground.value = const Color(0xffEEEEEE);
      _searchContainerColor.value = Colors.white;
      _appBarItemsColor.value = const Color(0xFF4038FF);
      _textColor.value = Colors.black;
    }
  }
}
