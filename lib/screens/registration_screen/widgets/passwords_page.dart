import 'package:mashinki/exports.dart';

class RegistrationPasswordsPage extends StatelessWidget {
  const RegistrationPasswordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const RegistrationPageIconWidget(assetPath: lockAsset),
        SizedBox(
          height: 40.h,
        ),
        const RegistrationTitleWidget(text: "Придумайте пароль"),
        SizedBox(
          height: 15.h,
        ),
        _createPasswordDescription(),
        SizedBox(
          height: 20.h,
        ),
        _inputPasswordField(),
        SizedBox(
          height: 20.h,
        ),
        _confirmPasswordField(),
        SizedBox(
          height: 10.h,
        ),
        _savePasswordCheckBox(),
        SizedBox(
          height: 10.h,
        ),
        RegistrationNextPageButton(buttonText: "Далее", onTap: () {})
      ],
    );
  }

  Widget _createPasswordDescription() => const RegistrationDescriptionWidget(
        text:
            "Мы можем запомнить пароль, чтобы вам больше не нужно было вводить его на ваших устройствах",
      );

  Widget _inputPasswordField() => CustomTextField(
        hint: "Пароль",
        controller: TextEditingController(),
        isPassword: false,
        icon: lockAsset,
      );

  Widget _confirmPasswordField() => CustomTextField(
        hint: "Повторите пароль",
        controller: TextEditingController(),
        isPassword: false,
        icon: lockAsset,
      );

  Widget _savePasswordCheckBox() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.w,
          ),
          Checkbox(
            value: true,
            onChanged: (value) {},
            activeColor: const Color(0xFF4038FF),
            side: const BorderSide(color: Color(0xFF4038FF)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          Text(
            "Сохранить пароль",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.fs, color: const Color(0xff4038FF)),
          ),
        ],
      );
}
