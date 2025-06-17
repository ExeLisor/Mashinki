import 'package:autoverse/exports.dart';

class RegistrationTitleWidget extends StatelessWidget {
  const RegistrationTitleWidget(
      {super.key, required this.text, this.height, this.width});
  final String text;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 23.fs, color: primaryColor),
      ),
    );
  }
}
