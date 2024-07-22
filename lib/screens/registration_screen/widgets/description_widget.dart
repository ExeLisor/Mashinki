import 'package:autoverse/exports.dart';

class RegistrationDescriptionWidget extends StatelessWidget {
  const RegistrationDescriptionWidget(
      {super.key, required this.text, this.height, this.width});
  final String text;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 36.h,
      width: width ?? 326.w,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13.fs, color: const Color(0xff4038FF)),
      ),
    );
  }
}
