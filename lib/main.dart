import 'package:autoverse/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  await _initFirebase();
  await _initFirebaseConfig();
  await _sendAnalyticsEvent();

  Get.put(RegistrationController());
  Get.put(EmailController());
  Get.put(RegistrationPasswordsContoller());
  Get.put(HomeScreenController());

  runApp(const MainApp());
}

Future<void> _initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  } catch (e) {
    log("Failed to initialize Firebase: $e");
  }
}

Future<void> _initFirebaseConfig() async {
  try {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await remoteConfig.fetchAndActivate();

    log(remoteConfig.getInt("example_param_1"));
  } catch (e) {
    log("Failed to initialize Firebase: $e");
  }
}

Future<void> _sendAnalyticsEvent() async {
  try {
    await FirebaseAnalytics.instance.logEvent(
      name: 'test_event',
      parameters: {
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true.toString(),
      },
    );

    log('logEvent succeeded');
  } catch (e) {
    log("Failed to initialize Firebase: $e");
  }
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
      home: HomeScreen(),
    );
  }
}
