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
            ? Align(
                alignment: Alignment.topCenter,
                child: Container(color: Colors.white, child: child),
              )
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
                color: primaryColor,
                fontSize: 18.fs,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      );

  Widget _iconFB(IconData icon, VoidCallback callBack) => IconButton(
        onPressed: callBack,
        icon: Icon(
          icon,
          color: primaryColor,
          size: 24.h,
        ),
      );

  Widget _iconSvg(String icon, VoidCallback callBack) => GestureDetector(
        onTap: callBack,
        child: SvgPicture.asset(
          icon,
          height: 24.h,
          width: 24.h,
          color: primaryColor,
        ),
      );

  Widget _floatingBar() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
                  _iconFB(Icons.arrow_back_ios_new_rounded, Get.back),
                  _titleFB(),
                ],
              ),
              Row(
                children: [
                  _iconFB(Icons.copy, Get.back),
                  _iconSvg(favoriteIcon, Get.back),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
