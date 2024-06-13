import 'package:mashinki/exports.dart';

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
          color: const Color(0xff4038FF),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 15.fs,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
