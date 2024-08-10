import 'package:autoverse/exports.dart';

class ModelsFiltersWidget extends StatelessWidget {
  const ModelsFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.size.height * 0.9, // Покрывает почти весь экран

      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24.h)),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 25.h),
        physics: const ClampingScrollPhysics(),
        children: [
          _title(),
          _models(),
          _showRestyling(),
        ],
      ),
    );
  }

  Widget _showRestyling() => Obx(
        () => UnconstrainedBox(
          child: GestureDetector(
            onTap: ModelsFilterController.to.searchRestyling,
            child: Container(
              margin: EdgeInsets.only(bottom: 12.h, top: 6.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.h),
                  color: ModelsFilterController.to.restyling
                      ? primaryColor
                      : Colors.grey.withOpacity(0.3)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Center(
                  child: Text(
                    "Рестайлинг",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ModelsFilterController.to.restyling
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

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

  Widget _models() => SelectorWidget();
}

class ModelsFilterController extends GetxController {
  static ModelsFilterController get to => Get.find();

  final RxBool _restyling = true.obs;

  bool get restyling => _restyling.value;

  void searchRestyling() {
    _restyling.value = false;
    List<Model> newModelsList = ModelsSelectorController.to.selectedModels;

    for (int i = 0; i < newModelsList.length; i++) {
      for (int k = 0; k < newModelsList[i].generations!.length; k++) {
        if (newModelsList[i].generations![k].isRestyle == true) {
          newModelsList[i]
              .generations!
              .remove(newModelsList[i].generations![k]);
        }
      }
    }

    ModelsSelectorController.to.updateSelectedModels(newModelsList);
  }
}

class ModelsFilterBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ModelsFilterController());
}
