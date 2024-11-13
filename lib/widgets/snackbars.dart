import 'package:autoverse/exports.dart';

void showSnackBar(String text) => Get.showSnackbar(commonSnackbar(text));

GetSnackBar commonSnackbar(String text) => GetSnackBar(
      onTap: (_) => Get.closeCurrentSnackbar(),
      titleText: Center(
        child: Text(
          text,
          style: TextStyle(
            color: whiteColor,
            fontSize: 15.fs,
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
      boxShadows: const [
        BoxShadow(
          color: boxShadowColor,
          blurRadius: 15,
          offset: Offset(-1, 10),
          spreadRadius: 2,
        ),
        BoxShadow(
          color: boxShadowColor,
          blurRadius: 15,
          offset: Offset(1, 1),
          spreadRadius: 2,
        )
      ],
      borderRadius: 15.w,
      backgroundColor: paleColor,
      messageText: Container(),
      maxWidth: 250.w,
      duration: const Duration(milliseconds: 1500),
      padding: EdgeInsets.symmetric(horizontal: 19.h, vertical: 13.w),
      margin: EdgeInsets.fromLTRB(0.w, 0, 0.w, 80.h),
    );
