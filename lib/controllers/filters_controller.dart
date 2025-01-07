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

  void resetFilters() {
    _models.value = ModelsController.to.models;
    _isFiltesApplied.value = false;
  }

  void applyFilters() {
    _searchSelectedModels();
    // _searchModelBodyTypes();
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
  void dependencies() => Get.lazyPut(() => FiltersController(), fenix: true);
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

  final RxBool _isSearching = false.obs;
  bool get isSearching => _isSearching.value;
  set isSearching(bool value) => _isSearching.value = value;

  final RxString _query = "".obs;
  String get query => _query.value;
  set query(String value) => _query.value = value;

  List<Model> results = <Model>[];

  List<String> recentSearch = [];

  @override
  void onInit() {
    super.onInit();
    debounce(
      _query,
      (value) => search(),
      time: const Duration(milliseconds: 1500),
    );
  }

  @override
  TextEditingController controller = TextEditingController();

  @override
  void clearSearch() {
    query = "";
    controller.text = "";
    results.clear();
    isSearching = false;
  }

  void search() {
    isSearching = true;

    final List<Model> models = List.from(ModelsController.to.models);

    if (query.isEmpty) {
      results = [];
      isSearching = false;
      return;
    }

    results = models.where(
      (Model model) {
        final String name = model.name!.toLowerCase();
        final String cirillicName = model.cyrillicName!.toLowerCase();
        final String input = query.toLowerCase();

        return name.contains(input) || cirillicName.contains(input);
      },
    ).toList();
    isSearching = false;
    update();
  }

  @override
  void startSearch(String text) {
    isSearching = true;

    query = text;

    update();
  }
}
