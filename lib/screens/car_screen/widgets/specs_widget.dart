import 'package:autoverse/exports.dart';

class CharacteristicsWidget extends StatelessWidget {
  const CharacteristicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: Get.width,
      padding: EdgeInsets.only(left: 25.w, top: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _modificationTitle(),
          SizedBox(
            height: 40.h,
          ),
          _carSizeWidget(),
        ],
      ),
    );
  }

  Widget _carSizeWidget() => Column(
        children: [
          Row(
            children: [_carHeight(), _carImage()],
          ),
          SizedBox(
            height: 15.h,
          ),
          _carWidth()
        ],
      );

  Widget _carImage() => Image.asset(
        carImage,
        color: Colors.black,
        height: 90.h,
        width: 223.w,
        fit: BoxFit.fill,
      );

  Widget _carHeight() => Column(
        children: [
          _arrow(0),
          SizedBox(
            height: 24.h,
          ),
          _carImageSize("1450"),
          SizedBox(
            height: 24.h,
          ),
          _arrow(180)
        ],
      );
  Widget _carWidth() => Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: Row(
          children: [
            _arrow(180, isShort: false),
            SizedBox(
              width: 24.w,
            ),
            _carImageSize("4915", isHeight: false),
            SizedBox(
              width: 24.w,
            ),
            _arrow(0, isShort: false)
          ],
        ),
      );

  Widget _carImageSize(String size, {bool isHeight = true}) =>
      RotationTransition(
        turns: AlwaysStoppedAnimation(isHeight ? 270 / 360 : 0),
        child: Text(
          size,
          style: TextStyle(
            color: primaryColor,
            fontSize: 13.fs,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0.12,
          ),
        ),
      );

  Widget _arrow(double rotation, {bool isShort = true}) => RotationTransition(
        turns: AlwaysStoppedAnimation(rotation / 360),
        child: SvgPicture.asset(
          isShort ? shortArrow : longArrow,
          width: isShort ? null : 74.w,
        ),
      );

  Widget _modificationTitle() => Text(
        'Модификация 2.0 CVT',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      );
}
