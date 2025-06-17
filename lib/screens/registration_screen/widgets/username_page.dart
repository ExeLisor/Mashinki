import 'package:autoverse/exports.dart';

class RegistrationUsernamePage extends StatelessWidget {
  const RegistrationUsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const RegistrationPageIconWidget(assetPath: accountAsset),
          SizedBox(
            height: 40.h,
          ),
          _createNicknameText(),
          SizedBox(
            height: 15.h,
          ),
          _createNickNameDescritpion(),
          SizedBox(
            height: 20.h,
          ),
          _inputUsernameField(),
          SizedBox(
            height: 20.h,
          ),
          _errorUsernameText(),
          RegistrationNextPageButton(
              buttonText: "Далее", onTap: controller.submitUserName),
        ],
      ),
    );
  }

  Widget _createNicknameText() => const Column(
        children: [
          RegistrationTitleWidget(text: "Создание имени"),
          RegistrationTitleWidget(
            text: ("пользователя"),
          ),
        ],
      );

  Widget _createNickNameDescritpion() => const RegistrationDescriptionWidget(
        text:
            "Выберите имя пользователя для своего нового аккаунта. Вы всегда можете изменить его.",
      );

  Widget _inputUsernameField() => GetBuilder<RegistrationController>(
        builder: (controller) => CustomTextField(
          hint: "Имя пользователя",
          controller: controller.userNameFieldController,
          onFieldSubmitted: (String text) => controller.submitUserName(),
          isPassword: false,
          suffixIcon: _inputUsernameFieldAnimation(),
          icon: accountAsset,
        ),
      );

  Widget _inputUsernameFieldAnimation() => GetBuilder<RegistrationController>(
        builder: (controller) {
          if (controller.isValidationComplete) {
            return LottieAnimationWidget(
              animationAsset: correctAnimation,
              animationController: controller.animationController,
            );
          } else if (controller.isValidationError) {
            return LottieAnimationWidget(
              animationAsset: deniedAnimation,
              animationController: controller.animationController,
            );
          }

          return Container();
        },
      );

  Widget _errorUsernameText() => GetBuilder<RegistrationController>(
        builder: (controller) {
          return controller.errorValidationMessage == ""
              ? Container()
              : RegistrationErrorWidget(
                  text: controller.errorValidationMessage);
        },
      );
}
