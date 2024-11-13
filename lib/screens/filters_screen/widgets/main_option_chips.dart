import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/filters_screen/models/main_options/main_options_list.dart';

class MainOptionsChips extends StatelessWidget {
  const MainOptionsChips({
    super.key,
    required this.mainOption,
  });

  final MainOptionField mainOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(height: 18.h),
          _chips(),
        ],
      ),
    );
  }

  Widget _chips() => Row(
        mainAxisAlignment: mainOption.values!.length < 3
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: List.generate(
            mainOption.values!.length,
            (index) => mainOption.values!.length > 5
                ? _roundedChip(mainOption.values![index])
                : _chip(mainOption.values![index])),
      );

  Widget _title() => Container(
        margin: EdgeInsets.only(left: 9.w),
        child: Text(
          mainOption.title,
          style: const TextStyle(
            color: primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 0.08,
          ),
        ),
      );

  Widget _chip(String valueText) => GestureDetector(
        onTap: () => FilterController.to.actionWithValue(
            valueText, "mainOptions", "chips", mainOption.field),
        child: Obx(
          () => Container(
            height: 36.h,
            padding: mainOption.values!.length > 5
                ? EdgeInsets.all(10.h)
                : EdgeInsets.symmetric(horizontal: 22.w),
            margin: mainOption.values!.length < 3
                ? EdgeInsets.only(right: 10.w)
                : null,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(15),
                color: FilterController.to.checkValue(
                        valueText, "mainOptions", "chips", mainOption.field)
                    ? primaryColor
                    : Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  valueText,
                  style: TextStyle(
                    color: FilterController.to.checkValue(
                            valueText, "mainOptions", "chips", mainOption.field)
                        ? whiteColor
                        : blackColor,
                    fontSize: 16.fs,
                    fontWeight: FontWeight.w400,
                    height: 0.08,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _roundedChip(String valueText) => GestureDetector(
        onTap: () => FilterController.to.actionWithValue(
            valueText, "mainOptions", "chips", mainOption.field),
        child: Obx(
          () => Container(
            width: 36.w,
            height: 36.w,
            margin: mainOption.values!.length < 3
                ? EdgeInsets.only(right: 10.w)
                : null,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(11),
                color: FilterController.to.checkValue(
                        valueText, "mainOptions", "chips", mainOption.field)
                    ? primaryColor
                    : Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  valueText,
                  style: TextStyle(
                    color: FilterController.to.checkValue(
                            valueText, "mainOptions", "chips", mainOption.field)
                        ? whiteColor
                        : blackColor,
                    fontSize: 16.fs,
                    fontWeight: FontWeight.w400,
                    height: 0.08,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
