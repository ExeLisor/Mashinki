import 'package:autoverse/exports.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.title, this.isHomeScreen = false});
  final bool isHomeScreen;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 15.h, 0, 25.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isHomeScreen
              ? Container(
                  width: 32.h,
                )
              : _topBarIconBack(),
          _title(),
          _accountIcon()
        ],
      ),
    );
  }

  Widget _logotype() => Container(
        height: 32.h,
        width: 32.h,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      );

  Widget _topBarIconBack() => GestureDetector(
        onTap: Get.back,
        child: Icon(
          Icons.arrow_back_ios_new_sharp,
          size: 24.h,
          color: primaryColor,
        ),
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
