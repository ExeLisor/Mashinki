import 'package:autoverse/exports.dart';

enum Status { success, loading, error }

class ModelsController extends GetxController {
  static ModelsController get to => Get.find();
  static AdsController get add => Get.find();

  final Rxn<Mark> _mark = Rxn<Mark>();
  final RxList<Model> _models = <Model>[].obs;
  Rx<Status> state = Status.loading.obs;

  Mark get mark => _mark.value!;
  List<Model> get models => _models;

  Future<List<Model>> _loadModels(Mark mark) async {
    _emitLoadingState();

    FiltersController.to.resetFilters();

    _setMark(mark);
    _models.value = await _getModels();

    _models.refresh();
    _emitSussessState();
    return models;
  }

  Future<void> loadModelConfigurations(int index) async {
    SupabaseController controller = SupabaseController.to;

    try {
      for (int i = 0; i < _models[index].generations.length; i++) {
        String id = _models[index].generations[i].id ?? "";
        _models.first.generations[i].configurations =
            await controller.getConfigurations(id);
      }
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionError:
        default:
          _emitErrorState();
          await Future.delayed(const Duration(seconds: 5));
          await loadModelConfigurations(index);
      }
      rethrow;
    } catch (e) {
      logW(e);
      _emitErrorState();
      await Future.delayed(const Duration(seconds: 5));
      await loadModelConfigurations(index);
      rethrow;
    }
  }

  bool isMarkModelsAlreadyLoaded(Mark mark) => _mark.value == mark;

  Future<void> openModelsPage(Mark mark) async {
    add.showInterstitialAd();
    Get.toNamed("/${mark.id}/models");
    await _loadModels(mark);
  }

  void _emitSussessState() => state.value = Status.success;
  void _emitLoadingState() => state.value = Status.loading;
  void _emitErrorState() => state.value = Status.error;

  void _setMark(Mark mark) => _mark.value = mark;

  Future<List<Model>> _getModels() async {
    try {
      dynamic cache = await loadData("${mark.name}/models");
      if (cache != null) return modelsFromJson(cache);
      log("load models");
      List<Model> models = await SupabaseController.to.getModels(mark.id ?? "");
      await saveData("${mark.name}/models", modelsToJson(models));

      return models;
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
}

class ModelsBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ModelsController());
}
