import 'package:autoverse/exports.dart';

import 'package:autoverse/screens/filters_screen/select_models_screen.dart';

import '../../marks_screen/widgets/mark_tile.dart';

class MarksFilterWidget extends StatelessWidget {
  const MarksFilterWidget({super.key});

  static const Color background = Color(0xffF5F4FF);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      padding: EdgeInsets.all(15.h),
      height: 143.h,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          _markWidget(),
          SizedBox(height: 13.h),
          _modelsWidget(),
        ],
      ),
    );
  }

  Widget _markWidget() => Row(
        children: [
          _logo(),
          SizedBox(width: 10.w),
          _markName(),
        ],
      );

  Widget _logoPlaceholder() => Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppThemeController.to.whiteColor),
      );

  Widget _logo() => MarkLogo(
        height: 50,
        width: 50,
        mark: ModelsController.to.mark,
        showShadow: false,
      );

  Widget _markName() => Expanded(
        child: _shell(
          child: Center(
            child: Text(
              ModelsController.to.mark.name ?? "",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.fs,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      );

  Widget _shell({required Widget child}) => Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: AppThemeController.to.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: child,
      );

  Widget _modelsWidget() => GestureDetector(
        onTap: navgiteToSelectModels,
        child: _shell(
          child: GetBuilder<FilterController>(
            builder: (controller) => Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20.w),
                        Text(
                          controller.selectedModels.isEmpty
                              ? "Модели".tr
                              : controller.getSelectedModelsNames().join(", "),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.fs,
                            color: controller.selectedModels.isEmpty
                                ? unactiveColor
                                : Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
