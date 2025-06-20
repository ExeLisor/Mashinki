import 'package:autoverse/exports.dart';

class TopBar extends StatelessWidget {
  const TopBar(
      {super.key,
      required this.title,
      this.isHomeScreen = false,
      this.subtitle = "",
      this.disableVerticalPadding = false,
      this.showShadow = false,
      this.showAccount = true});
  final bool isHomeScreen;
  final String title;
  final String subtitle;
  final bool disableVerticalPadding;
  final bool showShadow;
  final bool showAccount;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            color: AppThemeController.to.whiteColor,
            boxShadow: showShadow
                ? [
                    const BoxShadow(
                      color: boxShadowColor,
                      blurRadius: 13,
                      offset: Offset(0, -1),
                      spreadRadius: 0,
                    ),
                  ]
                : null),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              0.w, 15.h, 25.w, disableVerticalPadding ? 0.h : 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isHomeScreen
                  ? Container(
                      width: 32.h,
                    )
                  : _topBarIconBack(),
              _title(),
              showAccount
                  ? _accountIcon()
                  : SizedBox(
                      height: 32.h,
                      width: 32.h,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logotype() => Container(
        height: 32.h,
        width: 32.h,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: greyColor),
      );

  Widget _topBarIconBack() => GestureDetector(
        onTap: Get.back,
        child: Container(
          padding: EdgeInsets.fromLTRB(25.w, 16.h, 25.w, 16.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
          ),
          child: SvgPicture.asset(
            backIcon,
            color: primaryColor,
          ),
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
                    color: greyColor,
                    fontSize: 14.fs,
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
