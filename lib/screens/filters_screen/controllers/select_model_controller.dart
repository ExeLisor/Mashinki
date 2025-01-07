import 'package:autoverse/exports.dart';
import 'package:autoverse/models/alphabet.dart';

class SelectModelsController extends AlphabetController<Model> {
  static SelectModelsController get to => Get.find();

  final Rx<SelectModelsState> _selectorState = SelectModelsState.all.obs;
  SelectModelsState get selectorState => _selectorState.value;
  set selectorState(SelectModelsState value) => _selectorState.value = value;

  Future<void> changeStateToAll() async {
    selectorState = SelectModelsState.all;

    await initItemsList();

    update();
  }

  @override
  void dispose() {
    _selectorState.close();
    super.dispose();
  }

  Future<void> changeStateToSelected() async {
    selectorState = SelectModelsState.selected;

    isLoading = true;
    grouped.clear();

    List<Model> models = List.from(selectedModels);
    grouped = await _getGroupedModels(models);

    isLoading = false;

    update();
  }

  final RxMap<String, List<Model>> _grouped = <String, List<Model>>{}.obs;
  Map<String, List<Model>> get grouped => _grouped;
  set grouped(Map<String, List<Model>> value) => _grouped.value = value;

  final RxBool _isAllSelected = false.obs;
  bool get isAllSelected => _isAllSelected.value;
  set isAllSelected(bool value) => _isAllSelected.value = value;

  final RxList<Model> _selectedModels = <Model>[].obs;
  List<Model> get selectedModels => _selectedModels;

  void addModel(Model model) {
    _selectedModels.add(model);
    update();
  }

  void actionWithModel(Model model) =>
      isAdded(model) ? removedModel(model) : addModel(model);

  void removedModel(Model model) {
    _selectedModels.remove(model);
    update();
  }

  void clearSelectedModels() {
    _selectedModels.clear();
    update();
  }

  void unselect() {
    _selectedModels.clear();
    isAllSelected = false;
    update();
  }

  void selectAll() {
    final List<Model> allModels = List.from(ModelsController.to.models);
    _selectedModels.value = allModels;
    isAllSelected = true;
    update();
  }

  bool isAdded(Model model) => _selectedModels.any((m) => m.id == model.id);

  @override
  Future<void> initItemsList() async {
    isLoading = true;
    grouped.clear();

    List<Model> models = List.from(ModelsController.to.models);
    grouped = await _getGroupedModels(models);

    isLoading = false;
  }

  Future<Map<String, List<Model>>> _getGroupedModels(List<Model> models) async {
    Map<String, List<Model>> groupedModels = {};

    for (var model in models) {
      String key = RegExp(r'^[0-9]').hasMatch(model.name!)
          ? '#'
          : model.name![0].toUpperCase();

      if (!groupedModels.containsKey(key)) {
        groupedModels[key] = [];
      }
      groupedModels[key]!.add(model);
    }

    return groupedModels;
  }

  @override
  void scrollToIndex(int index) => itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
}

enum SelectModelsState { all, selected }
