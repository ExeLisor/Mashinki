import 'package:get/get.dart';

class TextFieldController extends GetxController {
  var obscureText = true.obs; 

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }
}