import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/filters_screen/models/exterior_elements/exterior_elements.dart';

class AddOptionsWidget extends StatelessWidget {
  const AddOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        // AddOptionsBloc(
        //   title: "Элементы экстерьера",
        //   exteriorElementsJson:
        //       FilterController.to.getFilterModel.exteriorElements.toJson(),
        // )
      ],
    );
  }

  Widget _title() => Container(
        margin: EdgeInsets.only(bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Дополнительные параметры',
              style: TextStyle(
                color: const Color(0xFF4038FF),
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
  const AddOptionsBloc(
      {super.key, required this.title, required this.exteriorElementsJson});

  final String title;
  final Map<String, dynamic> exteriorElementsJson;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          color: Color(0xFF4038FF),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 0.10,
        ),
      );

  Widget _container({required Widget child}) => Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      padding: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffF5F4FF),
      ),
      child: child);

  List<Widget> _generateCheckboxes() {
    return ExteriorElements.localizedFieldNames.entries.map((entry) {
      final fieldName = entry.key;
      final localizedName = entry.value;
      final isChecked = exteriorElementsJson[fieldName] as bool? ?? false;

      return AddOptionCheckBox(
        value: localizedName,
        isChecked: isChecked,
        onChanged: (value) {
          // log("$value, addOptions, checkbox, $fieldName");
          // log(FilterController.to.jsonModel);
          var test = {};
          log(test);
          log(test["asdsa"]);
          test[fieldName] = value;
          log(test);
        },
      );
    }).toList();
  }
}

class AddOptionCheckBox extends StatelessWidget {
  const AddOptionCheckBox({
    super.key,
    required this.value,
    required this.isChecked,
    required this.onChanged,
  });

  final String value;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_valueText(), _checkBox()],
    );
  }

  Widget _valueText() => Text(
        value,
        style: const TextStyle(
          color: Color(0xFF4038FF),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 0.08,
        ),
      );

  Widget _checkBox() => Checkbox(
        value: isChecked,
        onChanged: onChanged,
        activeColor: const Color(0xFF4038FF),
        side: const BorderSide(color: Color(0xFF4038FF)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      );
}
