import 'package:autoverse/exports.dart';

import 'widgets/marks_filter_widget.dart';

void navigateToFiltersScreen() {
  Get.put(FiltersController());

  Get.toNamed('/filters');
}

class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeController.to.whiteColor,
      bottomNavigationBar: HomeScreenBottomBarWidget(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            _body(),
            _applyWidget(),
          ],
        ),
      ),
    );
  }

  Widget _body() => Column(
        children: [
          _appBar(),
          _filters(),
        ],
      );

  Widget _appBar() => Obx(
        () => AppBar(
          backgroundColor: AppThemeController.to.whiteColor,
          title: _appBarText(),
          leading: _iconBack(),
          centerTitle: true,
        ),
      );

  Widget _appBarText() => Text(
        'Фильтры'.tr,
        style: TextStyle(
          color:
              AppThemeController.to.isDarkTheme ? Colors.white : primaryColor,
          fontSize: 20.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _iconBack() => GestureDetector(
        onTap: Get.back,
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          child: Padding(
            padding: EdgeInsets.only(left: 4.0.w),
            child: SizedBox(
              child: SvgPicture.asset(
                "assets/svg/back.svg",
                color: primaryColor,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      );

  Widget _filters() => Expanded(
        child: ListView(
          padding: EdgeInsets.only(bottom: 25.h),
          children: const [
            MarksFilterWidget(),
            ModelSelectorWidget(),
            MainOptionsWidget(),
            AddOptionsWidget()
          ],
        ),
      );

  Widget _applyWidget() => false
      // ignore: dead_code
      ? Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 10.h),
            width: 165.w,
            height: 44.h,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: paleColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadows: const [
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
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Применить'.tr,
                  style: TextStyle(
                    color: AppThemeController.to.appBarItemsColor,
                    fontSize: 15.fs,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        )
      : Container();
}
