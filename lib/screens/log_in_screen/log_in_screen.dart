import 'package:autoverse/exports.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: whiteColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 96),
          child: Column(
            children: [
              Image.asset(
                manImageAsset,
                height: 119,
                width: 119,
              ),
              const SizedBox(
                height: 45,
              ),
              CustomTextField(
                hint: "Имя пользователя",
                controller: _usernameController,
                isPassword: false,
                icon: accountAsset,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hint: "Пароль",
                controller: _passwordController,
                isPassword: true,
                icon: manIconAsset,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.only(left: 220),
                  child: Text(
                    "Забыли пароль?",
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              NextButton(onTap: () {}),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "У вас нету аккаунта? ",
                            style: TextStyle(color: primaryColor),
                          ),
                          Text(
                            "Зарегистрироваться",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
