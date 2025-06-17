import 'package:autoverse/exports.dart';

class ApiService {
  static ApiService? _instance;
  static ApiService get instance => _instance ??= ApiService._internal();

  ApiService._internal();

  final Dio _dio = Dio();

  static const String baseUrl1 = 'http://90.156.171.63/api';

  Future<List<Mark>> getMarks() async {
    log('🔥 USING ApiService - Fetching marks from API: $baseUrl1/marks');
    try {
      final response = await _dio.get('$baseUrl1/marks');

      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data;
        log('🔥 ApiService marks loaded successfully: ${jsonList.length}');
        return marksFromJson(jsonList);
      } else {
        throw Exception('Failed to load marks: ${response.statusCode}');
      }
    } catch (e) {
      logW('🔥 ApiService Error getting marks: $e');
      rethrow;
    }
  }

  Future<List<Mark>> getPopularMarks() async {
    log('🔥 USING ApiService - Fetching popular marks');
    try {
      // Получаем все марки и фильтруем популярные
      List<Mark> allMarks = await getMarks();
      List<Mark> popularMarks =
          allMarks.where((mark) => mark.popular == 1).toList();
      log('🔥 ApiService popular marks filtered: ${popularMarks.length}');
      return popularMarks;
    } catch (e) {
      logW('🔥 ApiService Error getting popular marks: $e');
      rethrow;
    }
  }
}
