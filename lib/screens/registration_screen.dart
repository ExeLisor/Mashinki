import 'package:mashinki/exports.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          color: Color(0xff4038FF),
        ),
      ),
      body: GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (_) => Stack(
          children: [_pages(), _dots()],
        ),
      ),
    );
  }

  Widget _pages() => GetBuilder<RegistrationController>(
        builder: (controller) => PageView(
          // physics: const NeverScrollableScrollPhysics(),
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

  Widget _createUsernameWidget() => Column(
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
          _nextButton("Далее")
        ],
      );

  Widget _pageIcon(String assetPath) => SvgPicture.asset(
        assetPath,
        height: 100.h,
        width: 100.h,
        color: const Color(0xff4038FF),
      );

  Widget _bigText(String text) => Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23.fs,
            color: const Color(0xff4038FF)),
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

  Widget _inputUsernameField() => CustomTextField(
        hint: "Имя пользователя",
        controller: TextEditingController(),
        isPassword: false,
        icon: accountAsset,
      );

  Widget _inputEmailField() => CustomTextField(
        hint: "Email",
        controller: TextEditingController(),
        isPassword: false,
        icon: emailAsset,
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

  Widget _inputEmailDescription() => _smallText(
      "Ваша почта будет использоваться для входа в аккаунт. Мы отправим вам код подстверждения электронного адреса",
      height: 72,
      width: 236);

  Widget _createPasswordDescription() => _smallText(
        "Мы можем запомнить пароль, чтобы вам больше не нужно было вводить его на ваших устройствах",
      );

  Widget _inputEmailWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _pageIcon(emailAsset),
          SizedBox(
            height: 40.h,
          ),
          _bigText("Введите почту"),
          SizedBox(
            height: 15.h,
          ),
          _inputEmailDescription(),
          SizedBox(
            height: 20.h,
          ),
          _inputEmailField(),
          SizedBox(
            height: 20.h,
          ),
          _nextButton("Отправить код")
        ],
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
          _nextButton("Далее")
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

  Widget _nextButton(String buttonText) => GetBuilder<RegistrationController>(
        builder: (controller) => GestureDetector(
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
        ),
      );
}
