import 'package:autoverse/exports.dart';

class FavoriteController extends GetxController {
  static FavoriteController get to => Get.find();

  final RxList<Car> _favoriteCars = <Car>[].obs;
  final RxBool _isFavorite = false.obs;

  List<Car> get favoriteCars => _favoriteCars;
  bool get isFavorite => _isFavorite.value;

  void addToFavorite(Car car) {
    if (isCarFavorite(car)) return;

    _favoriteCars.add(car);
    _isFavorite.value = true;

    showSnackBar("Добавлено в избранное");
  }

  void removeFromFavorite(Car car) {
    if (!isCarFavorite(car)) return;
    _favoriteCars.removeWhere((element) =>
        element.selectedModification.complectationId ==
        car.selectedModification.complectationId);
  }

  bool isCarFavorite(Car car) => favoriteCars.any((element) =>
      element.selectedModification.complectationId ==
      car.selectedModification.complectationId);

  set isFavorite(bool value) => _isFavorite.value = value;
}

class FavoriteBinding extends Bindings {
  @override
  FavoriteController dependencies() =>
      Get.put(FavoriteController(), permanent: true);
}
