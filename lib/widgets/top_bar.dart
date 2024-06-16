import 'package:mashinki/exports.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_logotype(), _title(), _accountIcon()],
    );
  }

  Widget _logotype() => Container(
        height: 32.h,
        width: 32.h,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      );

  Widget _title() => Text(
        title,
        style: TextStyle(
            fontSize: 20.fs, fontWeight: FontWeight.bold, color: primaryColor),
      );

  Widget _accountIcon() => Container(
        height: 32.h,
        width: 32.h,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Icon(
          Icons.account_circle_outlined,
          size: 32.h,
          color: primaryColor,
        ),
      );
}
