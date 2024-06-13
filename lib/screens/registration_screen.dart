import 'package:mashinki/exports.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: _iconBack()),
      body: GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (_) => Stack(
          children: [_pages(), _dots()],
        ),
      ),
    );
  }

  Widget _iconBack() => GetBuilder<RegistrationController>(
        builder: (controller) => GestureDetector(
          onTap: () => controller.goToPreviousPage(),
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff4038FF),
          ),
        ),
      );

  Widget _pages() => GetBuilder<RegistrationController>(
        builder: (controller) => PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: [
            _createUsernameWidget(),
            _inputEmailWidget(),
            _createPasswordWidget()
          ],
        ),
      );

  Widget _dots() => GetBuilder<RegistrationController>(
        builder: (controller) => Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0.h),
            child: SmoothPageIndicator(
              controller: controller.pageController,
              count: 3,
              effect: WormEffect(dotHeight: 12.h, dotWidth: 12.h),
            ),
          ),
        ),
      );

  Widget _createUsernameWidget() => GetBuilder<RegistrationController>(
        builder: (controller) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _pageIcon(accountAsset),
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
            _nextButton("Далее", controller.submitUserName),
          ],
        ),
      );

  Widget _errorText(String text) {
    return Row(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: SizedBox(
                width: 342.w,
                child: Text(
                  text,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 12.fs, color: const Color(0xffff4141)),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ],
    );
  }

  Widget _errorUsernameText() => GetBuilder<RegistrationController>(
        builder: (controller) {
          return controller.errorValidationMessage == ""
              ? Container()
              : _errorText(controller.errorValidationMessage);
        },
      );

  Widget _errorEmailText() => GetBuilder<EmailController>(
        builder: (controller) {
          return controller.errorValidationMessage == ""
              ? Container()
              : _errorText(controller.errorValidationMessage);
        },
      );

  Widget _pageIcon(String assetPath) => SvgPicture.asset(
        assetPath,
        height: 100.h,
        width: 100.h,
        color: const Color(0xff4038FF),
      );

  Widget _bigText(String text, {double? height, double? width}) => SizedBox(
        height: height,
        width: width,
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23.fs,
              color: const Color(0xff4038FF)),
        ),
      );

  Widget _smallText(
    String text, {
    double height = 36,
    double width = 326,
  }) =>
      SizedBox(
        height: height.h,
        width: width.w,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.fs, color: const Color(0xff4038FF)),
        ),
      );
  Widget _createNicknameText() => Column(
        children: [
          _bigText("Создание имени"),
          _bigText("пользователя"),
        ],
      );

  Widget _createNickNameDescritpion() => _smallText(
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

  Widget _emailPageDescription() => GetBuilder<EmailController>(
      builder: (controller) => controller.isWaitingForCode
          ? _inputCodeDescription()
          : _inputEmailDescription());

  Widget _emailPageTitle() => GetBuilder<EmailController>(
        builder: (controller) => controller.isWaitingForCode
            ? _bigText("Подтвердите адрес электронной почты",
                height: 65.h, width: 236.w)
            : _bigText("Введите почту"),
      );

  Widget _inputEmailDescription() => _smallText(
      "Ваша почта будет использоваться для входа в аккаунт. Мы отправим вам код подстверждения электронного адреса",
      height: 72,
      width: 236);

  Widget _inputCodeDescription() => _smallText(
        "Введите код, который мы отправили вам на почту",
      );

  Widget _createPasswordDescription() => _smallText(
        "Мы можем запомнить пароль, чтобы вам больше не нужно было вводить его на ваших устройствах",
      );

  Widget _inputEmailWidget() => GetBuilder<EmailController>(
        builder: (controller) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _pageIcon(emailAsset),
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
            _nextButton("Отправить код", controller.submitEmail)
          ],
        ),
      );

  Widget _createPasswordWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _pageIcon(lockAsset),
          SizedBox(
            height: 40.h,
          ),
          _bigText("Придумайте пароль"),
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
          _nextButton("Далее", () {})
        ],
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

  Widget _nextButton(String buttonText, VoidCallback onTap) => GestureDetector(
        onTap: () => onTap(),
        child: Container(
          height: 55.h,
          width: 342.w,
          decoration: BoxDecoration(
            color: const Color(0xff4038FF),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 15.fs,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
}

class LottieAnimationWidget extends StatelessWidget {
  const LottieAnimationWidget(
      {super.key,
      required this.animationAsset,
      required this.animationController});

  final String animationAsset;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.h),
      child: Lottie.asset(
        animationAsset,
        fit: BoxFit.cover,
        controller: animationController,
        onLoaded: (composition) {
          Get.find<RegistrationController>().animationController
            ..duration = composition.duration
            ..forward();
        },
      ),
    );
  }
}
