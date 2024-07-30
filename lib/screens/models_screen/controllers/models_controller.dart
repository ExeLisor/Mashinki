import 'package:autoverse/exports.dart';

class ModelsController extends GetxController {
  static ModelsController get to => Get.find();

  RxString markId = "".obs;
  RxList<Model> models = <Model>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _setMarkId();
    models.value = await _getModels();
  }

  void _setMarkId() => markId.value = Get.parameters["mark"] ?? "";

  Future<List<Model>> _getModels() async {
    try {
      final Dio dio = Dio();
      Response response = await dio.get("$baseUrl/$markId/models");
      List<Model> modelsFromResponse = modelsFromJson(response.data);
      return modelsFromResponse;
    } catch (e) {
      logW(e);
      await Future.delayed(const Duration(seconds: 2));
      await _getModels();
      rethrow;
    }
  }
}

class ModelsBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ModelsController());
}
