import 'package:mashinki/exports.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          _accountIcon(),
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
          CustomTextField(
            hint: "Имя пользователя",
            controller: TextEditingController(),
            isPassword: false,
            icon: manIconAsset,
          ),
          SizedBox(
            height: 20.h,
          ),
          _nextButton()
        ],
      );

  Widget _accountIcon() => Icon(
        Icons.account_circle_outlined,
        size: 100.h,
        color: const Color(0xff4038FF),
      );

  Widget _createNicknameText() => Column(
        children: [
          Text(
            "Создание имени",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.fs,
                color: const Color(0xff4038FF)),
          ),
          Text(
            "пользователя",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23.fs,
                color: const Color(0xff4038FF)),
          ),
        ],
      );

  Widget _createNickNameDescritpion() => SizedBox(
        height: 36.h,
        width: 326.w,
        child: Text(
          "Выберите имя пользователя для своего нового аккаунта. Вы всегда можете изменить его.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.fs, color: const Color(0xff4038FF)),
        ),
      );
  Widget _inputEmailWidget() => Container();
  Widget _createPasswordWidget() => Container();

  Widget _nextButton() => GetBuilder<RegistrationController>(
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
                "Далее",
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
