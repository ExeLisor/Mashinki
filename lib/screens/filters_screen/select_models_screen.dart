import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/filters_screen/controllers/search_model.dart';

import 'package:autoverse/screens/filters_screen/controllers/select_model_controller.dart';

void navgiteToSelectModels() {
  Get.put(SelectModelsController());
  Get.put(ModelSearchController());

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  SelectModelsController.to.itemScrollController = itemScrollController;
  SelectModelsController.to.itemPositionsListener = itemPositionsListener;

  SelectModelsController.to.initItemsList();
  ModelSearchController.to.clearSearch();

  Get.toNamed('/selectModels');
}

class SelectModelsScreen extends GetView<SelectModelsController> {
  const SelectModelsScreen({super.key});

  @override
  Widget build(BuildContext context) => Obx(
        () => Scaffold(
          backgroundColor: AppThemeController.to.whiteColor,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: _bottomBar(),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _appBar(),
                  SizedBox(height: 5.h),
                  _searchBar(),
                  SizedBox(height: 20.h),
                  _body()
                ],
              ),
              _selectButtons()
            ],
          ),
        ),
      );

  Widget _selectButtons() => Obx(
        () => controller.selectedModels.isNotEmpty
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _clearButton(),
                    SizedBox(width: 8.w),
                    _applyButton()
                  ],
                ),
              )
            : Container(),
      );

  Widget _clearButton() => _button(
      'Сбросить'.tr,
      AppThemeController.to.searchContainerColor,
      AppThemeController.to.appBarItemsColor,
      controller.clearSelectedModels);

  Widget _applyButton() =>
      _button('Применить'.tr, paleColor, Colors.white, controller.apply);

  Widget _button(String text, Color buttonColor, Color textColor,
          VoidCallback? onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          width: 165.w,
          height: 44.h,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: const [
              BoxShadow(
                color: boxShadowColor,
                blurRadius: 15,
                offset: Offset(-1, 10),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: boxShadowColor,
                blurRadius: 15,
                offset: Offset(1, 1),
                spreadRadius: 2,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15.fs,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      );

  Widget _body() => GetBuilder<ModelSearchController>(
      builder: (controller) => controller.query.isEmpty
          ? _modelsList()
          : controller.isSearching
              ? _loadingWidget()
              : _resultModels(controller.results));

  Widget _loadingWidget() =>
      const Expanded(child: Center(child: CircularProgressIndicator()));

  Widget _modelsList() => Expanded(
        child: Column(
          children: [
            _selector(),
            SizedBox(height: 20.h),
            _alphabet(),
            SizedBox(height: 20.h),
            _modelsView()
          ],
        ),
      );

  Widget _searchBar() => CarsSearchBar(
        showFilters: false,
        controller: ModelSearchController.to,
        isDevelop: false,
      );

  Widget _bottomBar() => HomeScreenBottomBarWidget();

  AppBar _appBar() => AppBar(
        backgroundColor: AppThemeController.to.whiteColor,
        title: _appBarText(),
        leading: _iconBack(),
        actions: [_selectAll()],
      );

  Widget _selectAll() => GestureDetector(
        onTap: controller.selectAll,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          color: Colors.transparent,
          child: Text(
            "Выбрать всё".tr,
            style: TextStyle(
                color: AppThemeController.to.appBarItemsColor,
                fontSize: 14.fs,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300),
          ),
        ),
      );

  Widget _appBarText() => Column(
        children: [
          Text(
            'Модели'.tr,
            style: TextStyle(
              color: AppThemeController.to.appBarItemsColor,
              fontSize: 20.fs,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
  Widget _iconBack() => GestureDetector(
        onTap: Get.back,
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          child: Padding(
            padding: EdgeInsets.only(left: 4.0.w),
            child: SizedBox(
              child: SvgPicture.asset(
                "assets/svg/back.svg",
                color: AppThemeController.to.appBarItemsColor,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      );

  Widget _selector() => Container(
        height: 40.h,
        width: 362.w,
        decoration: BoxDecoration(
            color: AppThemeController.to.greyModelSelectTileBackgroundColor,
            borderRadius: BorderRadius.circular(33.h)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_allModels(), SizedBox(width: 6.w), _selectedModels()]),
      );

  Widget _allModels() => Obx(() => _selectButton(
      "Все модели".tr,
      SelectModelsState.all,
      controller.selectorState == SelectModelsState.all));

  Widget _selectedModels() => Obx(() => _selectButton(
      "${"Выбрано".tr}: ${controller.selectedModels.length}".tr,
      SelectModelsState.selected,
      controller.selectorState == SelectModelsState.selected));

  Widget _selectButton(String text, SelectModelsState state, bool isSelected) =>
      Expanded(
        child: GestureDetector(
          onTap: state == SelectModelsState.selected
              ? controller.changeStateToSelected
              : controller.changeStateToAll,
          child: Container(
            height: 32.h,
            decoration: BoxDecoration(
                color: isSelected
                    ? paleColor
                    : AppThemeController.to.greyModelSelectTileColor,
                borderRadius: BorderRadius.circular(100.h)),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 14.fs,
                    color: isSelected
                        ? Colors.white
                        : AppThemeController.to.appBarItemsColor,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter'),
              ),
            ),
          ),
        ),
      );

  Widget _alphabet() => AlphabetRow(
        controller: controller,
        alphabet: controller.grouped.keys.toList(),
      );

  Widget _modelsView() {
    return Obx(() => controller.grouped.keys.isEmpty
        ? _empty()
        : Expanded(
            child: ScrollablePositionedList.builder(
                physics: const BouncingScrollPhysics(),
                itemScrollController: controller.itemScrollController,
                itemPositionsListener: controller.itemPositionsListener,
                itemCount: controller.grouped.keys.length,
                padding: EdgeInsets.only(bottom: 60.h),
                itemBuilder: (context, index) => _alphabetView(index))));
  }

  Widget _empty() => Expanded(
        child: Center(
          child: Text(
            "🚗❓🤷‍♂️",
            style: TextStyle(fontSize: 40.fs),
          ),
        ),
      );

  Widget _alphabetView(int index) {
    // final symbol = controller.grouped.keys.toList()[index];
    final models = controller.grouped.values.toList()[index];
    final isKeysEmpty = controller.grouped.keys.isEmpty;

    return Column(
      children: [
        // _header(symbol),
        if (!isKeysEmpty && index < controller.grouped.keys.length)
          _models(models)
      ],
    );
  }

  Widget _models(List<Model> marks) => Column(
        children: List.generate(
          marks.length,
          (index) => Column(
            children: [
              const SettingsDivider(),
              _modelTile(marks[index]),
            ],
          ),
        ),
      );

  Widget _resultModels(List<Model> marks) => Expanded(
        child: ListView.builder(
          itemCount: marks.length,
          itemBuilder: (context, index) => Column(
            children: [
              const SettingsDivider(),
              _modelTile(marks[index]),
            ],
          ),
        ),
      );

  Widget _modelTile(Model model) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_modelName(model), _checkBox(model)],
        ),
      );

  Widget _checkBox(Model model) => Obx(
        () => Checkbox(
          value: controller.isAdded(model),
          onChanged: (_) => controller.actionWithModel(model),
          activeColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      );

  Widget _modelName(Model model) => Text(
        model.name ?? "",
        style: TextStyle(
            color: AppThemeController.to.appBarItemsColor,
            fontSize: 14.fs,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter'),
      );

  Widget _header(String symbol) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        child: Row(
          children: [
            if (symbol != '#') _divider(),
            _headerText(symbol),
            if (symbol != '#') _divider(),
          ],
        ),
      );

  Widget _divider() => Expanded(
        child: Divider(
          color: paleColor.withOpacity(0.5),
          thickness: 1,
        ),
      );

  Widget _headerText(String symbol) => Padding(
        padding: EdgeInsets.symmetric(horizontal: symbol == '#' ? 0 : 12.0.h),
        child: Text(
          symbol == '#' ? 'popular-marks'.tr : symbol,
          style: TextStyle(
              color:
                  AppThemeController.to.isDarkTheme ? whiteColor : primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: symbol == '#' ? 16.fs : 25.fs),
        ),
      );
}
