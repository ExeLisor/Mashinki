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

  Widget _inputPasswordField() => GetBuilder<RegistrationPasswordsContoller>(
        builder: (controller) => CustomTextField(
          hint: "Пароль",
          controller: controller.passwordFieldController,
          isPassword: true,
          showPassword: controller.isShowPassword,
          icon: lockAsset,
          suffixIcon: _showPasswordIcon(),
        ),
      );

  Widget _showPasswordIcon() => GetBuilder<RegistrationPasswordsContoller>(
        builder: (controller) => GestureDetector(
          onTap: controller.showPassword,
          child: const SvgIcon(
            assetPath: lineEye,
          ),
        ),
      );

  Widget _confirmPasswordField() => GetBuilder<RegistrationPasswordsContoller>(
        builder: (controller) => CustomTextField(
          hint: "Повторите пароль",
          controller: controller.confirmPasswordFieldController,
          isPassword: true,
          showPassword: controller.isShowConfirmPassword,
          icon: lockAsset,
          suffixIcon: _showConfirmPasswordIcon(),
        ),
      );

  Widget _showConfirmPasswordIcon() =>
      GetBuilder<RegistrationPasswordsContoller>(
        builder: (controller) => GestureDetector(
          onTap: controller.showConfirmPassword,
          child: const SvgIcon(
            assetPath: lineEye,
          ),
        ),
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
