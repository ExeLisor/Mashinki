import 'package:autoverse/exports.dart';

class DropSpecsBlockWidget extends StatefulWidget {
  const DropSpecsBlockWidget(
      {super.key, required this.title, required this.specs});

  final String title;
  final List specs;

  @override
  State<DropSpecsBlockWidget> createState() => _DropSpecsBlockWidgetState();
}

class _DropSpecsBlockWidgetState extends State<DropSpecsBlockWidget> {
  bool isOpened = true;

  void close() => setState(() => isOpened = false);

  void open() => setState(() => isOpened = true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isOpened ? close : open,
      child: Container(
        margin: EdgeInsets.only(bottom: 13.h),
        clipBehavior: Clip.antiAlias,
        decoration: _decoration(),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 21.h),
            child: isOpened ? _openedWidget() : _specWidget()),
      ),
    );
  }

  Widget _openedWidget() => Column(
        children: [
          _specWidget(),
          SizedBox(
            height: 20.h,
          ),
          ...widget.specs.map(
            (spec) => _specs(
              spec.keys.first,
              spec[spec.keys.first],
            ),
          ),
        ],
      );

  Widget _specWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              _blockTitle(),
              SizedBox(
                width: 10.w,
              ),
              _count(),
            ],
          ),
          _arrowIcon(),
        ],
      );

  Widget _specs(String specs, String value) => Padding(
        padding: EdgeInsets.only(right: 3.w, bottom: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF7974FF),
                    shape: OvalBorder(),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 265.w),
                  child: Text(
                    specs,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14.fs,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 30.w,
              child: Text(
                value,
                textAlign: TextAlign.right,
                softWrap: true, // разрешаем переносить текст
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.fs,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      );

  ShapeDecoration _decoration() => ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 15,
            offset: Offset(-1, 10),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 15,
            offset: Offset(1, 1),
            spreadRadius: 2,
          )
        ],
      );

  Widget _arrowIcon() => RotatedBox(
        quarterTurns: isOpened ? 1 : 3,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color(0xff848484),
        ),
      );

  Widget _blockTitle() => SizedBox(
        child: Text(
          widget.title,
          maxLines: 2,
          softWrap: true,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.fs,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _count() => Text(
        '${widget.specs.length} опций',
        style: TextStyle(
          color: const Color(0xFF848484),
          fontSize: 14.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      );
}

// class OptionsController extends GetxController{
//   static OptionsController get to => Get.find();

//   final RxBool isOpened
// }

// class OptionsBinging extends Bindings{
//   @override
//   void dependencies() => Get.lazyPut(()=> OptionsController());
// }

class SpecsBlockWidget extends StatelessWidget {
  const SpecsBlockWidget({super.key, required this.title, required this.specs});

  final String title;
  final List specs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _divider(),
        SizedBox(
          height: 20.h,
        ),
        _specsTitle(title),
        SizedBox(
          height: 20.h,
        ),
        ...specs.map(
          (spec) => _specsWidget(
            spec.keys.first,
            spec[spec.keys.first].toString(),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }

  Widget _divider() => Container(
        margin: EdgeInsets.only(right: 25.w),
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: paleColor,
            ),
          ),
        ),
      );

  Widget _specsTitle(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _specsWidget(String specs, String value) => Padding(
        padding: EdgeInsets.only(right: 25.w, bottom: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200.w,
              child: Text(
                '$specs:',
                maxLines: 2,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14.fs,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: 140.w,
              child: Text(
                checkStringOnEmptyOrZero(value),
                textAlign: TextAlign.right,
                softWrap: true, // разрешаем переносить текст
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.fs,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      );

  String checkStringOnEmptyOrZero(String value) {
    if (value.isEmpty) return "-";
    if (int.tryParse(value) == 0) return "-";
    if (double.tryParse(value) == 0) return "-";
    return value;
  }
}
