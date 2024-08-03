import 'package:autoverse/exports.dart';

class CharacteristicsWidget extends StatelessWidget {
  CharacteristicsWidget({super.key});

  final CarSpecifications specs = CarController.to.specifications;

  List _mainSpecs() => [
        {"Максимальная скорость (км/ч)": "${double.parse(specs.maxSpeed)}"},
        {
          "Время разгона до 100 км/ч (с)":
              "${specs.timeTo100.isNotEmpty ? double.parse(specs.timeTo100) : "-"}"
        },
        {"Вес автомобиля (кг)": specs.fullWeight},
      ];

  List _engineSpecs() => [
        {"Тип двигателя": specs.engineType},
        {"Объем двигателя (см³)": "${double.parse(specs.volume)}"},
        {"Мощность (л.с./кВт)": "${double.parse(specs.horsePower)}"},
        {
          "Максимальные обороты мощности (об/мин)":
              "${specs.rpmPower.isNotEmpty ? int.parse(specs.rpmPower) : "-"}"
        },
        {"Момент (Нм)": "${double.parse(specs.moment)}"},
        {"Тип топлива": specs.petrolType},
        {"Порядок цилиндров": specs.cylindersOrder},
        {"Число цилиндров": "${int.parse(specs.cylindersValue)}"},
        {"Диаметр цилиндра (мм)": "${double.parse(specs.diametr)}"},
        {"Ход поршня (мм)": "${double.parse(specs.pistonStroke)}"},
        {"Степень сжатия": "${double.parse(specs.compression)}"},
        {"Тип питания двигателя": specs.engineFeeding},
        {"Расположение двигателя": specs.engineOrder},
      ];

  List _transmissionSpecs() => [
        {"Тип передней подвески:": specs.frontSuspension},
        {"Тип задней подвески:": specs.backSuspension},
        {"Передние тормоза:": specs.frontBrake},
        {"Задние тормоза:": specs.backBrake}
      ];

  List _sizesSpecs() => [
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

  List _fuelSpecs() => [
        {"Объем топливного бака (л)": specs.volume},
        {"Средний расход топлива (л/100 км)": specs.consumptionMixed},
        {"Расход топлива на трассе (л/100 км)": specs.consumptionCity},
        {"Расход топлива в городе (л/100 км)": specs.consumptionHiway},
        {"Запас хода (км)": specs.rangeDistance}
      ];

  List _secutitySpecs() => [
        {"Рейтинг безопасности": specs.safetyRating},
        {"Класс безопасности": specs.safetyGrade}
      ];

  List __ecologySpecs() => [
        {"Евро-класс": specs.emissionEuroClass},
        {"Выбросы СО2 (г/км)": specs.fuelEmission}
      ];

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
          SizedBox(
            height: 40.h,
          ),
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
          _specsListByGroup("Основные характеристики", _mainSpecs()),
          _specsListByGroup("Характеристики двигателя", _engineSpecs()),
          _specsListByGroup("Подвеска и тормоза", _transmissionSpecs()),
          _specsListByGroup("Трансмиссия", _transmissionSpecs()),
          _specsListByGroup("Размеры и объёмы", _sizesSpecs()),
          _specsListByGroup("Топливная система и расход", _fuelSpecs()),
          _specsListByGroup("Безопасность", _secutitySpecs()),
          _specsListByGroup("Экология", __ecologySpecs()),
        ],
      ),
    );
  }

  Widget _specsListByGroup(String title, List specs) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _divider(),
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
              spec[spec.keys.first],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      );

  Widget _detailsColumnFirst() => Column(
        children: [
          _detailsTile("Объём", "${double.parse(specs.volumeLitres)}",
              isSmall: true),
          SizedBox(
            height: 10.h,
          ),
          _detailsTile("Расход", "${double.parse(specs.consumptionMixed)}",
              isSmall: true),
        ],
      );

  Widget _detailsRowFirst() => Padding(
        padding: EdgeInsets.only(right: 25.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _detailsTile("Тип двигателя", specs.engineType),
            SizedBox(
              width: 19.w,
            ),
            _detailsTile("Коробка", specs.transmission),
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
        children: [
          Row(
            children: [_carHeight(), _carImage()],
          ),
          SizedBox(
            height: 15.h,
          ),
          _carWidth()
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
  Widget _carWidth() => Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: Row(
          children: [
            _arrow(180, isShort: false),
            SizedBox(
              width: 24.w,
            ),
            _carImageSize(specs.width, isHeight: false),
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

  Widget _modificationTitle() => Text(
        'Модификация ${double.parse(specs.volumeLitres)} ${transmissionAbbriviature(specs.transmission)}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      );

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.fs,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );

  Widget _divider() => const Divider(
        color: primaryColor,
      );

  Widget _specsTitle(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _specsWidget(String specs, String value) => Padding(
        padding: EdgeInsets.only(right: 25.w, bottom: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200.w,
              child: Text(
                '$specs:',
                maxLines: 2,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14.fs,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: 140.w,
              child: Text(
                value,
                softWrap: true, // разрешаем переносить текст
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.fs,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      );
  String transmissionAbbriviature(String transmission) {
    switch (transmission) {
      case "вариатор":
        return "CVT";

      default:
        return "";
    }
  }
}
