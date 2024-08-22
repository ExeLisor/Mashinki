import 'package:autoverse/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  Get.put(FirebaseController());
  Get.put(MarksController());

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
      initialBinding: BarBinding(),
      routingCallback: (routing) {
        switch (routing?.current) {
          case '/home':
            BarController.to.currentPageIndex(0);
            break;
          case '/compare':
            BarController.to.currentPageIndex(1);
            break;
          default:
            BarController.to.currentPageIndex(0);
            break;
        }
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
      name: '/:mark/models',
      page: () => ModelsScreen(),
      transition: Transition.cupertino,
      bindings: [
        ModelsBinding(),
        ModelsSearchBinding(),
        ModelsSelectorBinding(),
        BodyTypeSelectorBinding(),
        FiltersBinding()
      ],
      children: [
        GetPage(
          name: '/filters',
          page: () => const ModelsFiltersWidget(),
          transition: Transition.cupertino,
        ),
      ],
    ),
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
      ],
    ),
  ];
}
