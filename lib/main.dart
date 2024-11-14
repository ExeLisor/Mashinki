import 'package:mashinki/exports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  Get.put(RegistrationController());
  Get.put(EmailController());
  Get.put(RegistrationPasswordsContoller());

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
      home: BrandScreen(),
    );
  }
}

void checkForUpdates() async {
  try {
    AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
    if (updateInfo.immediateUpdateAllowed) {
      // Немедленное обновление
      await InAppUpdate.performImmediateUpdate();
      // Или начать гибкое обновление
      // await InAppUpdate.startFlexibleUpdate();
    }
  } catch (e) {
    logW('Ошибка при проверке обновлений: $e');
  }
}