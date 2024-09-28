// ignore_for_file: invalid_use_of_protected_member

import 'package:autoverse/exports.dart';

class ModelsBodySelectorController extends GetxController {
  static ModelsBodySelectorController get to => Get.find();

  final RxList<Model> _resultModels = <Model>[].obs;
  final RxSet<String> _modelsBodyTypes = <String>{}.obs;
  final RxSet<String> _selectedBodyTypes = <String>{}.obs;
  final RxBool _isOpened = false.obs;
  final RxBool _isSelected = false.obs;

  List<Model> get resultModels => _resultModels;
  Set<String> get modelsBodyTypes => _modelsBodyTypes;
  Set<String> get selectedBodyTypes => _selectedBodyTypes;
  bool get isOpened => _isOpened.value;
  bool get isSelected => _isSelected.value;

  set modelsBodyTypes(Set<String> value) => _modelsBodyTypes.value = value;

  Set<String> _getCurrentMarkModelsBodies() {
    List<Model> markModels = ModelsController.to.models;
    Set<String> bodyTypes = {};
    for (Model model in markModels) {
      for (Generation generation in model.generations) {
        for (Configuration configuration in generation.configurations) {
          bodyTypes.add(configuration.bodyType ?? "");
        }
      }
    }
    return bodyTypes;
  }

  List<Model> searchModelsWithSelectedBodies() {
    List<Model> markModels = List.from(FiltersController.to.models);
    List<Model> modelsWithSelectedBodyTypes = [];
    for (Model model in markModels) {
      List<Generation> generations = [];
      for (Generation generation in model.generations) {
        List<Configuration> configurations = [];
        for (Configuration configuration in generation.configurations) {
          if (selectedBodyTypes.contains(configuration.bodyType)) {
            generations.add(generation);
            configurations.add(configuration);
          }
        }

        generation.configurations = configurations;
      }

      model.generations = generations;
      if (model.generations.isNotEmpty) modelsWithSelectedBodyTypes.add(model);
    }
    return modelsWithSelectedBodyTypes;
  }

  void openSelector() => _isOpened.value = true;

  void closeSelector() => _isOpened.value = false;

  void selectBodyType(String bodyType) {
    _isSelected.value = true;
    isBodyTypeSelected(bodyType)
        ? _removeFromSelected(bodyType)
        : _addToSelected(bodyType);
    if (modelsBodyTypes.isEmpty) _isSelected.value = false;
  }

  void _removeFromSelected(String bodyType) {
    _selectedBodyTypes.remove(bodyType);
    return;
  }

  void _addToSelected(String bodyType) {
    _selectedBodyTypes.add(bodyType);
    return;
  }

  bool isBodyTypeSelected(String bodyType) =>
      selectedBodyTypes.contains(bodyType);

  @override
  void onInit() {
    modelsBodyTypes = _getCurrentMarkModelsBodies();
    super.onInit();
  }
}

class BodyTypeSelectorBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut(() => ModelsBodySelectorController(), fenix: true);
}

enum Body {
  suv3Door, // Внедорожник 3 дв.
  suv5Door, // Внедорожник 5 дв.
  suvConvertible, // Внедорожник открытый
  convertible, // Кабриолет
  compactVan, // Компактвэн
  coupe, // Купе
  coupeHardtop, // Купе-хардтоп
  limousine, // Лимузин
  liftback, // Лифтбек
  microVan, // Микровэн
  minivan, // Минивэн
  pickupDoubleCab, // Пикап двойная кабина
  pickupSingleCab, // Пикап одинарная кабина
  pickupExtraCab, // Пикап полуторная кабина
  roadster, // Родстер
  sedan, // Седан
  sedanHardtop, // Седан-хардтоп
  speedster, // Спидстер
  targa, // Тарга
  stationWagon, // Универсал
  stationWagon3Door, // Универсал 3 дв.
  stationWagon5Door, // Универсал 5 дв.
  fastback, // Фастбек
  phaeton, // Фаэтон
  phaetonWagon, // Фаэтон-универсал
  van, // Фургон
  hatchback3Door, // Хэтчбек 3 дв.
  hatchback4Door, // Хэтчбек 4 дв.
  hatchback5Door // Хэтчбек 5 дв.
}
