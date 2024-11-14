import 'package:autoverse/exports.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppThemeController.to.whiteColor,
        appBar: _appBar(),
        body: CompareController.to.comparedCars.isEmpty ? _noCars() : _body(),
        bottomNavigationBar: HomeScreenBottomBarWidget(),
      );
  AppBar _appBar() => AppBar(
        backgroundColor: AppThemeController.to.whiteColor,
        title: _appBarText(),
        leading: _iconBack(),
        centerTitle: true,
        actions: [_accountIcon(), SizedBox(width: 25.w)],
      );

  Widget _hideIdentical() => GestureDetector(
        onTap: CompareController.to.hideIdentical,
        child: Row(
          children: [
            Obx(
              () => SvgPicture.asset(CompareController.to.isHideIdentical
                  ? "assets/svg/checkbox_active.svg"
                  : "assets/svg/checkbox.svg"),
            ),
            SizedBox(width: 10.w),
            Text(
              'hide-simmilar-specifications'.tr,
              style: TextStyle(
                color: AppThemeController.to.textColor,
                fontSize: 12.fs,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Widget _appBarText() => Column(
        children: [
          Text(
            'comparison'.tr,
            style: TextStyle(
              color: AppThemeController.to.appBarItemsColor,
              fontSize: 20.fs,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          // Text(
          //   declineComparison(CompareController.to.comparedCars.length),
          //   style: TextStyle(
          //     color: const greyColor,
          //     fontSize: 14.fs,
          //     fontFamily: 'Inter',
          //     fontWeight: FontWeight.w400,
          //   ),
          // )
        ],
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
                color: AppThemeController.to.appBarItemsColor,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      );

  Widget _accountIcon() => SvgPicture.asset(
        "assets/svg/account_active.svg",
        height: 24.h,
        color: AppThemeController.to.appBarItemsColor,
        width: 24.w,
      );

  Widget _body() {
    ScrollController controller = ScrollController();

    return GetBuilder<CompareAppbarController>(
      initState: (state) => CompareAppbarController.to.startListen(controller),
      builder: (_) => Padding(
        padding: EdgeInsets.only(top: 27.0.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 25.h),
                child: _view(),
              ),
              FloatBar(
                  controller: CompareAppbarController.to,
                  offsetValue: 180.h,
                  child: const CompareFloatingBar()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _view() => Obx(
        () => Padding(
          padding: EdgeInsets.only(left: 25.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _images(),
              SizedBox(height: 15.h),
              _hideIdentical(),
              SizedBox(height: 15.h),
              _specsTitle(),
              _specs(),
            ],
          ),
        ),
      );

  Widget _specsTitle() => Text(
        'specifications'.tr,
        style: TextStyle(
          color: AppThemeController.to.isDarkTheme ? paleColor : primaryColor,
          fontSize: 18.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      );

  Widget _images() => Container(
        margin: EdgeInsets.only(right: 25.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            CompareController.to.comparedCars.length,
            (_) => CompareCarImage(car: CompareController.to.comparedCars[_]),
          ),
        ),
      );

  Widget _specs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        SpecificationType.values.length,
        (index) => Obx(
          () => CompareSpecsWidget(
            title: SpecificationType.values[index].name,
            specs: CompareController.to.comparedSpecifications[index],
          ),
        ),
      ),
    );
  }

  Widget _noCars() => Center(
        child: Text(
          "🔍🚫🚗",
          style: TextStyle(fontSize: 40.fs),
        ),
      );
}

class CompareFloatingBar extends StatelessWidget {
  const CompareFloatingBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Car> cars = CompareController.to.comparedCars;
    return Container(
      //max size container + padding between + padding left
      width: cars.length == 1 ? Get.width : (177.w + 8.w + 49.w) * cars.length,
      decoration: BoxDecoration(
        color: AppThemeController.to.whiteColor,
        border: const Border(bottom: BorderSide(color: paleColor)),
      ),
      height: 43.h,
      padding: EdgeInsets.only(left: 32.w),
      child: Row(
        children: [
          ...List.generate(
            cars.length,
            (index) {
              Car car = cars[index];
              String brandName = car.mark.name ?? "";
              String modelName = car.model.name ?? "";
              int? year = car.generation.yearStart;
              return _carTitle("$brandName $modelName ${year ?? ""}");
            },
          ),
        ],
      ),
    );
  }

  Widget _carTitle(String title) => Container(
        margin: EdgeInsets.only(right: 8.0.w),
        width: 177.w,
        child: Text(
          title,
          style: const TextStyle(
            color: blackColor,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      );
}
