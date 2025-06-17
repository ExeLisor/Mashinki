import 'package:autoverse/exports.dart';

class CompareController extends GetxController {
  static CompareController get to => Get.find();
  static AdsController get add => Get.find();

  final RxList<Car> _comparedCars = <Car>[].obs;

  final RxList _comparedSpecifications = [].obs;

  final RxBool _isHideIdentical = false.obs;

  bool get isHideIdentical => _isHideIdentical.value;

  set isHideIdentical(bool value) => _isHideIdentical.value = value;

  List<Car> get comparedCars => _comparedCars;

  List get comparedSpecifications => _comparedSpecifications;

  List specificationTitle = ["Двигатель", "Размеры"];

  List<CarSpecifications> allSpecs = [];

  void compareAction(Car car) =>
      isCarCompared(car) ? deleteFromCompare(car) : addToCompare(car);

  void addToCompare(Car car) {
    add.showRewardedInterstitialAd();
    if (isCarCompared(car)) return;

    _comparedCars.add(car);
    showSnackBar("Добавлено в сравнение");
    compare();
  }

  void hideIdentical() => _isHideIdentical.value = !_isHideIdentical.value;

  void deleteFromCompare(Car car) {
    add.showInterstitialAd();
    comparedCars.removeWhere((element) =>
        element.selectedModification.complectationId ==
        car.selectedModification.complectationId);

    compare();
  }

  bool isCarCompared(Car car) => comparedCars.any((element) =>
      element.selectedModification.complectationId ==
      car.selectedModification.complectationId);

  List<CarSpecifications> getAllSpecifications() => List.generate(
      comparedCars.length, (index) => getCarSpecifications(index));

  CarSpecifications getCarSpecifications(int index) =>
      comparedCars[index].selectedModification.carSpecifications!;

  void compare() {
    allSpecs = getAllSpecifications();

    _comparedSpecifications.value =
        List.generate(specificationTitle.length, (_) => []);

    for (int i = 0; i < comparedCars.length; i++) {
      for (int k = 0; k < comparedSpecifications.length; k++) {
        _comparedSpecifications[k] = (_getComparedSpecifications(k));
      }
    }
  }

  List _getComparedSpecifications(int index) {
    List array = [];

    for (int i = 0; i < allSpecs.length; i++) {
      List specifications = _getTypedSpecifications(
          specifications: allSpecs[i], type: SpecificationType.values[index]);
      if (array.isEmpty) {
        array = List.generate(specifications.length, (_) => []);
      }
      for (int k = 0; k < specifications.length; k++) {
        array[k].add(specifications[k]);
      }
    }
    return array;
  }

  List _getTypedSpecifications(
      {required SpecificationType type,
      required CarSpecifications specifications}) {
    switch (type) {
      case SpecificationType.engine:
        return specifications.getEngineSpecifications();
      case SpecificationType.safety:
        return specifications.getSafetySpecifications();

      default:
        return [];
    }
  }
}

enum SpecificationType {
  engine("Двигатель"),
  safety("Безопасность");

  final String name;
  const SpecificationType(this.name);
}

class CompareBinding extends Bindings {
  @override
  CompareController dependencies() =>
      Get.put(CompareController(), permanent: true);
}
