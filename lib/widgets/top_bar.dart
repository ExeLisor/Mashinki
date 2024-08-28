import 'package:autoverse/exports.dart';

class TopBar extends StatelessWidget {
  const TopBar(
      {super.key,
      required this.title,
      this.isHomeScreen = false,
      this.subtitle = "",
      this.disableVerticalPadding = false,
      this.showShadow = false});
  final bool isHomeScreen;
  final String title;
  final String subtitle;
  final bool disableVerticalPadding;
  final bool showShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: showShadow
              ? [
                  const BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 13,
                    offset: Offset(0, -1),
                    spreadRadius: 0,
                  ),
                ]
              : null),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            20.w, 15.h, 25.w, disableVerticalPadding ? 0.h : 20.h),
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

  Widget _title() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20.fs,
                fontWeight: FontWeight.bold,
                color: primaryColor),
          ),
          Container(
            height: 3.h,
          ),
          subtitle.isNotEmpty
              ? Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color(0xFF848484),
                    fontSize: 14.fs,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                )
              : Container(),
        ],
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
