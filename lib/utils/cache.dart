import 'package:mashinki/exports.dart';

Future<bool> saveToCache(String key, String value) async {
  // log("$key saved to cache");
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    return true;
  } catch (error) {
    logW(error);
    return false;
  }
}

Future<String?> getFromCache(String key) async {
  // log("$key from cache");
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    return value;
  } catch (error) {
    logW(error);
    return null;
  }
}

void clearCache() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove('password');
}
