import 'package:autoverse/exports.dart';

class SelectorWidget extends StatelessWidget {
  const SelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModelsSelectorController.to.isOpened
        ? _modelList()
        : _closedModelFilter());
  }

  Widget _closedModelFilter() => SingleChildScrollView(
        padding: EdgeInsets.only(top: 0.h, bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_modelsFilterTitle(), _selectedModelsWrap()],
        ),
      );

  Widget _selectedModelsWrap() => Obx(
        () => Wrap(
          spacing: 12.h,
          children: List.generate(
            ModelsSelectorController.to.selectedModels.length,
            (index) => _selectorTile(
                ModelsSelectorController.to.selectedModels[index]),
          ),
        ),
      );

  Future<void> _showModels() async {
    ModelsSelectorController.to.openSelector();
    // await Get.bottomSheet(modelsSheet());
    ModelsSelectorController.to.search();
    ModelsSelectorController.to.closeSelector();
  }

  Widget _modelsFilterTitle() => Container(
        margin: EdgeInsets.only(bottom: 12.h),
        child: GestureDetector(
          onTap: ModelsSelectorController.to.isOpened
              ? ModelsSelectorController.to.closeSelector
              : ModelsSelectorController.to.openSelector,
          child: Container(
            decoration: const BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_title(), _arrowIcon()],
            ),
          ),
        ),
      );

  Widget _title() => Text(
        "Модели",
        style: TextStyle(fontSize: 20.fs, fontWeight: FontWeight.bold),
      );

  Widget _arrowIcon() => Obx(
        () => RotatedBox(
          quarterTurns: ModelsSelectorController.to.isOpened ? 1 : 3,
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      );

  Widget _modelList() => SingleChildScrollView(
        padding: EdgeInsets.only(top: 0.h, bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _modelsFilterTitle(),
            _modelsWrap(),
          ],
        ),
      );

  Widget _modelsWrap() => Obx(
        () => Wrap(
            spacing: 12.h,
            children: List.generate(
                ModelsSelectorController.to.models.length,
                (index) =>
                    _selectorTile(ModelsSelectorController.to.models[index]))),
      );

  Widget _clearSelectedModelsButton() => GestureDetector(
        onTap: ModelsSelectorController.to.clearSelectedModels,
        child: UnconstrainedBox(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.h),
              color: primaryColor,
            ),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: const Center(
              child: Text(
                "Очистить",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
      );

  Widget _selectorTile(Model model) => GestureDetector(
        onTap: () => ModelsSelectorController.to.selectModel(model),
        child: UnconstrainedBox(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.w),
            child: Obx(
              () => Container(
                margin: EdgeInsets.only(bottom: 12.h, top: 6.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.h),
                    color: ModelsSelectorController.to
                            .isModelSelected(model.name ?? "")
                        ? primaryColor
                        : Colors.grey.withOpacity(0.3)),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Center(
                    child: Text(
                      model.name ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ModelsSelectorController.to
                                  .isModelSelected(model.name ?? "")
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class ModelsSelectorController extends GetxController {
  static ModelsSelectorController get to => Get.find();

  final RxList<Model> _models = <Model>[].obs;
  final RxSet<String> _selectedModelsNames = <String>{}.obs;
  final RxList<Model> _selectedModels = <Model>[].obs;
  final RxBool _isOpened = false.obs;
  final RxBool _isSelected = false.obs;

  List<Model> get models => _models;
  List<Model> get selectedModels => _selectedModels;
  Set<String> get selectedModelsNames => _selectedModelsNames;
  bool get isOpened => _isOpened.value;
  bool get isSelected => _isSelected.value;

  void openSelector() => _isOpened.value = true;

  void closeSelector() => _isOpened.value = false;

  void selectModel(Model model) {
    _isSelected.value = true;
    ModelsSelectorController.to.isModelSelected(model.name ?? "")
        ? _removeFromSelected(model)
        : _addToSelected(model);
    if (_selectedModelsNames.isEmpty) _isSelected.value = false;
  }

  void _removeFromSelected(Model model) {
    _selectedModelsNames.remove(model.name ?? "");
    _selectedModels.remove(model);
    return;
  }

  void _addToSelected(Model model) {
    _selectedModelsNames.add(model.name ?? "");
    _selectedModels.add(model);
    return;
  }

  void updateSelectedModels(List<Model> models) =>
      _selectedModels.value = models;

  void clearSelectedModels() {
    _isSelected.value = false;
    _selectedModelsNames.clear();
    Get.back();
  }

  void search() => _selectedModels.value = _getSelectedModels();

  List<Model> _getSelectedModels() => models
      .where((model) => selectedModelsNames
          .any((selectedModel) => model.name == selectedModel))
      .toList();

  bool isModelSelected(String model) =>
      ModelsSelectorController.to.selectedModelsNames.contains(model);

  @override
  void onInit() {
    super.onInit();
    _models.value = ModelsController.to.models;
  }
}

class ModelsSelectorBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ModelsSelectorController());
}
