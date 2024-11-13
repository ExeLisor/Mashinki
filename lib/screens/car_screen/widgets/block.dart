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
  int count = 0;

  void close() => setState(() => isOpened = false);

  void open() => setState(() => isOpened = true);

  @override
  void initState() {
    super.initState();
    bool hasOptions = hasValidOption();
    countOptions();
    if (!hasOptions) close();
  }

  bool hasValidOption() =>
      widget.specs.any((option) => option.values.any((value) => value != "❌"));

  int countOptions() {
    int validCount = 0;

    for (var spec in widget.specs) {
      for (var value in spec.values) {
        if (value != "❌") {
          validCount++;
        }
      }
    }

    setState(() => count = validCount);
    return validCount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SettingsDivider(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: GestureDetector(
              onTap: isOpened ? close : open,
              child: isOpened ? _openedWidget() : _specWidget()),
        ),
        const SettingsDivider(),
      ],
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
              SizedBox(width: 10.w),
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
                _dot(),
                SizedBox(width: 8.w),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 265.w),
                  child: Text(
                    specs.tr,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14.fs,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              ],
            ),
            _icon(value != "❌"),
          ],
        ),
      );

  Widget _icon(bool value) => Center(
      child:
          SvgPicture.asset("assets/svg/${value ? "check_big" : "close"}.svg"));

  Widget _dot() => Container(
        width: 8.h,
        height: 8.h,
        decoration: const ShapeDecoration(
          color: paleColor,
          shape: OvalBorder(),
        ),
      );

  Widget _arrowIcon() => RotatedBox(
        quarterTurns: isOpened ? 1 : 3,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: greyColor,
        ),
      );

  Widget _blockTitle() => SizedBox(
        child: Text(
          widget.title.tr,
          maxLines: 2,
          softWrap: true,
          style: TextStyle(
            color: blackColor,
            fontFamily: "Inter",
            fontSize: 18.fs,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _count() => Text(
        '$count ${"options-rp".tr}',
        style: TextStyle(
          color: greyColor,
          fontSize: 14.fs,
          fontFamily: "Inter",
          fontWeight: FontWeight.w400,
        ),
      );
}

class SpecsBlockWidget extends StatelessWidget {
  const SpecsBlockWidget({super.key, required this.title, required this.specs});

  final String title;
  final List specs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsDivider(),
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
          color: blackColor,
          fontSize: 18.fs,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _specsWidget(String specs, String value) => Obx(() {
        Modification modification = CarController.to.car.selectedModification;

        return Padding(
          padding: EdgeInsets.only(right: 25.w, bottom: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200.w,
                child: Text(
                  '${specs.tr}:',
                  maxLines: 2,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14.fs,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              modification.isLoaded
                  ? SizedBox(
                      width: 140.w,
                      child: Text(
                        checkStringOnEmptyOrZero(value).tr,
                        textAlign: TextAlign.right,
                        softWrap: true, // разрешаем переносить текст
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14.fs,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : _loadingWidget()
            ],
          ),
        );
      });

  Widget _loadingWidget() => ShimmerWidget(
        child: Container(
          height: 24.h,
          width: 80.w,
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(8)),
        ),
      );

  String checkStringOnEmptyOrZero(String value) {
    if (value.isEmpty) return "-";
    if (int.tryParse(value) == 0) return "-";
    if (double.tryParse(value) == 0) return "-";
    return value;
  }
}
