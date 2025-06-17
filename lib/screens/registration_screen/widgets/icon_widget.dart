import 'package:autoverse/exports.dart';

class RegistrationPageIconWidget extends StatelessWidget {
  const RegistrationPageIconWidget({super.key, required this.assetPath});
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      height: 100.h,
      width: 100.h,
      color: primaryColor,
    );
  }
}
