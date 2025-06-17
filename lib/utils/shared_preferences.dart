import 'package:autoverse/exports.dart';

Future<void> saveData(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();

  if (value is String) {
    await prefs.setString(key, value);
  } else if (value is int) {
    await prefs.setInt(key, value);
  } else if (value is bool) {
    await prefs.setBool(key, value);
  } else if (value is double) {
    await prefs.setDouble(key, value);
  } else if (value is List<String>) {
    await prefs.setStringList(key, value);
  }
}

Future<dynamic> loadData(String key) async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey(key)) {
    var data = prefs.get(key);

    // Если это строка, пытаемся декодировать как JSON
    if (data is String) {
      try {
        // Преобразуем JSON-строку в Map
        return jsonDecode(data);
      } catch (e) {
        // Если это не JSON-строка, возвращаем как есть
        return data;
      }
    }

    // Обрабатываем другие типы данных, если они не являются строкой
    return data;
  }

  return null; // Если ключ не найден
}

Future<void> clearCache() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    log("CACHE CLEARED");
  } catch (e) {
    logW(e);
    return;
  }
}
