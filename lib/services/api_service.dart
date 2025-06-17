import 'package:autoverse/exports.dart';

class ApiService {
  static ApiService? _instance;
  static ApiService get instance => _instance ??= ApiService._internal();

  ApiService._internal();

  final Dio _dio = Dio();

  static const String baseUrl = 'http://90.156.171.63/api';

  Future<List<Mark>> getMarks() async {
    try {
      final response = await _dio.get('$baseUrl/marks');

      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data;
        return marksFromJson(jsonList);
      } else {
        throw Exception('Failed to load marks: ${response.statusCode}');
      }
    } catch (e) {
      logW('API Error getting marks: $e');
      rethrow;
    }
  }

  Future<List<Mark>> getPopularMarks() async {
    try {
      // Получаем все марки и фильтруем популярные
      List<Mark> allMarks = await getMarks();
      return allMarks.where((mark) => mark.popular == 1).toList();
    } catch (e) {
      logW('API Error getting popular marks: $e');
      rethrow;
    }
  }
}
