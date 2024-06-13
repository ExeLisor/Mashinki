import 'package:mashinki/exports.dart';

class RegistrationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  final TextEditingController userNameFieldController = TextEditingController();
  late final AnimationController animationController;

  final Duration tranistionDuration = const Duration(milliseconds: 500);
  final Curve animationCurve = Curves.easeInOut;

  String errorValidationMessage = "";
  bool isValidationComplete = false;
  bool isValidationError = false;

  @override
  void onInit() {
    super.onInit();
    initAnimationController();
  }

  void initAnimationController() => animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      );

  void goToPreviousPage() {
    final int currentPage = (pageController.page ?? 0).toInt();
    currentPage == 0
        ? Get.back()
        : pageController.animateToPage(currentPage - 1,
            duration: tranistionDuration, curve: animationCurve);
  }

  void goToNextPage() {
    final int currentPage = (pageController.page ?? 0).toInt();
    currentPage == 2
        ? null
        : pageController.animateToPage(currentPage + 1,
            duration: tranistionDuration, curve: animationCurve);
  }

  void clearErrorValidationMessage() => errorValidationMessage = "";

  void showCompleteAnimation() => isValidationComplete = true;
  void disableCompleteAnimation() => isValidationComplete = false;

  void showErrorAnimation() => isValidationError = true;
  void disableErrorAnimation() => isValidationError = false;

  void playAnimation() {
    animationController.reset();
    animationController.forward();
  }

  void disableAllAnimations() {
    disableCompleteAnimation();
    disableErrorAnimation();
    animationController.dispose();
  }

  Future<void> submitUserName() async {
    String userName = userNameFieldController.value.text;
    Duration completeDuration = const Duration(
      milliseconds: 1800,
    );
    Duration errorDuration = const Duration(
      milliseconds: 450,
    );

    String validationMessage = validateNickname(userName) ?? "";
    playAnimation();

    if (validationMessage.isEmpty) {
      clearErrorValidationMessage();
      showCompleteAnimation();
      update();
      await Future.delayed(completeDuration);
      goToNextPage();

      return;
    } else {
      disableCompleteAnimation();
      showErrorAnimation();
      update();
      await Future.delayed(errorDuration);
      errorValidationMessage = validationMessage;
      update();
    }
  }
}
