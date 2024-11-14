import 'package:autoverse/exports.dart';

abstract class FloatingBarController extends GetxController {
  RxDouble get currentOffset;
}

class FloatBar extends StatelessWidget {
  const FloatBar(
      {super.key,
      required this.child,
      required this.controller,
      this.offsetValue});

  final Widget child;
  final FloatingBarController controller;
  final double? offsetValue;

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.currentOffset.value > (offsetValue ?? 350.h)
            ? Obx(() => Align(
                alignment: Alignment.topCenter,
                child: Container(
                    color: AppThemeController.to.whiteColor, child: child)))
            : Container(),
      );
}

class CarsFloatBar extends StatelessWidget {
  const CarsFloatBar({super.key});

  @override
  Widget build(BuildContext context) => _floatingBar();

  Widget _titleFB() => Obx(
        () {
          final String brandName = CarController.to.car.mark.name ?? "";
          final String modelName = CarController.to.car.model.name ?? "";
          final String generationName =
              CarController.to.car.generation.name ?? "";
          return SizedBox(
            width: 220.w,
            child: Text(
              "$brandName $modelName $generationName",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppThemeController.to.isDarkTheme
                    ? Colors.white
                    : primaryColor,
                fontSize: 18.fs,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      );

  Widget _iconSvg(
          {required String icon,
          String? activeIcon,
          required VoidCallback callBack,
          bool? condition = false,
          bool? highlight = false}) =>
      Padding(
        padding: EdgeInsets.all(14.h),
        child: GestureDetector(
          onTap: callBack,
          child: SvgPicture.asset(
            condition ?? false ? activeIcon ?? "" : icon,
            height: 24.h,
            width: 24.h,
            color:
                (condition == false && highlight == true) ? primaryColor : null,
          ),
        ),
      );

  Widget _addToCompareIcon() => _iconSvg(
      icon: "assets/svg/comp.svg",
      activeIcon: "assets/svg/comp_active.svg",
      condition: CompareController.to.isCarCompared(CarController.to.car),
      highlight: true,
      callBack: _addToCompare);

  void _addToCompare() =>
      CompareController.to.addToCompare(CarController.to.car);

  Widget _addToFavIcon() => Obx(() => _iconSvg(
      icon: "assets/svg/favorite_blue.svg",
      activeIcon: "assets/svg/favorite_active.svg",
      condition: FavoriteController.to.isCarFavorite(CarController.to.car),
      callBack: _addToFavorite));

  void _addToFavorite() =>
      FavoriteController.to.addToFavorite(CarController.to.car);

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

  Widget _floatingBar() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: AppThemeController.to.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  _iconBack(),
                  SizedBox(width: 20.w),
                  _titleFB(),
                ],
              ),
              Row(
                children: [
                  _addToCompareIcon(),
                  _addToFavIcon(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
