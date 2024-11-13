import 'package:autoverse/exports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA3C5F4),
      ),
      body: Stack(
        children: [_backGroundImage(), _welcomeText(), _authButtons()],
      ),
    );
  }

  Widget _authButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _welcomeScreenButton(
                "Создать новый аккаунт",
                () => Get.to(() => const RegistrationScreen()),
              ),
              const SizedBox(
                height: 15,
              ),
              _welcomeScreenButton(
                "Войти в существующий аккаунт",
                () => Get.to(() => const AuthScreen()),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ],
      );

  Widget _welcomeText() => const Padding(
        padding: EdgeInsets.only(left: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Добро пожаловать в",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 28, color: whiteColor),
            ),
            Text(
              "AutoVerse",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 52,
                color: primaryColor,
              ),
            ),
            Text(
              "Выберите автомобиль\nподходящий именно вам",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16, color: whiteColor),
            ),
          ],
        ),
      );

  Widget _backGroundImage() => Stack(
        children: [
          Container(
            height: 213,
            width: 412,
            decoration: const BoxDecoration(
              color: Color(0xFFA3C5F4),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                image: AssetImage(welcomeImageAsset),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      );

  Widget _welcomeScreenButton(String? buttonText, Function()? func) =>
      GestureDetector(
        onTap: func,
        child: Container(
          width: 342,
          height: 70,
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                buttonText ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      );
}
