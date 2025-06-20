import 'package:autoverse/exports.dart';

class RegistrationNextPageButton extends StatelessWidget {
  const RegistrationNextPageButton(
      {super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 55.h,
        width: 342.w,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 15.fs,
                color: whiteColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class WhiteNextButton extends StatelessWidget {
  const WhiteNextButton(
      {super.key, required this.buttonText, required this.onTap});
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 55.h,
        width: 342.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: primaryColor)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 15.fs,
                color: primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
