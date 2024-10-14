import 'package:autoverse/exports.dart';

class MainOptionsRangeWidget extends StatelessWidget {
  const MainOptionsRangeWidget(
      {super.key, required this.title, required this.field});

  final String title;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_title(), SizedBox(height: 18.h), _rangeWidget()],
      ),
    );
  }

  Widget _title() => Container(
        margin: EdgeInsets.only(left: 9.w),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF4038FF),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 0.08,
          ),
        ),
      );

  Widget _rangeWidget() => Row(
        children: [
          _rangeContainer("От", isStart: true),
          Container(
            width: 10,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFF4038FF),
                ),
              ),
            ),
          ),
          _rangeContainer("До", isStart: false),
        ],
      );

  Widget _rangeContainer(String hintText, {required bool isStart}) => Container(
        height: 40.h,
        width: 160.w,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: primaryColor),
          color: Colors.transparent,
        ),
        child: TextField(
          onChanged: (input) => FilterController.to.actionWithValue(
            input,
            "mainOptions",
            "range",
            "$field${isStart ? "Start" : "End"}",
          ),
          autofocus: false,
          onTapOutside: (_) => FocusScope.of(Get.context!).unfocus(),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 16.fs,
              color: const Color(0xFF848484),
              fontWeight: FontWeight.w400,
              height: 0.08,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          textAlignVertical: TextAlignVertical.top,
        ),
      );
}
