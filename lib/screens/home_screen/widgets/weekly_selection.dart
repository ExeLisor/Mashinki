import 'package:autoverse/exports.dart';

class WeeklySelectionWidget extends GetView<WeeklyCarsController> {
  const WeeklySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _weeklyTitle(),
            SizedBox(
              height: 15.h,
            ),
            _weeklyCarousel()
          ],
        ),
      ],
    );
  }

  Widget _weeklyTitle() => Obx(
        () => Padding(
          padding: EdgeInsets.only(left: 25.w),
          child: Text(
            'weekly-selection'.tr,
            style: TextStyle(
                color: AppThemeController.to.isDarkTheme
                    ? Colors.white
                    : primaryColor,
                fontSize: 16.fs,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600),
          ),
        ),
      );

  Widget _weeklyCarousel() => HomeShimmerWidget(
      shimmer: _weeklyWidgetLoadingShimmer(),
      successCondition: true,
      child: _weeklyPageView());

  Widget _weeklyPageView() => SizedBox(
        width: Get.width,
        height: 136.h,
        child: Obx(
            () => controller.cars.isNotEmpty ? _cars() : _emptyWeeklyWidget()),
      );

  Widget _cars() => Obx(() => PageView(
        controller: PageController(viewportFraction: 0.9, initialPage: 1),
        children: List.generate(controller.cars.length,
            (index) => WeeklyCarTile(car: controller.cars[index])),
      ));

  Widget _emptyWeeklyWidget() => PageView(
      controller: PageController(viewportFraction: 0.9, initialPage: 1),
      children: [_weeklyWidgetLoadingShimmer()]);

  Widget _weeklyWidgetLoadingShimmer() => ShimmerWidget(
        child: UnconstrainedBox(
          child: Container(
            width: 362.w,
            height: 136.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      );
}

class WeeklyCarTile extends StatelessWidget {
  const WeeklyCarTile({super.key, required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: 362.w,
        height: 136.h,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            _carImage(),
            _carNameText(),
          ],
        ),
      ),
    );
  }

//TO-DO Добавить паддинги
  Widget _carNameText() => Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          height: 27.h,
          padding: EdgeInsets.symmetric(horizontal: 11.w),
          decoration: ShapeDecoration(
            color: blackColor.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: IntrinsicWidth(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 11.w),
              child: Text(
                "${car.mark.name} ${car.model.name}",
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 14.fs,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );

  Widget _carImage() => GestureDetector(
        onTap: () => CarController.to.openCarPage(car, isLoadCar: true),
        child: SizedBox(
          width: 362.w,
          height: 136.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: ImageContainer(
              imageData: ImageData.photo(id: car.configuration.id ?? ""),
            ),
          ),
        ),
      );
}

class WeeklyCarsController extends GetxController {
  final RxList<Car> cars = <Car>[].obs;
  final RxList<String> ids = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    try {
      cars.value = await SupabaseController.to.getWeeklyCars();
    } catch (e) {
      logW(e);
      return;
    }
  }
}

class WeeklyCarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeeklyCarsController>(() => WeeklyCarsController());
  }
}
