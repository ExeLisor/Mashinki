import 'package:autoverse/exports.dart';

class FirebaseController extends GetxController {
  static FirebaseController get to => Get.find();

  final Map<String, String?> _imageCache = {};

  Future<void> onInitComplete() async {
    // Инициализация Firebase и всех необходимых сервисов
    await _initFirebase();
    await _initFirebaseConfig();
    await _initAppCheck();
    super.onInit();
  }

  Future<void> _initAppCheck() async {
    try {
      AndroidProvider androidProvider =
          kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity;
      FirebaseAppCheck.instance.activate(androidProvider: androidProvider);
      return;
    } catch (error) {
      logW(error);
      return;
    }
  }

  Future<void> _initFirebase() async {
    try {
      FirebaseOptions options = DefaultFirebaseOptions.currentPlatform;
      await Firebase.initializeApp(options: options);
      await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    } catch (e) {
      log("Failed to initialize Firebase: $e");
    }
  }

  Future<void> _initFirebaseConfig() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1)));
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      log("Failed to initialize Firebase Config: $e");
    }
  }

  Future<String?> _fetchImageFromFirebase(String path, String? id,
      {String type = "jpg"}) async {
    try {
      final storageRef = FirebaseStorage.instance.ref('$path/$id.$type');
      final url = await storageRef.getDownloadURL();

      return url;
    } catch (e) {
      log("Failed to load image from Firebase Storage: $e");
      return null;
    }
  }

  Future<String?> loadImage(String folder, String? id,
      {String type = "jpg"}) async {
    if (id == null) return "";

    if (_imageCache.containsKey(id)) return _imageCache[id];

    String? imageUrl = await _fetchImageFromFirebase(folder, id, type: type);

    // Кэшируем результат
    _imageCache[id] = imageUrl;

    return imageUrl;
  }
}
