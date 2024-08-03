import 'package:autoverse/exports.dart';

class CarController extends GetxController {
  static CarController get to => Get.find();

  Dio dio = Dio();
  Rx<Status> state = Status.loading.obs;
  Rxn<Configuration> configuration = Rxn<Configuration>();

  @override
  Future<void> onInit() async {
    _emitLoadingState();
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
      String markId = Get.arguments["markId"] ?? "";

      log(markId);
      configuration.value = Get.arguments["configuration"];
      log(configuration.toJson());
      // Response response = await dio.get("$baseUrl/$markId/models");

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

  void _emitSussessState() => state.value = Status.success;
  void _emitLoadingState() => state.value = Status.loading;
  void _emitErrorState() => state.value = Status.error;
  void _setState(Status newState) => state.value = newState;
}

class CarBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CarController());
}
