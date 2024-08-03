import 'package:autoverse/exports.dart';

class CarController extends GetxController {
  static CarController get to => Get.find();

  Dio dio = Dio();
  Rx<Status> state = Status.loading.obs;

  final Rxn<Model> _model = Rxn<Model>();
  final Rxn<Generation> _generation = Rxn<Generation>();
  final Rxn<Configuration> _configuration = Rxn<Configuration>();

  Model get model => _model.value!;
  Generation get generation => _generation.value!;
  Configuration get configuration => _configuration.value!;

  @override
  Future<void> onInit() async {
    _emitLoadingState();
    _model.value = Get.arguments["model"];
    _generation.value = Get.arguments["generation"];
    _configuration.value = Get.arguments["configuration"];

    await _getModifications();
    super.onInit();
  }

  @override
  void onClose() {
    dio.close();
    super.onClose();
  }

  Future<List<Modification>> _getModifications() async {
    try {
      log(model.cyrillicName);
      log(generation.name);

      List<Modification> modelsFromResponse = [];
      return modelsFromResponse;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionError:
        default:
          _emitErrorState();
          await Future.delayed(const Duration(seconds: 5));
          await _getModifications();
      }
      rethrow;
    } catch (e) {
      logW(e);
      _emitErrorState();

      return [];
    }
  }

  debug() {
    _getModifications();
  }

  void _emitSussessState() => state.value = Status.success;
  void _emitLoadingState() => state.value = Status.loading;
  void _emitErrorState() => state.value = Status.error;
  void _setState(Status newState) => state.value = newState;
}

class CarBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CarController());
}
