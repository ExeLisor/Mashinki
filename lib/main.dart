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
    ScreenSize.init(context);

    return GetMaterialApp(
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      home: const Home(),
      initialRoute: '/',
      getPages: _pages,
      initialBinding: BarBinding(),
    );
  }

  final List<GetPage> _pages = [
    GetPage(name: '/', page: () => const Home()),
    GetPage(name: '/home', page: () => const HomeScreen()),
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
  ];
}
