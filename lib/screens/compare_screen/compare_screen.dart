import 'dart:ui';

import 'package:autoverse/exports.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  static final CompareController controller = CompareController.to;

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: _topBar(), body: _body());

  Widget _body() => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _view(),
          ],
        ),
      );

  PreferredSize _topBar() => PreferredSize(
        preferredSize: Size.fromHeight(82.h),
        child: Obx(
          () => TopBar(
            title: "Сравнение",
            subtitle:
                declineComparison(CompareController.to.comparedCars.length),
            isHomeScreen: false,
            disableVerticalPadding: true,
          ),
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
                SizedBox(height: 15.h),
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

  Widget _images() => Container(
        margin: EdgeInsets.only(right: 25.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            controller.comparedCars.length,
            (_) => CompareCarImage(car: controller.comparedCars[_]),
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
            specs: controller.comparedSpecifications[index],
          ),
        ),
      ),
    );
  }
}
