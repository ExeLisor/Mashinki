import 'package:autoverse/exports.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: _iconBack()),
      body: GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (_) => Stack(
          children: [_pages(), _dots()],
        ),
      ),
    );
  }

  Widget _pages() => GetBuilder<RegistrationController>(
        builder: (controller) => PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: const [
            RegistrationUsernamePage(),
            RegistrationEmailPage(),
            RegistrationPasswordsPage()
          ],
        ),
      );

  Widget _dots() => GetBuilder<RegistrationController>(
        builder: (controller) => Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.0.h),
            child: SmoothPageIndicator(
              controller: controller.pageController,
              count: 3,
              effect: WormEffect(dotHeight: 12.h, dotWidth: 12.h),
            ),
          ),
        ),
      );

  Widget _iconBack() => GetBuilder<RegistrationController>(
        builder: (controller) => GestureDetector(
          onTap: () => controller.goToPreviousPage(),
          child: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
        ),
      );
}
