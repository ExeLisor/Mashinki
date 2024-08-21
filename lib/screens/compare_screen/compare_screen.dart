import 'dart:ui';

import 'package:autoverse/exports.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  static final CompareController controller = CompareController.to;

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: appBar(), body: _body());

  Widget _body() => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topBar(),
            _view(),
          ],
        ),
      );

  Widget _topBar() => Obx(
        () => TopBar(
          title: "Сравнение",
          subtitle: declineComparison(CompareController.to.comparedCars.length),
          isHomeScreen: false,
        ),
      );

  Widget _view() => Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 25.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _images(),
                SizedBox(height: 22.h),
                _specsTitle(),
                _specs(),
              ],
            ),
          ),
        ),
      );

  Widget _specsTitle() => Text(
        'Характеристики',
        style: TextStyle(
          color: primaryColor,
          fontSize: 18.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      );

  Widget _images() => Row(
        children: List.generate(
          controller.comparedCars.length,
          (_) => CompareCarImage(car: controller.comparedCars[_]),
        ),
      );
  Widget _specs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        SpecificationType.values.length,
        (index) {
          return Obx(
            () => CompareSpecsWidget(
              title: SpecificationType.values[index].name,
              allSpecs: controller.getAllSpecifications(),
              specs: controller.comparedSpecifications[index],
            ),
          );
        },
      ),
    );
  }
}

class CompareSpecsWidget extends StatefulWidget {
  const CompareSpecsWidget(
      {super.key,
      required this.title,
      required this.allSpecs,
      required this.specs});

  final String title;

  final List<CarSpecifications> allSpecs;
  final List specs;

  @override
  State<CompareSpecsWidget> createState() => _CompareSpecsWidgetState();
}

class _CompareSpecsWidgetState extends State<CompareSpecsWidget> {
  final CompareController controller = CompareController.to;

  bool isOpened = true;

  void close() => setState(() => isOpened = false);

  void open() {
    setState(() => isOpened = true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25.h,
        ),
        _title(),
        SizedBox(
          height: 25.h,
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
              _arrowIcon(),
            ],
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
                _specsName(
                  widget.specs[index].first["name"],
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
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      );

  Widget _spec(String value, {bool isHighlighted = false}) => SizedBox(
        width: 185.w,
        child: Text(
          value.isEmpty ? "-" : value,
          style: TextStyle(
            color: isHighlighted ? Colors.green : Colors.black,
            fontSize: 14.fs,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
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
          height: 0.06,
        ),
      );
}

class CompareCarImage extends StatelessWidget {
  const CompareCarImage({super.key, required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) => _carColumn();

  Widget _carColumn() => Padding(
        padding: EdgeInsets.only(left: 8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _carImage(),
            SizedBox(
              height: 12.h,
            ),
            _carTitle()
          ],
        ),
      );

  Widget _carImage() => Container(
        width: 177.w,
        height: 129.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: "$baseUrl/image/${car.configuration.id}",
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            _removeCompare()
          ],
        ),
      );
  Widget _removeCompare() => Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () => CompareController.to.deleteFromCompare(car),
          child: Container(
            width: 28.h,
            height: 28.h,
            margin: EdgeInsets.all(9.h),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0x307C7C7C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23.h),
              ),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 40, sigmaY: 40, tileMode: TileMode.decal),
                child: Center(
                  child: SvgPicture.asset(
                    whiteCrossIcon,
                    height: 14.h,
                    width: 14.h,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _carTitle() {
    String brandName = car.mark.name ?? "";
    String modelName = car.model.name ?? "";
    int? year = car.generation.yearStart;

    return SizedBox(
      width: 177.w,
      child: Text(
        "$brandName $modelName ${year ?? ""}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      ),
    );
  }
}
