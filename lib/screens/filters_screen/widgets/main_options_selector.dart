import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/filters_screen/models/main_options/main_options_list.dart';
import 'package:autoverse/screens/filters_screen/widgets/option_selector.dart';

class MainOptionSelector extends StatelessWidget {
  const MainOptionSelector({super.key, required this.mainOption});

  final MainOptionField mainOption;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showSelectorBottomBar(mainOption),
      child: Container(
        height: 50.h,
        margin: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 28.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilterController.to.filter["mainOptions"][mainOption.field] ==
                      null
                  ? _title()
                  : _selectedParams(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() => SizedBox(
        child: Text(
          mainOption.title,
          style: TextStyle(
            color: greyColor,
            fontSize: 16.fs,
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  Widget _selectedParams() => Flexible(
        child: Text(
          FilterController.to.filter["mainOptions"][mainOption.field]
              .join(", "),
          style: TextStyle(
            fontSize: 16.fs,
            fontWeight: FontWeight.w400,
            // height: 0.08,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
      );
}

void showSelectorBottomBar(MainOptionField mainOption) {
  //фиксит баг с клавиатурой, которая появляется после открытия. баг возникает при TextField -> unfocus -> open bottomSheet
  FocusScope.of(Get.context!).requestFocus(FocusNode());
  Get.bottomSheet(
    SelectorBottomSheet(mainOption: mainOption),
    isScrollControlled: true,
  ).whenComplete(() => FocusScope.of(Get.context!).requestFocus(FocusNode()));
}

class SelectorBottomSheet extends StatefulWidget {
  const SelectorBottomSheet({super.key, required this.mainOption});

  final MainOptionField mainOption;

  @override
  State<SelectorBottomSheet> createState() => _SelectorBottomSheetState();
}

class _SelectorBottomSheetState extends State<SelectorBottomSheet> {
  List<String> values = [];

  @override
  void initState() {
    super.initState();

    values = List.from(FilterController.to.filter["mainOptions"]
            [widget.mainOption.field] ??
        []);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        constraints: BoxConstraints(maxHeight: Get.height / 1.5),
        height: 614.h,
        width: Get.width,
        padding: EdgeInsets.only(top: 28.h),
        decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _homeLine(),
            SizedBox(height: 13.h),
            _titleRow(),
            SizedBox(height: 13.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 28.h),
                child: _checkBoxes(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleRow() => Container(
        margin: EdgeInsets.symmetric(horizontal: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _title(),
            Row(
              children: [
                _apply(),
                _verticalDivider(),
                _reset(),
              ],
            ),
          ],
        ),
      );

  Widget _verticalDivider() => Container(
        width: 1,
        height: 20.h,
        color: paleColor,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
      );

  Widget _apply() => GestureDetector(
        onTap: _applyAction,
        child: Text(
          'Применить',
          style: TextStyle(
            color: paleColor,
            fontSize: 16.fs,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  Widget _reset() => GestureDetector(
        onTap: _resetAction,
        child: Text(
          'Сбросить',
          style: TextStyle(
            color: paleColor,
            fontSize: 16.fs,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  Widget _homeLine() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.60,
            child: Container(
              width: 49,
              height: 4,
              decoration: ShapeDecoration(
                color: unactiveColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ],
      );

  Widget _title() => Text(
        widget.mainOption.title,
        style: TextStyle(
          color: blackColor,
          fontSize: 20.fs,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _checkBoxes() {
    var entriesList = widget.mainOption.values.entries.toList();

    return Container(
      margin: EdgeInsets.only(left: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          entriesList.length,
          (index) {
            var entry = entriesList[index];

            return OptionCheckBox(
              category: "mainOptions",
              entry: entry,
              field: widget.mainOption,
            );
          },
        ),
      ),
    );
  }

  void action(String text) => setState(
      () => values.contains(text) ? values.remove(text) : values.add(text));

  void _applyAction() {
    OptionSelectorController.to.applyAction("mainOptions", widget.mainOption);
    Get.back();
  }

  void _resetAction() =>
      OptionSelectorController.to.clearAction("mainOptions", widget.mainOption);
}
