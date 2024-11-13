import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/filters_screen/models/add_options/add_options.dart';
import 'package:autoverse/screens/filters_screen/models/main_options/main_options_list.dart';

class AddOptionsWidget extends StatelessWidget {
  const AddOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        ...options.entries
            .map((e) => AddOptionsBloc(title: e.key, field: e.value)),
      ],
    );
  }

  Widget _title() => Container(
        margin: EdgeInsets.only(bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Дополнительные параметры',
              style: TextStyle(
                color: primaryColor,
                fontSize: 14.fs,
                fontWeight: FontWeight.w600,
                height: 0.10,
              ),
            )
          ],
        ),
      );
}

class AddOptionsBloc extends StatelessWidget {
  const AddOptionsBloc({super.key, required this.title, required this.field});

  final String title;
  final List<MainOptionField> field;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _title(),
        const SizedBox(height: 20),
        _container(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: _generateCheckboxes(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _title() => Text(
        title,
        style: const TextStyle(
          color: primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 0.10,
        ),
      );

  Widget _container({required Widget child}) => Container(
      margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
      padding: EdgeInsets.only(bottom: 7.h, top: 7.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: boneColor,
      ),
      child: child);

  List<Widget> _generateCheckboxes() => List.generate(
        field.length,
        (index) => AddOptionCheckBox(
          field: field[index],
          isLast: index == field.length - 1,
        ),
      );
}

class AddOptionCheckBox extends StatelessWidget {
  const AddOptionCheckBox({
    super.key,
    required this.field,
    this.isLast = false,
  });

  final MainOptionField field;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _valueText(),
            _checkBox(),
          ],
        ),
        SizedBox(height: 6.h),
        !isLast ? _dividerLine() : Container(),
      ],
    );
  }

  Widget _dividerLine() => Opacity(
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
      );

  Widget _valueText() => SizedBox(
        width: 240.w,
        child: Text(
          field.title,
          maxLines: 2,
          style: TextStyle(
            color: primaryColor,
            fontSize: 16.fs,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  Widget _checkBox() => Obx(
        () => Checkbox(
          value: FilterController.to.filter["addOptions"][field.field] ?? false,
          onChanged: changeValue,
          activeColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      );

  void changeValue(bool? value) => FilterController.to
      .actionWithValue(value, "addOptions", field.type, field.field);
}
