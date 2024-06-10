import 'package:mashinki/exports.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA3C5F4),
      ),
      body: const WelcomeWidget(),
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_backGroundImage(), _welcomeText(), _authButtons()],
    );
  }

  Widget _authButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _createNewAccountButton(),
              const SizedBox(
                height: 15,
              ),
              _loginButton(),
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
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  color: Colors.white),
            ),
            Text(
              "AutoVerse",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 52,
                color: Color(0xFF4038FF),
              ),
            ),
            Text(
              "Выберите автомобиль\nподходящий именно вам",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white),
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

  Widget _createNewAccountButton() => GestureDetector(
        child: Container(
          width: 342,
          height: 70,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                "Создать новый аккаунт",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF4038FF),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _loginButton() => GestureDetector(
        child: Container(
          width: 342,
          height: 70,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                "Войти в существующий аккаунт",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF4038FF),
                ),
              ),
            ),
          ),
        ),
      );
}
