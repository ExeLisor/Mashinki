import 'package:autoverse/exports.dart';

class CharacteristicsWidget extends StatelessWidget {
  const CharacteristicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: Get.width,
      padding: EdgeInsets.only(left: 25.w, top: 20.h, bottom: 25.h),
      child: Obx(() {
        Modification modification = CarController.to.car.selectedModification;

        final CarSpecifications specs = modification.carSpecifications!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CarDemensions(),
                SizedBox(
                  width: 23.w,
                ),
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
                title: "Основные характеристики", specs: _mainSpecs(specs)),
            SpecsBlockWidget(
                title: "Характеристики двигателя", specs: _engineSpecs(specs)),
            SpecsBlockWidget(
                title: "Подвеска и тормоза", specs: _transmissionSpecs(specs)),
            SpecsBlockWidget(
                title: "Размеры и объёмы", specs: _sizesSpecs(specs)),
            SpecsBlockWidget(
                title: "Топливная система и расход", specs: _fuelSpecs(specs)),
            SpecsBlockWidget(
                title: "Безопасность", specs: _secutitySpecs(specs)),
            SpecsBlockWidget(title: "Экология", specs: _ecologySpecs(specs)),
            const OtherResourcesWiget(),
          ],
        );
      }),
    );
  }

  Widget _title() => const ModificationTitleWidget();

  Widget _detailsColumnFirst(CarSpecifications specs) => Column(
        children: [
          DetailsTile(
              spec: "Объём",
              value: specs.volumeLitres.toString(),
              isSmall: true),
          SizedBox(height: 10.h),
          DetailsTile(
              spec: "Расход",
              value: specs.consumptionMixed.toString(),
              isSmall: true),
        ],
      );

  Widget _detailsRowFirst(CarSpecifications specs) => Padding(
        padding: EdgeInsets.only(right: 25.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DetailsTile(spec: "Коробка", value: specs.transmission),
            SizedBox(width: 19.w),
            DetailsTile(spec: "Тип двигателя", value: specs.engineType),
            SizedBox(width: 19.w),
            DetailsTile(
                spec: "Топливо", value: specs.petrolType, isSmall: true),
          ],
        ),
      );

  Widget _detailsRowSecond(CarSpecifications specs) => Padding(
        padding: EdgeInsets.only(right: 25.w),
        child: Row(
          children: [
            DetailsTile(spec: "Мощность", value: "${specs.horsePower}"),
            SizedBox(width: 19.w),
            DetailsTile(spec: "Привод", value: specs.drive),
            SizedBox(width: 19.w),
          ],
        ),
      );

  Widget _divider() => const Divider(
        color: primaryColor,
      );

  List _mainSpecs(CarSpecifications specs) => [
        {"Максимальная скорость (км/ч)": specs.maxSpeed},
        {"Время разгона до 100 км/ч (с)": specs.timeTo100},
        {"Вес автомобиля (кг)": specs.weight},
      ];

  List _engineSpecs(CarSpecifications specs) => [
        {"Тип двигателя": specs.engineType},
        {"Объем двигателя (см³)": specs.volume},
        {"Мощность (л.с./кВт)": specs.horsePower},
        {"Максимальные обороты мощности (об/мин)": specs.rpmPower},
        {"Момент (Нм)": specs.moment},
        {"Тип топлива": specs.petrolType},
        {"Порядок цилиндров": specs.cylindersOrder},
        {"Число цилиндров": specs.cylindersValue},
        {"Диаметр цилиндра (мм)": specs.diametr},
        {"Ход поршня (мм)": specs.pistonStroke},
        {"Степень сжатия": specs.compression},
        {"Тип питания двигателя": specs.engineFeeding},
        {"Расположение двигателя": specs.engineOrder},
      ];

  List _transmissionSpecs(CarSpecifications specs) => [
        {"Тип передней подвески": specs.frontSuspension},
        {"Тип задней подвески": specs.backSuspension},
        {"Передние тормоза": specs.frontBrake},
        {"Задние тормоза": specs.backBrake},
      ];

  List _sizesSpecs(CarSpecifications specs) => [
        {"Длина (мм)": specs.length},
        {"Ширина (мм)": specs.weight},
        {"Высота (мм)": specs.height},
        {"Количество мест": specs.seats},
        {"Колесная база (мм)": specs.wheelBase},
        {"Передняя колея (мм)": specs.frontWheelBase},
        {"Задняя колея (мм)": specs.backWheelBase},
        {"Размеры колес": specs.wheelSize},
        {"Клиренс (мм)": specs.clearance},
        {"Вместимость багажника (мин.) (л)": specs.trunksMinCapacity},
        {"Вместимость багажника (макс.) (л)": specs.trunksMaxCapacity},
      ];

  List _fuelSpecs(CarSpecifications specs) => [
        {"Объем топливного бака (л)": specs.volume},
        {"Средний расход топлива (л/100 км)": specs.consumptionMixed},
        {"Расход топлива на трассе (л/100 км)": specs.consumptionCity},
        {"Расход топлива в городе (л/100 км)": specs.consumptionHiway},
        {"Запас хода (км)": specs.rangeDistance},
      ];

  List _secutitySpecs(CarSpecifications specs) => [
        {"Рейтинг безопасности": specs.safetyRating},
        {"Класс безопасности": specs.safetyGrade},
      ];

  List _ecologySpecs(CarSpecifications specs) => [
        {"Евро-класс": specs.emissionEuroClass},
        {"Выбросы СО2 (г/км)": specs.fuelEmission},
      ];
}

class ModificationTitleWidget extends StatelessWidget {
  const ModificationTitleWidget({super.key});

  @override
  Widget build(BuildContext context) => Obx(
        () {
          Modification modification = CarController.to.car.selectedModification;
          return modification.isLoaded
              ? _modificationTitle()
              : _loadingTitleWidget();
        },
      );

  Widget _modificationTitle() {
    Modification modification = CarController.to.car.selectedModification;
    CarSpecifications specification = modification.carSpecifications!;
    String transmission = getTransmissionAbb(specification.transmission);

    int? power = specification.horsePower;
    double? volume = specification.volumeLitres;
    String privod = specification.drive == "полный" ? "4WD" : "";
    String title =
        "${modification.groupName ?? ""} $volume $transmission $power $privod"
            .trim();
    return Container(
      margin: EdgeInsets.only(bottom: 40.h),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.fs,
          fontWeight: FontWeight.w600,
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
              color: Colors.white,
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

          final CarSpecifications specs = modification.carSpecifications!;
          return modification.isLoaded
              ? _carDemensions(specs)
              : _loadingWidget();
        },
      );
  Widget _loadingWidget() => ShimmerWidget(
        child: Container(
          height: 120.h,
          width: 258.w,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      );

  Widget _carDemensions(CarSpecifications specs) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _carHeight(specs),
              SizedBox(
                width: 15.h,
              ),
              _carImage()
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
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
        ),
      );

  Widget _carImageSize(String size, {bool isHeight = true}) => RotatedBox(
        quarterTurns: isHeight ? -1 : 0,
        child: Text(
          size,
          style: TextStyle(
            color: primaryColor,
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
  final String value;
  final bool isSmall;

  @override
  Widget build(BuildContext context) => Obx(() {
        Modification modification = CarController.to.car.selectedModification;

        return modification.isLoaded ? _detailsTile() : _loadingWidget();
      });

  Widget _loadingWidget() => ShimmerWidget(
        child: _detailContainer(),
      );

  Widget _detailContainer({Widget? child}) => Container(
      padding: EdgeInsets.symmetric(horizontal: 11.h),
      height: 67.h,
      width: isSmall ? 80.w : 122.w,
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: child);

  Widget _detailsTile() => _detailContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 11.h,
            ),
            Text(
              spec,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontSize: 13.fs,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              value,
              textScaler: const TextScaler.linear(0.85),
              style: TextStyle(
                color: Colors.black,
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
