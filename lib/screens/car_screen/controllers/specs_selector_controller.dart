import 'package:autoverse/exports.dart';

class SpecsSelectorController extends GetxController {
  static SpecsSelectorController get to => Get.find();

  final RxBool _showOptions = false.obs;

  bool get showOptions => _showOptions.value;

  void changeCategory() =>
      !showOptions ? _showOptions.value = true : _showOptions.value = false;

  Future<void> changeToOptions() async {
    _showOptions.value = true;
    Modification modification = CarController.to.car.selectedModification;
    log(modification.carOptions?.isLoaded);
    CarOptions? options = await modification.loadCarOptions();
    CarController.to.updateCarOptions(options ?? CarOptions(isLoaded: true));
    log(modification.carOptions?.isLoaded);
  }

  void changeToSpecs() => _showOptions.value = false;
}

class SpecsSelectorBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => SpecsSelectorController());
}
