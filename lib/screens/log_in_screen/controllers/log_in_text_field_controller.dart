import 'package:autoverse/exports.dart';

class TextFieldController extends GetxController {
  var obscureText = false.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }
}
