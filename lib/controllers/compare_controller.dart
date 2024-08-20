import 'package:autoverse/exports.dart';

class CompareController extends GetxController {
  static CompareController get to => Get.find();

  final RxList<Car> _comparedCars = <Car>[].obs;

  List<Car> get comparedCars => _comparedCars;

  void addToCompare(Car car) {
    if (isCarCompared(car)) return;

    _comparedCars.add(car);
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
}

class CompareBinding extends Bindings {
  @override
  CompareController dependencies() =>
      Get.put(CompareController(), permanent: true);
}
