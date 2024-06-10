import 'package:mashinki/exports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  Widget build(BuildContext context) => GetMaterialApp(
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      home: const AuthScreen());
}
