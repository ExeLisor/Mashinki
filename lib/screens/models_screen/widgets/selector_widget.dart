import 'package:autoverse/exports.dart';

class SelectorWidget extends StatelessWidget {
  const SelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _modelButton();
  }

  Future<void> _showModels() async {
    ModelsSelectorController.to.openSelector();
    await Get.bottomSheet(modelsSheet());
    ModelsSelectorController.to.search();
    ModelsSelectorController.to.closeSelector();
  }

  Widget modelsSheet() => IntrinsicHeight(
        child: Container(
          width: Get.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: Color(0XFFf5f5f5),
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: _modelsWrap()),
        ),
      );

  Widget _modelsWrap() => SingleChildScrollView(
        padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Модели",
                    style:
                        TextStyle(fontSize: 24.fs, fontWeight: FontWeight.bold),
                  ),
                  _clearSelectedModelsButton()
                ],
              ),
            ),
            Obx(
              () => Wrap(
                spacing: 12.h,
                children: [
                  ...List.generate(
                      ModelsSelectorController.to.models.length,
                      (index) => _selectorTile(
                          ModelsSelectorController.to.models[index].name ?? ""))
                ],
              ),
            ),
          ],
        ),
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

  void _modelButtonActions() {
    ModelsSelectorController.to.isOpened
        ? ModelsSelectorController.to.closeSelector
        : _showModels();
  }

  Widget _modelButton() => Obx(
        () => GestureDetector(
          onTap: _modelButtonActions,
          child: Container(
            margin: EdgeInsets.only(left: 25.h),
            child: Container(
              margin: EdgeInsets.only(bottom: 12.h, top: 6.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.h),
                  color: ModelsSelectorController.to.isOpened ||
                          ModelsSelectorController.to.isSelected
                      ? primaryColor
                      : Colors.grey.withOpacity(0.3)),
              child: UnconstrainedBox(
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Center(
                    child: Text(
                      "Модели",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ModelsSelectorController.to.isOpened ||
                                  ModelsSelectorController.to.isSelected
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

  Widget _selectorTile(String model) => GestureDetector(
        onTap: () => ModelsSelectorController.to.selectModel(model),
        child: UnconstrainedBox(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.w),
            child: Obx(
              () => Container(
                margin: EdgeInsets.only(bottom: 12.h, top: 6.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.h),
                    color: ModelsSelectorController.to.isModelSelected(model)
                        ? primaryColor
                        : Colors.grey.withOpacity(0.3)),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Center(
                    child: Text(
                      model,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              ModelsSelectorController.to.isModelSelected(model)
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

  void selectModel(String model) {
    _isSelected.value = true;
    ModelsSelectorController.to.isModelSelected(model)
        ? _selectedModelsNames.remove(model)
        : _selectedModelsNames.add(model);
    if (_selectedModelsNames.isEmpty) _isSelected.value = false;
  }

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
