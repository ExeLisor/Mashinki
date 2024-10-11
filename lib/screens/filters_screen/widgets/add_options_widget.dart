import 'package:autoverse/exports.dart';

class AddOptionsWidget extends StatelessWidget {
  const AddOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        const AddOptionsBloc(
          title: "Экстерьер",
        )
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
  const AddOptionsBloc({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        SizedBox(
          height: 20.h,
        ),
        _container(
            child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
          child: const Column(
            children: [
              AddOptionCheckBox(
                value: "Легкосплавные диски",
              ),
              AddOptionCheckBox(
                value: "Райлинги на крыше",
              ),
              AddOptionCheckBox(
                value: "Легкосплавные диски",
              )
            ],
          ),
        ))
      ],
    );
  }

  Widget _title() => Text(
        title,
        style: TextStyle(
          color: const Color(0xFF4038FF),
          fontSize: 14.fs,
          fontWeight: FontWeight.w500,
          height: 0.10,
        ),
      );

  Widget _container({required Widget child}) => Container(
      margin: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 0.h),
      padding: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffF5F4FF),
      ),
      child: child);
}

class AddOptionCheckBox extends StatefulWidget {
  const AddOptionCheckBox({super.key, required this.value});

  final String value;

  @override
  State<AddOptionCheckBox> createState() => _AddOptionCheckBoxState();
}

class _AddOptionCheckBoxState extends State<AddOptionCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_valueText(), _checkBox()],
    );
  }

  Widget _valueText() => Text(
        widget.value,
        style: TextStyle(
          color: const Color(0xFF4038FF),
          fontSize: 16.fs,
          fontWeight: FontWeight.w400,
          height: 0.08,
        ),
      );

  Widget _checkBox() => Checkbox(
        value: true,
        onChanged: (value) {},
        activeColor: const Color(0xFF4038FF),
        side: const BorderSide(color: Color(0xFF4038FF)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      );
}
