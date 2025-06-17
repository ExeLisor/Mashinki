import 'package:autoverse/exports.dart';

class CarsCatalogListWidget extends GetView<CarCatalogController> {
  const CarsCatalogListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
              SizedBox(height: 15.h),
              Obx(
                () => controller.cars.isNotEmpty ? _carsList() : _carsEmpty(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _carsEmpty() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: ShimmerWidget(child: _catalogTileContainer()),
      );

  Widget _catalogTileContainer() => Obx(
        () => Container(
          height: 169.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                AppThemeController.to.isDarkTheme ? Colors.black : Colors.white,
            boxShadow: [
              BoxShadow(
                color: boxShadowColor,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 5.h), // changes position of shadow
              ),
            ],
          ),
        ),
      );

  Widget _title() => Obx(
        () => Padding(
          padding: EdgeInsets.only(left: 25.0.w),
          child: Text(
            "cars".tr,
            style: TextStyle(
                fontSize: 16.fs,
                fontFamily: "Inter",
                color: AppThemeController.to.isDarkTheme
                    ? Colors.white
                    : primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      );

  Widget _carsList() => ListView(
        padding: EdgeInsets.only(bottom: 25.h, left: 25.w, right: 25.w),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(controller.cars.length,
            (index) => CatalogTile(car: controller.cars[index])),
      );
}

class CatalogTile extends StatelessWidget {
  const CatalogTile({super.key, required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: _decoration(),
        child: Column(
          children: [_carImage(), SizedBox(height: 11.h), _carInfo()],
        ),
      ),
    );
  }

  Widget _carImage() => Stack(
        children: [
          GestureDetector(
            onTap: () => CarController.to.openCarPage(car, isLoadCar: true),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: Container(
                height: 225.h,
                width: 363.w,
                color: blackColor,
                child: ImageContainer(
                  borderRaduis: 0,
                  imageData: ImageData.photo(id: car.configuration.id ?? ""),
                ),
              ),
            ),
          ),
          _iconsRow()
        ],
      );
  Widget _iconsRow() => Padding(
        padding: EdgeInsets.only(right: 15.0.w, top: 13.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _addToCompare(),
            SizedBox(
              width: 10.w,
            ),
            _addToFavorite()
          ],
        ),
      );
  Widget _addToFavorite() => Obx(() => _icon(
      "favorite",
      "favorite_active",
      FavoriteController.to.isCarFavorite(car),
      () => FavoriteController.to.addToFavorite(car)));
  Widget _addToCompare() => Obx(() => _icon(
      "comp",
      "comp_active",
      CompareController.to.isCarCompared(car),
      () => CompareController.to.compareAction(car)));

  Widget _icon(String icon, String activeIcon, bool condition,
          VoidCallback action) =>
      GestureDetector(
        onTap: action,
        child: Container(
          width: 32.h,
          height: 32.h,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: blackColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/svg/${condition ? activeIcon : icon}.svg",
            ),
          ),
        ),
      );

  Widget _carInfo() => Padding(
        padding: EdgeInsets.fromLTRB(17.0.w, 0.h, 17.w, 17.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_carName(), _carYear()],
        ),
      );

  Widget _carName() => Obx(
        () => SizedBox(
          width: 200.w,
          child: Text(
            "${car.mark.name} ${car.model.name}",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20.fs,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
                color: AppThemeController.to.isDarkTheme
                    ? whiteColor
                    : blackColor),
          ),
        ),
      );

  Widget _carYear() => Obx(
        () => Text(
          "${car.generation.yearStart}",
          style: TextStyle(
              fontSize: 20.fs,
              fontFamily: "Inter",
              fontWeight: FontWeight.w300,
              color:
                  AppThemeController.to.isDarkTheme ? whiteColor : blackColor),
        ),
      );

  ShapeDecoration _decoration() => ShapeDecoration(
        color: AppThemeController.to.isDarkTheme
            ? const Color(0xFF292929)
            : whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        shadows: const [
          BoxShadow(
            color: boxShadowColor,
            blurRadius: 15,
            offset: Offset(-1, 10),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: boxShadowColor,
            blurRadius: 15,
            offset: Offset(1, 1),
            spreadRadius: 2,
          )
        ],
      );
}

class CarCatalogController extends GetxController {
  final RxList<Car> _cars = <Car>[].obs;

  List<Car> get cars => _cars;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    try {
      _cars.value = await SupabaseController.to.getCatalogCars();
    } catch (e) {
      logW(e);
      return;
    }
  }
}

class CarCatalogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CarCatalogController());
  }
}
