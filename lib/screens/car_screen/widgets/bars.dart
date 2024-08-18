import 'package:autoverse/exports.dart';

class CarsFloatBar extends StatelessWidget {
  const CarsFloatBar({super.key});

  @override
  Widget build(BuildContext context) => Obx(
        () => CarAppbarController.to.currentOffset > 350.h
            ? Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: Get.width,
                    color: Colors.white,
                    child: _floatingBar()),
              )
            : Container(),
      );

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
                fontFamily: 'Inter',
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
      ));

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
              Wrap(
                children: [
                  _iconFB(Icons.copy, Get.back),
                  _iconFB(Icons.heart_broken, Get.back),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
