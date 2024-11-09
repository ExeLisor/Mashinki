import 'package:autoverse/exports.dart';

class CompareSpecsWidget extends StatefulWidget {
  const CompareSpecsWidget(
      {super.key, required this.title, required this.specs});

  final String title;

  final List specs;

  @override
  State<CompareSpecsWidget> createState() => _CompareSpecsWidgetState();
}

class _CompareSpecsWidgetState extends State<CompareSpecsWidget> {
  final CompareController controller = CompareController.to;

  bool isOpened = true;

  void close() => setState(() => isOpened = false);

  void open() => setState(() => isOpened = true);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15.h,
        ),
        _title(),
        SizedBox(
          height: 5.h,
        ),
        isOpened ? _specs() : Container(),
      ],
    );
  }

  Widget _title() => GestureDetector(
        onTap: isOpened ? close : open,
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          width: Get.width - 50.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _specsTitle(widget.title),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: _line(),
              ),
              SizedBox(
                width: 20.w,
              ),
              _arrowIcon(),
            ],
          ),
        ),
      );

  Widget _line() => Opacity(
        opacity: 0.50,
        child: Container(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 0.5,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color(0xFF7974FF),
              ),
            ),
          ),
        ),
      );

  Widget _specs() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          widget.specs.length,
          (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                _specsName(
                  widget.specs[index].first["name"],
                ),
                SizedBox(
                  height: 5.h,
                ),
                _specsValues(index),
              ],
            );
          },
        ),
      );

  Widget _specsValues(int index) => Row(
        children: List.generate(
          CompareController.to.comparedCars.length,
          (carIndex) {
            CompareType compareType =
                widget.specs[index][carIndex]["compareType"];

            dynamic value = widget.specs[index][carIndex]["value"];

            List compareValue = widget.specs[index];

            if (compareType == CompareType.higher) {
              return _spec(
                  (value == 0 || value == 0.0) ? "-" : value.toString(),
                  isHighlighted: value == getMaxValue(compareValue));
            }

            return _spec(value.toString());
          },
        ),
      );

  Widget _arrowIcon() => RotatedBox(
        quarterTurns: isOpened ? 1 : 3,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Color(0xff848484),
        ),
      );

  Widget _specsName(String specsName) => Text(
        specsName,
        style: TextStyle(
          color: const Color(0xFF7974FF),
          fontSize: 12.fs,
          fontWeight: FontWeight.w400,
          fontFamily: 'Inter',
        ),
      );

  Widget _spec(String value, {bool isHighlighted = false}) => SizedBox(
        width: 185.w,
        child: Text(
          value.isEmpty ? "-" : value,
          style: TextStyle(
            color: isHighlighted ? Colors.green : Colors.black,
            fontSize: 14.fs,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      );

  Widget _specsTitle(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.fs,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      );
}
