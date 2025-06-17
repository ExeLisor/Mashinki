import 'package:autoverse/exports.dart';

class CharacteristicsWidget extends StatelessWidget {
  const CharacteristicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: AppThemeController.to.isDarkTheme
            ? const Color(0xff19191b)
            : whiteColor,
        width: Get.width,
        padding: EdgeInsets.only(left: 25.w, top: 20.h, bottom: 25.h),
        child: Obx(() {
          Modification modification = CarController.to.car.selectedModification;

          final CarSpecifications specs =
              modification.carSpecifications ?? CarSpecifications();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CarDemensions(),
                  SizedBox(width: 23.w),
                  _detailsColumnFirst(specs),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              _detailsRowFirst(specs),
              SizedBox(
                height: 10.h,
              ),
              _detailsRowSecond(specs),
              SizedBox(
                height: 30.h,
              ),
              SpecsBlockWidget(
                  title: "Основные характеристики".tr,
                  specs: _mainSpecs(specs)),
              SpecsBlockWidget(
                  title: "Характеристики двигателя".tr,
                  specs: _engineSpecs(specs)),
              SpecsBlockWidget(
                  title: "Подвеска и тормоза".tr,
                  specs: _transmissionSpecs(specs)),
              SpecsBlockWidget(
                  title: "Размеры и объёмы".tr, specs: _sizesSpecs(specs)),
              SpecsBlockWidget(
                  title: "Топливная система и расход".tr,
                  specs: _fuelSpecs(specs)),
              SpecsBlockWidget(
                  title: "Безопасность".tr, specs: _secutitySpecs(specs)),
              SpecsBlockWidget(
                  title: "Экология".tr, specs: _ecologySpecs(specs)),
              const OtherResourcesWiget(),
            ],
          );
        }),
      ),
    );
  }

  Widget _title() => const ModificationTitleWidget();

  Widget _detailsColumnFirst(CarSpecifications specs) => Column(
        children: [
          DetailsTile(
              spec: "Объём".tr,
              value: specs.volumeLitres.toString(),
              isSmall: true),
          SizedBox(height: 10.h),
          DetailsTile(
              spec: "Расход".tr,
              value: specs.consumptionMixed.toString(),
              isSmall: true),
        ],
      );

  Widget _detailsRowFirst(CarSpecifications specs) => Padding(
        padding: EdgeInsets.only(right: 25.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DetailsTile(spec: "Коробка".tr, value: specs.transmission?.tr),
            SizedBox(width: 19.w),
            DetailsTile(spec: "Тип двигателя".tr, value: specs.engineType?.tr),
            SizedBox(width: 19.w),
            DetailsTile(
                spec: "Топливо".tr, value: specs.petrolType?.tr, isSmall: true),
          ],
        ),
      );

  Widget _detailsRowSecond(CarSpecifications specs) => Padding(
        padding: EdgeInsets.only(right: 25.w),
        child: Row(
          children: [
            DetailsTile(spec: "Мощность", value: "${specs.horsePower}"),
            SizedBox(width: 19.w),
            DetailsTile(spec: "Привод".tr, value: specs.drive?.tr),
            SizedBox(width: 19.w),
          ],
        ),
      );

  Widget _divider() => const Divider(
        color: primaryColor,
      );

  List _mainSpecs(CarSpecifications specs) => [
        {"max-speed": specs.maxSpeed},
        {"time-to-100": specs.timeTo100},
        {"weight": specs.weight},
      ];

  List _engineSpecs(CarSpecifications specs) => [
        {"engine-type": specs.engineType},
        {"volume": specs.volume},
        {"horse-power": specs.horsePower},
        {"rpm-power": specs.rpmPower},
        {"moment": specs.moment},
        {"petrol-type": specs.petrolType},
        {"cylinders-order": specs.cylindersOrder},
        {"cylinders-value": specs.cylindersValue},
        {"diametr": specs.diametr},
        {"piston-stroke": specs.pistonStroke},
        {"compression": specs.compression},
        {"engine-feeding": specs.engineFeeding},
        {"engine-order": specs.engineOrder},
      ];

  List _transmissionSpecs(CarSpecifications specs) => [
        {"front-suspension": specs.frontSuspension},
        {"back-suspension": specs.backSuspension},
        {"front-brake": specs.frontBrake},
        {"back-brake": specs.backBrake},
      ];

  List _sizesSpecs(CarSpecifications specs) => [
        {"length": specs.length},
        {"height": specs.height},
        {"seats": specs.seats},
        {"wheel-base": specs.wheelBase},
        {"front-wheel-base": specs.frontWheelBase},
        {"back-wheel-base": specs.backWheelBase},
        {"wheel-size": specs.wheelSize},
        {"clearance": specs.clearance},
        {"trunks-min-capacity": specs.trunksMinCapacity},
        {"trunks-max-capacity": specs.trunksMaxCapacity},
      ];

  List _fuelSpecs(CarSpecifications specs) => [
        {"fuel-tank-volume": specs.volume},
        {"fuel-consumption-mixed": specs.consumptionMixed},
        {"fuel-consumption-city": specs.consumptionCity},
        {"fuel-consumption-hiway": specs.consumptionHiway},
        {"range-distance": specs.rangeDistance},
      ];

  List _secutitySpecs(CarSpecifications specs) => [
        {"safety-rating": specs.safetyRating},
        {"safety-grade": specs.safetyGrade},
      ];

  List _ecologySpecs(CarSpecifications specs) => [
        {"emission-euro-class": specs.emissionEuroClass},
        {"fuel-emission": specs.fuelEmission},
      ];
}

class ModificationTitleWidget extends StatelessWidget {
  const ModificationTitleWidget({super.key});

  @override
  Widget build(BuildContext context) => Obx(
        () {
          Modification modification = CarController.to.car.selectedModification;
          return modification.isLoaded &&
                  modification.carSpecifications?.complectationId != null
              ? _modificationTitle()
              : _loadingTitleWidget();
        },
      );

  Widget _modificationTitle() {
    Modification modification = CarController.to.car.selectedModification;
    CarSpecifications specification =
        modification.carSpecifications ?? CarSpecifications();
    String transmission = getTransmissionAbb(specification.transmission ?? "");

    int? power = specification.horsePower;
    double? volume = specification.volumeLitres;
    String privod = specification.drive == "полный" ? "4WD" : "";
    String title =
        "${"Модификация".tr} ${modification.groupName ?? ""}${volume == 0 ? "" : volume} $transmission ${power == 0 ? "" : power} $privod"
            .trim();

    if (specification.complectationId == null) title = "Базовая";
    return Container(
      margin: EdgeInsets.only(bottom: 40.h),
      child: Obx(
        () => Text(
          title,
          style: TextStyle(
            color:
                AppThemeController.to.isDarkTheme ? Colors.white : primaryColor,
            fontSize: 18.fs,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _loadingTitleWidget() => ShimmerWidget(
        child: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          height: 20.h,
          width: 180.w,
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      );
}

class CarDemensions extends StatelessWidget {
  const CarDemensions({super.key});

  @override
  Widget build(BuildContext context) => Obx(
        () {
          Modification modification = CarController.to.car.selectedModification;

          final CarSpecifications? specs = modification.carSpecifications;
          return modification.isLoaded && specs?.complectationId != null
              ? _carDemensions(specs!)
              : _loadingWidget();
        },
      );
  Widget _loadingWidget() => ShimmerWidget(
        child: Container(
          height: 120.h,
          width: 258.w,
          decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      );

  Widget _carDemensions(CarSpecifications specs) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [_carHeight(specs), SizedBox(width: 15.h), _carImage()],
          ),
          SizedBox(height: 15.h),
          _carLenght(specs)
        ],
      );

  Widget _carImage() {
    CarController carController = CarController.to;
    CarBodyType bodyType = CarBodyType.fromCyrillicName(
        carController.car.configuration.bodyType ?? "");

    return GestureDetector(
      onTap: () {
        log("assets/images/${bodyType.name}.svg");
      },
      child: SizedBox(
        width: 223.w,
        child: SvgPicture.asset(
          bodyType.assetPath,
          color: AppThemeController.to.isDarkTheme ? whiteColor : blackColor,
          clipBehavior: Clip.antiAlias,
          height: 80.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _carHeight(CarSpecifications specs) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _arrow(0),
          SizedBox(
            height: 8.h,
          ),
          _carImageSize(specs.height.toString()),
          SizedBox(
            height: 8.h,
          ),
          _arrow(180)
        ],
      );
  Widget _carLenght(CarSpecifications specs) => Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: Row(
          children: [
            _arrow(180, isShort: false),
            SizedBox(
              width: 8.w,
            ),
            _carImageSize(specs.length.toString(), isHeight: false),
            SizedBox(
              width: 8.w,
            ),
            _arrow(0, isShort: false)
          ],
        ),
      );

  Widget _arrow(double rotation, {bool isShort = true}) => RotationTransition(
        turns: AlwaysStoppedAnimation(rotation / 360),
        child: SvgPicture.asset(
          isShort ? shortArrow : longArrow,
          width: isShort ? null : 89.w,
          color: AppThemeController.to.isDarkTheme ? whiteColor : primaryColor,
        ),
      );

  Widget _carImageSize(String size, {bool isHeight = true}) => RotatedBox(
        quarterTurns: isHeight ? -1 : 0,
        child: Text(
          size,
          style: TextStyle(
            color:
                AppThemeController.to.isDarkTheme ? whiteColor : primaryColor,
            fontSize: 13.fs,
            fontWeight: FontWeight.w400,
            height: 0.0,
          ),
        ),
      );
}

class DetailsTile extends StatelessWidget {
  const DetailsTile(
      {super.key,
      required this.spec,
      required this.value,
      this.isSmall = false});

  final String spec;
  final String? value;
  final bool isSmall;

  @override
  Widget build(BuildContext context) => Obx(() {
        Modification modification = CarController.to.car.selectedModification;

        return modification.isLoaded && value != null && value != "null"
            ? _detailsTile()
            : _loadingWidget();
      });

  Widget _loadingWidget() => ShimmerWidget(
        child: _detailContainer(),
      );

  Widget _detailContainer({Widget? child}) => Container(
      padding: EdgeInsets.symmetric(horizontal: 11.h),
      height: 67.h,
      width: isSmall ? 80.w : 122.w,
      decoration: BoxDecoration(
        color: AppThemeController.to.isDarkTheme
            ? const Color(0xff292929)
            : boneColor,
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: child);

  Widget _detailsTile() => _detailContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 11.h),
            Text(
              spec,
              textAlign: TextAlign.center,
              textScaler: const TextScaler.linear(0.9),
              style: TextStyle(
                color: AppThemeController.to.isDarkTheme
                    ? paleColor
                    : primaryColor,
                fontSize: 13.fs,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              value == "0.0" || (value ?? "").isEmpty ? "-" : value ?? "",
              textScaler: const TextScaler.linear(0.85),
              style: TextStyle(
                color:
                    AppThemeController.to.isDarkTheme ? whiteColor : blackColor,
                fontSize: 14.fs,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
          ],
        ),
      );
}
