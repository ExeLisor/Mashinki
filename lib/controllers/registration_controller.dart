import 'package:mashinki/exports.dart';

class RegistrationController extends GetxController {
  final PageController pageController = PageController();
  final TextEditingController userNameFieldController = TextEditingController();

  String errorValidationMessage = "";

  final Duration animationDuration = const Duration(milliseconds: 500);
  final Curve animationCurve = Curves.easeInOut;

  void goToPreviousPage() {
    final int currentPage = (pageController.page ?? 0).toInt();
    currentPage == 0
        ? Get.back()
        : pageController.animateToPage(currentPage - 1,
            duration: animationDuration, curve: animationCurve);
  }

  void goToNextPage() {
    final int currentPage = (pageController.page ?? 0).toInt();

    currentPage == 2
        ? null
        : pageController.animateToPage(currentPage + 1,
            duration: animationDuration, curve: animationCurve);
  }

  clearErrorValidationMessage() => errorValidationMessage = "";

  void submitUserName() {
    String userName = userNameFieldController.value.text;

    errorValidationMessage = validateNickname(userName) ?? "";

    update();

    if (errorValidationMessage.isEmpty) {
      clearErrorValidationMessage();
      goToNextPage();
      return;
    }
  }
}
