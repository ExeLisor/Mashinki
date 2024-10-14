import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/filters_screen/models/main_options/main_options_list.dart';

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
          color: Colors.white,
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
            color: const Color(0xFF848484),
            fontSize: 16.fs,
            fontWeight: FontWeight.w400,
            height: 0.08,
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
        // margin: EdgeInsets.only(top: 260.h),

        width: Get.width,
        padding: EdgeInsets.only(top: 28.h),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _homeLine(),
            SizedBox(height: 13.h),
            _titleRow(),
            Expanded(
              // Фиксируем высоту для прокрутки
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 28.h),
                child: _chips(),
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
                color: const Color(0xFFDEDEDE),
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
          color: primaryColor,
          fontSize: 18.fs,
          fontWeight: FontWeight.w600,
          height: 0,
        ),
      );

  Widget _chips() {
    var entriesList = widget.mainOption.values.entries.toList();
    return Container(
      margin: EdgeInsets.only(left: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(entriesList.length, (index) {
          var entry = entriesList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _chipTitle(entry.key), // Отображаем ключ как заголовок
              SizedBox(height: 13.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 13.h,
                children: List.generate(
                    entry.value.length,
                    (i) => _chip(
                        entry.value[i]) // Генерируем чип для каждого значения

                    ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _category(Map<String, List<String>> category) => Column(
        children: [
          for (var entry in category.entries) ...[
            _chipTitle(entry.key), // Ключ категории в _chipTitle
            SizedBox(height: 13.h),
            for (var subCategory in entry.value) ...[
              _chip(subCategory), // Чип для каждого значения (подкатегории)
              SizedBox(height: 8.h), // Отступ между чипами
            ],
          ]
        ],
      );

  Widget _chipTitle(String categoryTitle) => categoryTitle.isEmpty
      ? const SizedBox.shrink()
      : Container(
          margin: EdgeInsets.only(left: 9.w, top: 18.h),
          child: Text(
            categoryTitle,
            style: const TextStyle(
              color: Color(0xFF4038FF),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 0.08,
            ),
          ),
        );

  Widget _chip(String valueText) => GestureDetector(
        onTap: () => action(valueText),
        child: IntrinsicWidth(
          child: Container(
            height: 36.h,
            padding: widget.mainOption.values!.length > 5
                ? EdgeInsets.all(10.h)
                : EdgeInsets.symmetric(horizontal: 22.w),
            margin: widget.mainOption.values!.length < 3
                ? EdgeInsets.only(right: 10.w)
                : null,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(15),
                color: values.contains(valueText)
                    ? primaryColor
                    : Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  valueText,
                  style: TextStyle(
                    color: values.contains(valueText)
                        ? Colors.white
                        : Colors.black,
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

  void action(String text) => setState(
      () => values.contains(text) ? values.remove(text) : values.add(text));

  void _applyAction() {
    FilterController.to.actionWithValue(
        values, "mainOptions", widget.mainOption.type, widget.mainOption.field);
    Get.back();
  }

  void _resetAction() {
    setState(() => values.clear());
    FilterController.to.actionWithValue(
        values, "mainOptions", widget.mainOption.type, widget.mainOption.field);
  }
}
