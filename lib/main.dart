import 'package:autoverse/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  Get.put(FirebaseController());
  // Get.put(RegistrationController());
  // Get.put(EmailController());
  // Get.put(RegistrationPasswordsContoller());

  Get.put(MarksController());

  // Get.put(HomeScreenController());

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<GetPage> _pages = [
    GetPage(name: '/', page: () => HomeScreen()),
    GetPage(
      name: '/marks',
      page: () => const MarksScreen(),
      transition: Transition.cupertino,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return GetMaterialApp(
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      initialRoute: '/',
      getPages: _pages,
    );
  }
}
