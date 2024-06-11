import 'package:mashinki/exports.dart';

class TextFieldController extends GetxController {
  var obscureText = true.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }
}
