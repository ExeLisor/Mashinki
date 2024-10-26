import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/filters_screen/models/main_options/main_options_list.dart';

class OptionCheckBox extends StatefulWidget {
  const OptionCheckBox({
    super.key,
    required this.field,
    required this.entry,
    required this.category,
    this.isLast = false,
  });

  final MainOptionField field;
  final MapEntry entry;
  final bool isLast;
  final String category;

  @override
  State<OptionCheckBox> createState() => _OptionCheckBoxState();
}

class _OptionCheckBoxState extends State<OptionCheckBox> {
  bool isExpanded = false;

  OptionSelectorController controller = OptionSelectorController.to;

  @override
  void initState() {
    controller.setValues(List.from(
        FilterController.to.filter[widget.category][widget.field.field] ?? []));
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      widget.entry.value.length == 1 ? _singleParam() : _paramWithValues();

  Widget _singleParam() => Column(
        children: [
          _checkBoxRow(widget.entry.value.first, widget.entry.value.first),
          _dividerLine()
        ],
      );

  Widget _paramWithValues() => Column(
        children: [
          _mainCheckBox(),
          _dividerLine(),
          isExpanded ? _optionCheckBoxes() : Container(),
        ],
      );

  Widget _checkBoxRow(String title, dynamic value, {bool isOption = false}) {
    return Container(
      margin: isOption ? EdgeInsets.only(left: 15.w) : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _checkBoxTitle(title),
          _checkBox(value),
        ],
      ),
    );
  }

  Widget _checkBoxTitle(String title) => Text(
        title,
        style: TextStyle(
          color: primaryColor,
          fontSize: 18.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      );

  Widget _mainCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _checkBoxTitle(widget.entry.key),
        Row(
          children: [
            _arrowIcon(),
            _checkBox(widget.entry.value),
          ],
        ),
      ],
    );
  }

  Widget _arrowIcon() => GestureDetector(
        onTap: () => setState(() => isExpanded = !isExpanded),
        child: RotatedBox(
          quarterTurns: isExpanded ? 1 : 3,
          child:
              const Icon(Icons.arrow_back_ios_new_rounded, color: primaryColor),
        ),
      );

  Widget _optionCheckBoxes() => Column(
        children: List.generate(
          widget.entry.value.length,
          (index) => Column(
            children: [
              _checkBoxRow(widget.entry.value[index], widget.entry.value[index],
                  isOption: true),
              _dividerLine(),
            ],
          ),
        ),
      );

  Widget _dividerLine() => !widget.isLast
      ? Opacity(
          opacity: 0.50,
          child: Container(
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.5,
                  color: paleColor,
                ),
              ),
            ),
          ),
        )
      : Container();

  Widget _checkBox(dynamic value) => Obx(
        () => Checkbox(
          value: controller.checkValues(value),
          onChanged: (_) => controller.actionWithOption(value),
          activeColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      );
}

class OptionSelectorController extends GetxController {
  static OptionSelectorController get to => Get.find();

  RxList values = [].obs;

  List get getValues => values.toList();

  void setValues(List value) => values.assignAll(value);

  void actionWithOption(value) =>
      checkValues(value) ? _removeOption(value) : _addOption(value);

  bool checkValues(dynamic value) {
    if (value is List && value.isSubsetOf(values)) return true;
    if (values.contains(value)) return true;

    return false;
  }

  void _removeOption(value) {
    value is List
        ? values.removeWhere((v) => value.contains(v))
        : values.remove(value);
  }

  void _addOption(dynamic value) =>
      value is List ? values.addAll(value) : values.add(value);

  void applyAction(String category, MainOptionField field) =>
      FilterController.to
          .actionWithValue(values, category, field.type, field.field);

  void clearAction(String category, MainOptionField field) {
    values.clear();

    FilterController.to.clearField(category, field.type, field.field);
  }
}

class OptionSelectorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OptionSelectorController());
  }
}
