import 'package:autoverse/exports.dart';

class LottieAnimationWidget extends StatelessWidget {
  const LottieAnimationWidget(
      {super.key,
      required this.animationAsset,
      required this.animationController});

  final String animationAsset;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.h),
      child: Lottie.asset(
        animationAsset,
        fit: BoxFit.cover,
        controller: animationController,
        onLoaded: (composition) {
          Get.find<RegistrationController>().animationController
            ..duration = composition.duration
            ..forward();
        },
      ),
    );
  }
}
