import 'package:autoverse/exports.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) => Obx(
        () => Scaffold(
          appBar: _topBar(),
          body: CompareController.to.comparedCars.isEmpty ? _noCars() : _body(),
          bottomNavigationBar: HomeScreenBottomBarWidget(),
        ),
      );

  Widget _noCars() => Center(
        child: Text(
          "🔍🚫🚗",
          style: TextStyle(fontSize: 40.fs),
        ),
      );

  Widget _body() {
    ScrollController controller = ScrollController();

    return GetBuilder<CompareAppbarController>(
      initState: (state) => CompareAppbarController.to.startListen(controller),
      builder: (_) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: 25.h),
              child: _view(),
            ),
            FloatBar(
                controller: CompareAppbarController.to,
                offsetValue: 180.h,
                child: const CompareFloatingBar()),
          ],
        ),
      ),
    );
  }

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
        () => Padding(
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
            CompareController.to.comparedCars.length,
            (_) => CompareCarImage(car: CompareController.to.comparedCars[_]),
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
            specs: CompareController.to.comparedSpecifications[index],
          ),
        ),
      ),
    );
  }
}

class CompareFloatingBar extends StatelessWidget {
  const CompareFloatingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: 43.h,
      padding: EdgeInsets.only(left: 32.w),
      child: Row(
        children: [
          ...List.generate(
            CompareController.to.comparedCars.length,
            (index) {
              Car car = CompareController.to.comparedCars[index];
              String brandName = car.mark.name ?? "";
              String modelName = car.model.name ?? "";
              int? year = car.generation.yearStart;
              return _carTitle("$brandName $modelName ${year ?? ""}");
            },
          ),
        ],
      ),
    );
  }

  Widget _carTitle(String title) => Container(
        margin: EdgeInsets.only(right: 8.0.w),
        width: 177.w,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      );
}
