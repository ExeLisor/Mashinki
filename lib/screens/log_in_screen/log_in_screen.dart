import 'package:mashinki/exports.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        body: Column(
      children: [
        Image.asset(
          manImageAsset,
          height: 119,
          width: 119,
        ),
        CustomTextField(
          hint: "Имя пользователя",
          controller: _usernameController,
          isPassword: false,
          icon: manIconAsset,
        )
      ],
    ));
  }
}
