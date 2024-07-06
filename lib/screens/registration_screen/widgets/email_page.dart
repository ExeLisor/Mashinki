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
          controller.isWaitingForCode
              ? _inputEmailStepWidgets()
              : _inputCodeStepWidgets()
        ],
      ),
    );
  }

  Widget _inputEmailStepWidgets() => GetBuilder<EmailController>(
        builder: (controller) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _codeField(),
            SizedBox(
              height: 20.h,
            ),
            _errorEmailText(),
            controller.startTime == 0
                ? RegistrationNextPageButton(
                    buttonText: "Отправить код", onTap: controller.submitEmail)
                : WhiteNextButton(
                    buttonText: "Отправить ещё раз (${controller.startTime})",
                    onTap: () {})
          ],
        ),
      );

  Widget _inputCodeStepWidgets() => GetBuilder<EmailController>(
        builder: (controller) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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

  Widget _codeField() => GetBuilder<EmailController>(
        builder: (controller) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: PinCodeTextField(
            length: 6,
            onCompleted: controller.submitCode,
            appContext: Get.context!,
            keyboardType: TextInputType.number,
            autoFocus: true,
            showCursor: false,
            textStyle: TextStyle(
                color: const Color(0xff4038FF),
                fontSize: 27.h,
                fontWeight: FontWeight.normal),
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(15),
                fieldHeight: 55.h,
                fieldWidth: 55.h,
                borderWidth: 1.h,
                activeFillColor: Colors.white,
                activeColor: const Color(0xff4038FF),
                selectedColor: const Color(0xff4038FF),
                inactiveColor: const Color(0xff4038FF)),
            animationDuration: const Duration(milliseconds: 300),
          ),
        ),
      );
}
