import 'package:mashinki/exports.dart';

class RegistrationEmailPage extends StatelessWidget {
  const RegistrationEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailController>(
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const RegistrationPageIconWidget(assetPath: emailAsset),
          SizedBox(
            height: 40.h,
          ),
          _emailPageTitle(),
          SizedBox(
            height: 15.h,
          ),
          _emailPageDescription(),
          SizedBox(
            height: 20.h,
          ),
          _inputEmailField(),
          SizedBox(
            height: 20.h,
          ),
          _errorEmailText(),
          RegistrationNextPageButton(
              buttonText: "Отправить код", onTap: controller.submitEmail)
        ],
      ),
    );
  }

  Widget _emailPageTitle() => GetBuilder<EmailController>(
        builder: (controller) => controller.isWaitingForCode
            ? RegistrationTitleWidget(
                text: "Подтвердите адрес электронной почты",
                height: 65.h,
                width: 236.w)
            : const RegistrationTitleWidget(text: "Введите почту"),
      );

  Widget _emailPageDescription() => GetBuilder<EmailController>(
      builder: (controller) => controller.isWaitingForCode
          ? _inputCodeDescription()
          : _inputEmailDescription());

  Widget _inputEmailDescription() => const RegistrationDescriptionWidget(
      text:
          "Ваша почта будет использоваться для входа в аккаунт. Мы отправим вам код подстверждения электронного адреса",
      height: 72,
      width: 236);

  Widget _inputCodeDescription() => const RegistrationDescriptionWidget(
        text: "Введите код, который мы отправили вам на почту",
      );

  Widget _inputEmailField() => GetBuilder<EmailController>(
        builder: (controller) => CustomTextField(
          hint: "Email",
          controller: controller.emailFieldController,
          onFieldSubmitted: (String text) => controller.submitEmail(),
          isPassword: false,
          suffixIcon: _inputEmailFieldAnimation(),
          icon: emailAsset,
        ),
      );

  Widget _inputEmailFieldAnimation() => GetBuilder<EmailController>(
        builder: (controller) {
          if (controller.isValidationComplete) {
            return LottieAnimationWidget(
              animationAsset: correctAnimation,
              animationController: controller.emailAnimationController,
            );
          } else if (controller.isValidationError) {
            return LottieAnimationWidget(
              animationAsset: deniedAnimation,
              animationController: controller.emailAnimationController,
            );
          }

          return Container();
        },
      );

  Widget _errorEmailText() => GetBuilder<EmailController>(
        builder: (controller) {
          return controller.errorValidationMessage == ""
              ? Container()
              : RegistrationErrorWidget(
                  text: controller.errorValidationMessage);
        },
      );
}
