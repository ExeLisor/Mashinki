import 'package:autoverse/exports.dart';

class CarController extends GetxController {
  static CarController get to => Get.find();

  Dio dio = Dio();
  Rx<Status> state = Status.loading.obs;

  final Rxn<Car> _car = Rxn<Car>();

  Car get car => _car.value!;
  set car(Car value) => _car.value = value;

  @override
  void onClose() {
    dio.close();
    super.onClose();
  }

  Future<Car> openCarPage(Car car, {bool isLoadCar = false}) async {
    _emitLoadingState();
    Get.toNamed("/models/${car.configuration.id}");

    if (isLoadCar) return await _loadCar(car);

    _car.value = car;
    _emitSussessState();
    return car;
  }

  bool _checkIfCarAlreadyLoaded(Car loadingCar) {
    if (_car.value == null) return false;

    return loadingCar.isDownloaded;
  }

  Future<Car> _loadCar(Car loadingCar) async {
    try {
      _emitLoadingState();

      bool isCarAlreadyLoaded = _checkIfCarAlreadyLoaded(loadingCar);

      _car.value = loadingCar;

      log("loading!");

      if (!isCarAlreadyLoaded) await _car.value!.loadModifications();

      log("downloaded!");

      _car.value!.isDownloaded = true;

      _emitSussessState();
      return car;
    } catch (e) {
      logW(e);
      rethrow;
    }
  }

  // Future<void> loadSpecs() async {
  //   for (int i = 0; i < car.modifications.length; i++) {
  //     final specs = await _getSpecs(car.modifications[i].complectationId ?? "");
  //     _car.value!.modifications[i].carOptions = _getOptions(specs["options"]);
  //     _car.value!.modifications[i].carSpecifications =
  //         _getSpecifications(specs["specifications"]);
  //   }
  // }

  void selectModification(Modification modification) =>
      _car.update((car) => car?.selectedModification = modification);

  CarOptions? _getOptions(List data) {
    if (data.isEmpty) return null;

    CarOptions options = CarOptions.fromJson(data.first);
    return options;
  }

  CarSpecifications _getSpecifications(List data) {
    CarSpecifications specifications = CarSpecifications.fromJson(data.first);
    return specifications;
  }

  Future _getSpecs(String complecationId) async {
    try {
      Response response = await dio.get("$baseUrl/specs/$complecationId");

      return response.data;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionError:
        default:
          _emitErrorState();
          await Future.delayed(const Duration(seconds: 5));
          await _getSpecs(complecationId);
      }
      rethrow;
    } catch (e) {
      logW(e);
      _emitErrorState();

      return false;
    }
  }

  void _emitSussessState() => state.value = Status.success;
  void _emitLoadingState() => state.value = Status.loading;
  void _emitErrorState() => state.value = Status.error;
}

class CarBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CarController(), fenix: true);
}
