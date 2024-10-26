import 'package:autoverse/exports.dart';

import 'screens/filters_screen/widgets/option_selector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseController = Get.put(FirebaseController(), permanent: true);
  final supabaseController = Get.put(SupabaseController(), permanent: true);

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
      initialRoute: '/home',
      getPages: _pages,
      initialBinding: InititalBindingsClass(),
      routingCallback: (routing) {
        const routes = {
          '/home': 0,
          '/compare': 1,
          '/favorites': 2,
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
        bindings: [AlphabetBinding()]),
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
    Get.lazyPut(() => BarController());
    Get.lazyPut(() => CompareController());
    Get.lazyPut(() => MarksController());
    Get.lazyPut(() => ModelsController());
    Get.lazyPut(() => FirebaseController());

    FiltersBinding().dependencies();
  }
}
