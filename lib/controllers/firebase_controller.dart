import 'package:autoverse/exports.dart';

class FirebaseController extends GetxController {
  static FirebaseController get to => Get.find();

  @override
  Future<void> onInit() async {
    log("INIT FIREBSAE");
    await _initFirebase();
    await _initFirebaseConfig();
    // await _sendAnalyticsEvent();

    super.onInit();
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
    } catch (e) {
      log("Failed to initialize Firebase Config: $e");
    }
  }

  Future<String?> loadImage(String path, String? id,
      {String type = "jpg"}) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('$path/$id.$type');
      final url = await storageRef.getDownloadURL();

      log("Image URL: $url");
      return url;
    } catch (e) {
      log("Failed to load image from Firebase Storage: $e");
      return null;
    }
  }
}
