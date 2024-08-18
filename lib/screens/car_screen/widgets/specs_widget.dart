import 'package:autoverse/exports.dart';

class CharacteristicsWidget extends StatelessWidget {
  CharacteristicsWidget({super.key});

  final CarSpecifications specs =
      CarController.to.car.selectedModification!.carSpecifications!;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: Get.width,
      padding: EdgeInsets.only(left: 25.w, top: 30.h, bottom: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _modificationTitle(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _carSizeWidget(),
              SizedBox(
                width: 23.w,
              ),
              _detailsColumnFirst(),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          _detailsRowFirst(),
          SizedBox(
            height: 10.h,
          ),
          _detailsRowSecond(),
          SizedBox(
            height: 30.h,
          ),
          SpecsBlockWidget(
              title: "Основные характеристики", specs: _mainSpecs()),
          SpecsBlockWidget(
              title: "Характеристики двигателя", specs: _engineSpecs()),
          SpecsBlockWidget(
              title: "Подвеска и тормоза", specs: _transmissionSpecs()),
          SpecsBlockWidget(title: "Размеры и объёмы", specs: _sizesSpecs()),
          SpecsBlockWidget(
              title: "Топливная система и расход", specs: _fuelSpecs()),
          SpecsBlockWidget(title: "Безопасность", specs: _secutitySpecs()),
          SpecsBlockWidget(title: "Экология", specs: _ecologySpecs()),
          SizedBox(
            height: 20.h,
          ),
          _divider(),
          SizedBox(
            height: 20.h,
          ),
          const OtherResourcesWiget(),
        ],
      ),
    );
  }

  Widget _detailsColumnFirst() => Column(
        children: [
          _detailsTile("Объём", getValue(specs.volumeLitres), isSmall: true),
          SizedBox(
            height: 10.h,
          ),
          _detailsTile("Расход", getValue(specs.consumptionMixed),
              isSmall: true),
        ],
      );

  Widget _detailsRowFirst() => Padding(
        padding: EdgeInsets.only(right: 25.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _detailsTile("Коробка", specs.transmission),
            SizedBox(
              width: 19.w,
            ),
            _detailsTile("Тип двигателя", specs.engineType),
            SizedBox(
              width: 19.w,
            ),
            _detailsTile("Топливо", specs.petrolType, isSmall: true),
          ],
        ),
      );

  Widget _detailsRowSecond() => Padding(
        padding: EdgeInsets.only(right: 25.w),
        child: Row(
          children: [
            _detailsTile("Мощность", "${double.parse(specs.horsePower)}"),
            SizedBox(
              width: 19.w,
            ),
            _detailsTile("Привод", specs.drive),
            SizedBox(
              width: 19.w,
            ),
          ],
        ),
      );

  Widget _carSizeWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [_carHeight(), _carImage()],
          ),
          SizedBox(
            height: 15.h,
          ),
          _carLenght()
        ],
      );

  Widget _carImage() => Image.asset(
        carImage,
        color: Colors.black,
        height: 90.h,
        width: 223.w,
        fit: BoxFit.fill,
      );

  Widget _carHeight() => Column(
        children: [
          _arrow(0),
          SizedBox(
            height: 24.h,
          ),
          _carImageSize(specs.height),
          SizedBox(
            height: 24.h,
          ),
          _arrow(180)
        ],
      );
  Widget _carLenght() => Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: Row(
          children: [
            _arrow(180, isShort: false),
            SizedBox(
              width: 24.w,
            ),
            _carImageSize(specs.length, isHeight: false),
            SizedBox(
              width: 24.w,
            ),
            _arrow(0, isShort: false)
          ],
        ),
      );

  Widget _carImageSize(String size, {bool isHeight = true}) =>
      RotationTransition(
        turns: AlwaysStoppedAnimation(isHeight ? 270 / 360 : 0),
        child: Text(
          size,
          style: TextStyle(
            color: primaryColor,
            fontSize: 13.fs,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0.12,
          ),
        ),
      );

  Widget _arrow(double rotation, {bool isShort = true}) => RotationTransition(
        turns: AlwaysStoppedAnimation(rotation / 360),
        child: SvgPicture.asset(
          isShort ? shortArrow : longArrow,
          width: isShort ? null : 74.w,
        ),
      );

  Widget _modificationTitle() {
    Modification modification =
        CarController.to.car.selectedModification ?? Modification();
    CarSpecifications specification = modification.carSpecifications!;
    String transmission = getTransmissionAbb(specification.transmission);

    double? power = double.tryParse(specification.horsePower);
    double? volume = double.tryParse(specification.volumeLitres);
    String privod = specification.drive == "полный" ? "4WD" : "";
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      child: Text(
        "${modification.groupName ?? ""} ${volume ?? ""} $transmission ${power ?? ""} $privod",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _detailsTile(String spec, String value, {bool isSmall = false}) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 11.h),
        height: 67.h,
        width: isSmall ? 80.w : 122.w,
        decoration: BoxDecoration(
          color: const Color(0xffF3F3F3),
          borderRadius: BorderRadius.circular(20.h),
        ),
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
                fontFamily: 'Inter',
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
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 11.h,
            ),
          ],
        ),
      );

  Widget _divider() => const Divider(
        color: primaryColor,
      );

  String transmissionAbbriviature(String transmission) {
    switch (transmission) {
      case "вариатор":
        return "CVT";

      default:
        return "";
    }
  }

  String getValue(String value) {
    if (value.isEmpty) return "-";
    if (RegExp(r'\d').hasMatch(value)) {
      try {
        String newValue = "${double.parse(value)}";
        return newValue;
      } catch (e) {
        return value;
      }
    }
    return value;
  }

  List _mainSpecs() => [
        {"Максимальная скорость (км/ч)": getValue(specs.maxSpeed)},
        {"Время разгона до 100 км/ч (с)": getValue(specs.timeTo100)},
        {"Вес автомобиля (кг)": getValue(specs.weight)},
      ];

  List _engineSpecs() => [
        {"Тип двигателя": getValue(specs.engineType)},
        {"Объем двигателя (см³)": getValue(specs.volume)},
        {"Мощность (л.с./кВт)": getValue(specs.horsePower)},
        {"Максимальные обороты мощности (об/мин)": getValue(specs.rpmPower)},
        {"Момент (Нм)": getValue(specs.moment)},
        {"Тип топлива": getValue(specs.petrolType)},
        {"Порядок цилиндров": getValue(specs.cylindersOrder)},
        {"Число цилиндров": getValue(specs.cylindersValue)},
        {"Диаметр цилиндра (мм)": getValue(specs.diametr)},
        {"Ход поршня (мм)": getValue(specs.pistonStroke)},
        {"Степень сжатия": getValue(specs.compression)},
        {"Тип питания двигателя": getValue(specs.engineFeeding)},
        {"Расположение двигателя": getValue(specs.engineOrder)},
      ];

  List _transmissionSpecs() => [
        {"Тип передней подвески": getValue(specs.frontSuspension)},
        {"Тип задней подвески": getValue(specs.backSuspension)},
        {"Передние тормоза": getValue(specs.frontBrake)},
        {"Задние тормоза": getValue(specs.backBrake)},
      ];

  List _sizesSpecs() => [
        {"Длина (мм)": getValue(specs.length)},
        {"Ширина (мм)": getValue(specs.weight)},
        {"Высота (мм)": getValue(specs.height)},
        {"Количество мест": getValue(specs.seats)},
        {"Колесная база (мм)": getValue(specs.wheelBase)},
        {"Передняя колея (мм)": getValue(specs.frontWheelBase)},
        {"Задняя колея (мм)": getValue(specs.backWheelBase)},
        {"Размеры колес": getValue(specs.wheelSize)},
        {"Клиренс (мм)": getValue(specs.clearance)},
        {"Вместимость багажника (мин.) (л)": getValue(specs.trunksMinCapacity)},
        {
          "Вместимость багажника (макс.) (л)": getValue(specs.trunksMaxCapacity)
        },
      ];

  List _fuelSpecs() => [
        {"Объем топливного бака (л)": getValue(specs.volume)},
        {"Средний расход топлива (л/100 км)": getValue(specs.consumptionMixed)},
        {
          "Расход топлива на трассе (л/100 км)": getValue(specs.consumptionCity)
        },
        {
          "Расход топлива в городе (л/100 км)": getValue(specs.consumptionHiway)
        },
        {"Запас хода (км)": getValue(specs.rangeDistance)},
      ];

  List _secutitySpecs() => [
        {"Рейтинг безопасности": getValue(specs.safetyRating)},
        {"Класс безопасности": getValue(specs.safetyGrade)},
      ];

  List _ecologySpecs() => [
        {"Евро-класс": getValue(specs.emissionEuroClass)},
        {"Выбросы СО2 (г/км)": getValue(specs.fuelEmission)},
      ];
}
