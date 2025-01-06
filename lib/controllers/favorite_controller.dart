import 'package:autoverse/exports.dart';

class FavoriteController extends GetxController {
  static FavoriteController get to => Get.find();

  final RxList<Car> _favoriteCars = <Car>[].obs;
  final RxBool _isFavorite = false.obs;

  List<Car> get favoriteCars => _favoriteCars;
  bool get isFavorite => _isFavorite.value;

  @override
  void onInit() async {
    _favoriteCars.value = await getFavoriteCarsFromPreferences();

    super.onInit();
  }

  void addToFavorite(Car car) {
    if (isCarFavorite(car)) return;

    _favoriteCars.add(car);
    _isFavorite.value = true;

    saveFavoriteCarsToPreferences();

    showSnackBar("Добавлено в избранное");
  }

  void removeFromFavorite(Car car) async {
    if (!isCarFavorite(car)) return;

    _favoriteCars.removeWhere((element) =>
        element.selectedModification.complectationId ==
        car.selectedModification.complectationId);

    removeFromSharedPreferences();
  }

  void removeFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedFavoriteCarsJsonList =
        favoriteCars.map((car) => jsonEncode(car.toJson())).toList();

    await prefs.setStringList("favorite_cars", updatedFavoriteCarsJsonList);
  }

  bool isCarFavorite(Car car) => favoriteCars.any((element) =>
      element.selectedModification.complectationId ==
      car.selectedModification.complectationId);

  set isFavorite(bool value) => _isFavorite.value = value;

  Future<List<Car>> getFavoriteCarsFromPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Получаем список JSON строк из SharedPreferences
      List<String>? favoriteCarsJsonList = prefs.getStringList("favorite_cars");
      log(favoriteCarsJsonList);

      // Если список пустой или null, возвращаем пустой список
      if (favoriteCarsJsonList == null) return [];

      // Преобразуем JSON строки обратно в объекты Car
      List<Car> favoriteCarsList = favoriteCarsJsonList
          .map((carJson) => Car.fromJson(jsonDecode(carJson)))
          .toList();

      // Обновляем локальное состояние
      _favoriteCars.assignAll(favoriteCarsList);

      log(_favoriteCars.first.toJson());

      return favoriteCarsList;
    } catch (e) {
      logW(e);
      return [];
    }
  }

  Future<void> saveFavoriteCarsToPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Преобразуем список объектов Car в список JSON строк
      List<String> favoriteCarsJsonList =
          _favoriteCars.map((car) => jsonEncode(car.toJson())).toList();

      log(favoriteCarsJsonList);
      // Сохраняем список JSON строк в SharedPreferences
      await prefs.setStringList("favorite_cars", favoriteCarsJsonList);
    } catch (e) {
      logW(e);
      return;
    }
  }
}

class FavoriteBinding extends Bindings {
  @override
  FavoriteController dependencies() =>
      Get.put(FavoriteController(), permanent: true);
}
