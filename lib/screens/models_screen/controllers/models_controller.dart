import 'package:autoverse/exports.dart';

enum Status { success, loading, error }

class ModelsController extends GetxController {
  static ModelsController get to => Get.find();

  Dio dio = Dio();
  final Rxn<Mark> _mark = Rxn<Mark>();
  final RxList<Model> _models = <Model>[].obs;
  Rx<Status> state = Status.loading.obs;

  Mark get mark => _mark.value!;
  List<Model> get models => _models;

  Future<List<Model>> _loadModels(Mark mark) async {
    _emitLoadingState();
    dio = Dio();
    FiltersController.to.resetFilters();

    bool isAlreadyLoaded = isMarkModelsAlreadyLoaded(mark);

    _setMark(mark);
    if (!isAlreadyLoaded) _models.value = await _getModels();
    _emitSussessState();
    return models;
  }

  bool isMarkModelsAlreadyLoaded(Mark mark) => _mark.value == mark;

  Future<void> openModelsPage(Mark mark) async {
    Get.toNamed("/${mark.id}/models");
    await _loadModels(mark);
  }

  @override
  void onClose() {
    dio.close();
    super.onClose();
  }

  void _emitSussessState() => state.value = Status.success;
  void _emitLoadingState() => state.value = Status.loading;
  void _emitErrorState() => state.value = Status.error;

  void _setMark(Mark mark) => _mark.value = mark;

  String getGenerationImage(Model model) =>
      model.generations?.first.configurations?.first.id ?? "";

  Future<List<Model>> _getModels() async {
    try {
      log("$baseUrl/model");
      Response response =
          await dio.get("$baseUrl/models", data: {"id": mark.id});

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
