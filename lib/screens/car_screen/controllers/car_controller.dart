import 'package:autoverse/exports.dart';

class CarController extends GetxController {
  static CarController get to => Get.find();

  Rx<Status> state = Status.loading.obs;

  final Rxn<Car> _car = Rxn<Car>();

  Car get car => _car.value!;
  set car(Car value) => _car.value = value;

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

      log("load car");

      bool isCarAlreadyLoaded = _checkIfCarAlreadyLoaded(loadingCar);

      _car.value = loadingCar;

      if (!isCarAlreadyLoaded) await _car.value!.loadCar();

      _car.value!.isDownloaded = true;

      _emitSussessState();
      return car;
    } catch (e) {
      logW(e);
      rethrow;
    }
  }

  Future<void> selectModification(Modification modification) async {
    try {
      _car.update((car) => car?.selectedModification.isLoaded = false);

      await modification.loadCarSpecifications();

      modification.isLoaded = true;

      _car.update((car) => car?.selectedModification = modification);
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  void updateCarOptions(CarOptions options) =>
      _car.update((car) => car?.selectedModification.carOptions = options);

  void updateCarSpecifications(CarSpecifications specs) =>
      _car.update((car) => car?.selectedModification.carSpecifications = specs);

  void updateCarSelectedModification(Modification mod) =>
      _car.update((car) => car?.selectedModification = mod);

  void _emitSussessState() => state.value = Status.success;
  void _emitLoadingState() => state.value = Status.loading;
  void _emitErrorState() => state.value = Status.error;
}

class CarBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CarController(), fenix: true);
}
