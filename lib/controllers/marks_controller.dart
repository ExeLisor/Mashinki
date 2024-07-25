import 'package:autoverse/exports.dart';

class MarksController extends GetxController {
  static MarksController get to => Get.find();

  final Dio dio = Dio(BaseOptions());

  List<Mark> marks = [];

  @override
  Future<void> onInit() async {
    await getAllMarks();
    super.onInit();
  }

  Future<List<Mark>?> getAllMarks() async {
    try {
      Response response = await dio.get("$baseUrl/marks");

      marks = marksFromJson(response.data);
      update();
      return marks;
    } catch (e) {
      logW(e);
      return null;
    }
  }
}
