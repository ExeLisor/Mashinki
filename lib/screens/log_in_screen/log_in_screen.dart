import 'package:mashinki/exports.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 96),
            child: Column(
              children: [
                Image.asset(
                  manImageAsset,
                  height: 119.h,
                  width: 119.w,
                ),
                SizedBox(
                  height: 45.h,
                ),
                CustomTextField(
                  hint: "Имя пользователя",
                  controller: _usernameController,
                  isPassword: false,
                  icon: manIconAsset,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                  hint: "Пароль",
                  controller: _passwordController,
                  isPassword: true,
                  icon: lockIconAsset,
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(left: 220.w),
                    child: const Text(
                      "Забыли пароль?",
                      style: TextStyle(color: Color(0xff4038FF)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                NextButton(onTap: () {}),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30.h),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "У вас нету аккаунта? ",
                              style: TextStyle(color: Color(0xff4038FF)),
                            ),
                            Text(
                              "Зарегистрироваться",
                              style: TextStyle(
                                color: Color(0xff4038FF),
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
        ));
  }
}
