import 'package:autoverse/exports.dart';

class FiltersController extends GetxController {
  static FiltersController get to => Get.find();

  final RxList<Model> _models = <Model>[].obs;
  final RxBool _isFiltesApplied = false.obs;

  List<Model> get models => _models;
  bool get isFiltesApplied => _isFiltesApplied.value;

  set models(List<Model> value) => _models.value = value;

  @override
  void onInit() {
    _models.value = ModelsController.to.models;
    super.onInit();
  }

  void applyFilters() {
    _searchSelectedModels();
    _searchModelBodyTypes();
    _isFiltesApplied.value = true;
    Get.back();
  }

  void _searchSelectedModels() {
    List<Model> selectedModels = ModelsSelectorController.to.selectedModels;
    if (selectedModels.isNotEmpty) models = selectedModels;
    return;
  }

  void _searchModelBodyTypes() {
    List<Model> selectedModels =
        ModelsBodySelectorController.to.searchModelsWithSelectedBodies();

    if (selectedModels.isNotEmpty) models = selectedModels;
    return;
  }
}

class FiltersBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => FiltersController());
}

class RestylingFilterController extends GetxController {
  static RestylingFilterController get to => Get.find();

  final RxBool _isRestyled = true.obs;

  bool get isRestyled => _isRestyled.value;
}

class ModelsSearchBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ModelsSearchController());
}

class ModelsSearchController extends GetxController
    implements SearchFieldController {
  static ModelsSearchController get to => Get.find();

  final RxList<Model> _results = <Model>[].obs;
  final RxString _query = "".obs;

  List<Model> get results => _results;
  String get query => _query.value;

  @override
  TextEditingController controller = TextEditingController();

  @override
  void clearSearch() {
    _query.value = "";
    controller.text = "";
    _results.value = <Model>[];
  }

  @override
  void startSearch(String text) {
    _query.value = text;

    if (query.isEmpty) {
      _results.value = [];
    } else {
      _results.value = ModelsController.to.models.where(
        (Model model) {
          final String name = model.name!.toLowerCase();
          final String cirillicName = model.cyrillicName!.toLowerCase();
          final String input = query.toLowerCase();

          return name.contains(input) || cirillicName.contains(input);
        },
      ).toList();
    }
  }
}
