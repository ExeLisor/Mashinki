import 'package:mashinki/exports.dart';

class RegistrationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  final TextEditingController userNameFieldController = TextEditingController();
  late final AnimationController animationController;

  final Duration tranistionDuration = const Duration(milliseconds: 500);

  final Duration completeDuration = const Duration(
    milliseconds: 1800,
  );
  final Duration errorDuration = const Duration(
    milliseconds: 450,
  );

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
    bool toPreviousPage = specificActionForPage(currentPage);
    currentPage == 0 || !toPreviousPage
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

  bool specificActionForPage(int currentPage) {
    EmailController emailController = Get.find<EmailController>();
    switch (currentPage) {
      case 1:
        if (emailController.isWaitingForCode) {
          Get.find<EmailController>().backToInputEmail();
          return false;
        }
        return true;

      default:
        return true;
    }
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

  Future<void> submitUserName() async {
    String userName = userNameFieldController.value.text;

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

class EmailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final TextEditingController emailFieldController = TextEditingController();
  late final AnimationController emailAnimationController;

  String errorValidationMessage = "";

  bool isValidationComplete = false;
  bool isValidationError = false;
  bool isWaitingForCode = false;

  int startTime = 60;

  Timer? _timer;

  final Duration completeDuration = const Duration(
    milliseconds: 1800,
  );
  final Duration submitDuration = const Duration(
    milliseconds: 1800,
  );
  final Duration errorDuration = const Duration(
    milliseconds: 450,
  );

  @override
  void onInit() {
    super.onInit();
    initAnimationController();
  }

  void initAnimationController() =>
      emailAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );

  void playAnimation() {
    emailAnimationController.reset();
    emailAnimationController.forward();
  }

  void clearErrorValidationMessage() => errorValidationMessage = "";

  void showCompleteAnimation() => isValidationComplete = true;
  void disableCompleteAnimation() => isValidationComplete = false;

  void showErrorAnimation() => isValidationError = true;
  void disableErrorAnimation() => isValidationError = false;

  Future<void> submitEmail() async {
    String email = emailFieldController.value.text;

    String validationMessage = validateEmail(email) ?? "";

    startTime = 60;

    playAnimation();

    if (validationMessage.isEmpty) {
      clearErrorValidationMessage();
      showCompleteAnimation();
      update();
      await Future.delayed(submitDuration);
      sendCode();
      update();
    } else {
      disableCompleteAnimation();
      showErrorAnimation();
      update();
      await Future.delayed(completeDuration);
      errorValidationMessage = validationMessage;
      update();
    }
  }

  void submitCode() {}

  void sendCode() {
    startTimer();
    isWaitingForCode = true;
    update();
  }

  void backToInputEmail() => {isWaitingForCode = false, update()};

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (startTime == 0) {
          _timer!.cancel();
          update();
        } else {
          startTime--;
          update();
        }
      },
    );
  }
}
