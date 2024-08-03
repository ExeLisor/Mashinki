import 'package:autoverse/exports.dart';

enum Status { success, loading, error }

class ModelsController extends GetxController {
  static ModelsController get to => Get.find();

  Dio dio = Dio();
  RxString markId = "".obs;
  RxList<Model> models = <Model>[].obs;
  Rx<Status> state = Status.loading.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    _emitLoadingState();
    dio = Dio();
    _setMarkId();
    models.value = await _getModels();
    _emitSussessState();
  }

  @override
  void onClose() {
    dio.close();
    super.onClose();
  }

  void _emitSussessState() => state.value = Status.success;
  void _emitLoadingState() => state.value = Status.loading;
  void _emitErrorState() => state.value = Status.error;
  void _setState(Status newState) => state.value = newState;

  void _setMarkId() => markId.value = Get.parameters["mark"] ?? "";

  String getGenerationImage(Model model) =>
      model.generations?.first.configurations?.first.id ?? "";

  Future<List<Model>> _getModels() async {
    try {
      log("$baseUrl/$markId/models");
      Response response = await dio.get("$baseUrl/$markId/models");

      List<Model> modelsFromResponse = modelsFromJson(response.data);
      return modelsFromResponse;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionError:
        default:
          _emitErrorState();
          await Future.delayed(const Duration(seconds: 5));
          await _getModels();
      }
      rethrow;
    } catch (e) {
      logW(e);
      _emitErrorState();
      await Future.delayed(const Duration(seconds: 5));
      await _getModels();
      rethrow;
    }
  }

  Future<void> getGenerationsDetails(Configuration configuration) async {
    // log(configuration.toJson());
    Response response = await dio.get(
        "$baseUrl/specs/${configuration.modifications?.first.complectationId}");
    log(response.data);
  }
}

class ModelsBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ModelsController());
}
