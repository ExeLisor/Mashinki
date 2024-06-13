import 'package:mashinki/exports.dart';

class RegistrationPageIconWidget extends StatelessWidget {
  const RegistrationPageIconWidget({super.key, required this.assetPath});
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      height: 100.h,
      width: 100.h,
      color: const Color(0xff4038FF),
    );
  }
}
