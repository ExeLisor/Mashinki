import 'package:autoverse/exports.dart';

class CompareController extends GetxController {
  static CompareController get to => Get.find();

  final RxList<Car> _comparedCars = <Car>[].obs;

  final RxList _comparedSpecifications = [].obs;

  List<Car> get comparedCars => _comparedCars;

  List get comparedSpecifications => _comparedSpecifications;

  List specificationTitle = ["Двигатель", "Размеры"];

  void addToCompare(Car car) {
    if (isCarCompared(car)) return;

    _comparedCars.add(car);

    compare();
  }

  void deleteFromCompare(Car car) {
    comparedCars.removeWhere((element) =>
        element.selectedModification.complectationId ==
        car.selectedModification.complectationId);
  }

  bool isCarCompared(Car car) => comparedCars.any((element) =>
      element.selectedModification.complectationId ==
      car.selectedModification.complectationId);

  List<CarSpecifications> getAllSpecifications() => List.generate(
      comparedCars.length, (index) => getCarSpecifications(index));

  CarSpecifications getCarSpecifications(int index) =>
      comparedCars[index].selectedModification.carSpecifications!;

  void compare() {
    _comparedSpecifications.value =
        List.generate(specificationTitle.length, (_) => []);
  }
}

class CompareBinding extends Bindings {
  @override
  CompareController dependencies() =>
      Get.put(CompareController(), permanent: true);
}
