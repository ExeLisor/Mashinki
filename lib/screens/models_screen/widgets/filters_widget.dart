import 'package:autoverse/exports.dart';

class ModelsFiltersWidget extends StatelessWidget {
  const ModelsFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.size.height * 0.9, // Покрывает почти весь экран

      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(24.h)),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 25.h),
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            _models(),
            _bodyTypes(),
            _applyButton(),
            // _showRestyling(),
          ],
        ),
      ),
    );
  }

  Widget _applyButton() => UnconstrainedBox(
        child: GestureDetector(
          onTap: FiltersController.to.applyFilters,
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h, top: 6.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.h), color: primaryColor),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: const Center(
                child: Text(
                  "Применить",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
                ),
              ),
            ),
          ),
        ),
      );

  // Widget _showRestyling() => Obx(
  //       () => UnconstrainedBox(
  //         child: GestureDetector(
  //           onTap: ModelsFilterController.to.searchRestyling,
  //           child: Container(
  //             margin: EdgeInsets.only(bottom: 12.h, top: 6.h),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(16.h),
  //                 color: ModelsFilterController.to.restyling
  //                     ? primaryColor
  //                     : Colors.grey.withOpacity(0.3)),
  //             child: Container(
  //               margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
  //               child: Center(
  //                 child: Text(
  //                   "Рестайлинг",
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       color: ModelsFilterController.to.restyling
  //                           ? whiteColor
  //                           : blackColor),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );

  Widget _title() => Container(
        margin: EdgeInsets.only(bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Параметры",
              style: TextStyle(
                  fontSize: 20.fs,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ],
        ),
      );

  Widget _models() => const SelectorWidget();
  Widget _bodyTypes() => const BodyTypesSelector();
}

class BodyTypesSelector extends StatelessWidget {
  const BodyTypesSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModelsBodySelectorController.to.isOpened
        ? _bodyTypesList()
        : _closedModelFilter());
  }

  Widget _closedModelFilter() => SingleChildScrollView(
        padding: EdgeInsets.only(top: 0.h, bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_bodyTypesFilterTitle(), _selectedModelsWrap()],
        ),
      );

  Widget _selectedModelsWrap() => Obx(
        () => Wrap(
          spacing: 12.h,
          children: List.generate(
            ModelsBodySelectorController.to.selectedBodyTypes.length,
            (index) => _selectorTile(ModelsBodySelectorController
                .to.selectedBodyTypes
                .elementAt(index)),
          ),
        ),
      );

  Widget _bodyTypesFilterTitle() => Container(
        margin: EdgeInsets.only(bottom: 12.h),
        child: GestureDetector(
          onTap: ModelsBodySelectorController.to.isOpened
              ? ModelsBodySelectorController.to.closeSelector
              : ModelsBodySelectorController.to.openSelector,
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
        "Типы кузова",
        style: TextStyle(fontSize: 20.fs, fontWeight: FontWeight.bold),
      );

  Widget _arrowIcon() => Obx(
        () => RotatedBox(
          quarterTurns: ModelsBodySelectorController.to.isOpened ? 1 : 3,
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      );

  Widget _bodyTypesList() => SingleChildScrollView(
        padding: EdgeInsets.only(top: 0.h, bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bodyTypesFilterTitle(),
            _bodyTypesWrap(),
          ],
        ),
      );

  Widget _bodyTypesWrap() => Obx(
        () => Wrap(
            spacing: 12.h,
            children: List.generate(
                ModelsBodySelectorController.to.modelsBodyTypes.length,
                (index) => _selectorTile(ModelsBodySelectorController
                    .to.modelsBodyTypes
                    .elementAt(index)))),
      );

  Widget _clearSelectedBodyTypesButton() => GestureDetector(
        // onTap: ModelsBodySelectorController.to.clearSelectedModels,
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
                    TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
              ),
            ),
          ),
        ),
      );

  Widget _selectorTile(String bodyType) => GestureDetector(
        onTap: () => ModelsBodySelectorController.to.selectBodyType(bodyType),
        child: UnconstrainedBox(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.w),
            child: Obx(
              () => Container(
                margin: EdgeInsets.only(bottom: 12.h, top: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.h),
                  color: ModelsBodySelectorController.to
                          .isBodyTypeSelected(bodyType)
                      ? primaryColor
                      : Colors.grey.withOpacity(0.3),
                ),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Center(
                    child: Text(
                      bodyType,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ModelsBodySelectorController.to
                                  .isBodyTypeSelected(bodyType)
                              ? whiteColor
                              : blackColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
