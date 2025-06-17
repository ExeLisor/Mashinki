import 'package:autoverse/exports.dart';

class OtherResourcesWiget extends StatelessWidget {
  const OtherResourcesWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _otherResourcesText(),
        SizedBox(
          height: 20.h,
        ),
        _otherResourcesRow(),
      ],
    );
  }

  Widget _otherResourcesText() => Text(
        'other-resources'.tr,
        style: TextStyle(
          color: AppThemeController.to.isDarkTheme ? Colors.white : blackColor,
          fontSize: 18.fs,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _otherResourcesRow() => Container(
        width: 362.w,
        decoration: BoxDecoration(
          color: AppThemeController.to.isDarkTheme
              ? const Color(0xff292929)
              : boneColor,
          borderRadius: BorderRadius.circular(43.h),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.0.w, vertical: 9.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _resourceIcon(youtubeImage, ResourceType.youtube),
              _resourceIcon(googleImage, ResourceType.google),
              _resourceIcon(pinterestImage, ResourceType.pinterest),
              _resourceIcon(tiktokImage, ResourceType.tiktok)
            ],
          ),
        ),
      );
  Widget _resourceIcon(String iconPath, ResourceType type) => GestureDetector(
        onTap: () async => openResource(type),
        child: SvgPicture.asset(
          iconPath,
          height: 45.h,
          width: 45.h,
        ),
      );
}
