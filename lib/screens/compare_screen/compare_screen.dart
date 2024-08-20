import 'package:autoverse/exports.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  static final CompareController controller = CompareController.to;

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: appBar(), body: _body());

  Widget _body() => SingleChildScrollView(
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
          subtitle: "${CompareController.to.comparedCars.length} сравнений",
          isHomeScreen: true,
        ),
      );

  Widget _view() => Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
        _specsTitles.length,
        (index) {
          List<CarSpecifications> specs = controller.getAllSpecifications();
          List values = [];

          for (int i = 0; i < _allNamesSpecs.length; i++) {
            List value = [];
            for (CarSpecifications specs in specs) {
              value.add(_allSpecs(specs)[i]);
            }
            values.add(value);
          }

          return CompareSpecsWidget(
              index: index,
              title: _specsTitles[index],
              specsNames: _allNamesSpecs[index],
              specs: values[index]);
        },
      ),
    );
  }
}

const List<String> _specsTitles = [
  "Основные",
  "Трасмиссия",
  // "Объём и масса",
  // "Двигатель",
  // "Подвеска и торомза"
];

List _allNamesSpecs = [_mainSpecsNames, _transmissionSpecsNames];

const List<String> _mainSpecsNames = [
  "Объём двигателя",
  "Тип двигателя",
  "Мощность двигателя",
  "Максимальная скорость",
  "Разгон до 100 км/ч",
];
const List<String> _transmissionSpecsNames = [
  "Тип КПП",
  "Количество передач",
  "Привод",
];

List _allSpecs(CarSpecifications specs) =>
    [_mainSpecs(specs), _transmissionSpecs(specs)];
List _mainSpecs(CarSpecifications specs) => [
      "${specs.volumeLitres} л.",
      specs.engineType,
      "${specs.horsePower} л.с.",
      specs.maxSpeed,
      specs.timeTo100,
    ];
List _transmissionSpecs(CarSpecifications specs) => [
      specs.transmission,
      specs.gearValue,
      specs.drive,
    ];

class CompareSpecsWidget extends StatefulWidget {
  const CompareSpecsWidget(
      {super.key,
      required this.index,
      required this.title,
      required this.specsNames,
      required this.specs});

  final int index;
  final String title;
  final List<String> specsNames;
  final List specs;

  @override
  State<CompareSpecsWidget> createState() => _CompareSpecsWidgetState();
}

class _CompareSpecsWidgetState extends State<CompareSpecsWidget> {
  final CompareController controller = CompareController.to;

  bool isOpened = true;

  void close() => setState(() => isOpened = false);

  void open() => setState(() => isOpened = true);

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
        children: List.generate(
          widget.specsNames.length,
          (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _specsName(
                  widget.specsNames[index],
                ),
                _specsValues(index),
                SizedBox(
                  height: 10.h,
                ),
              ],
            );
          },
        ),
      );

  Widget _specsValues(int index) => Row(
        children: List.generate(
          widget.specs.length,
          (specsIndex) {
            return _spec(widget.specs[specsIndex][index].toString());
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

  Widget _spec(var value, {bool isHighlighted = false}) => SizedBox(
        width: 185.w,
        child: Text(
          value,
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
  Widget build(BuildContext context) {
    return _carColumn();
  }

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
            _removeCompare(),
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
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23.h),
              ),
            ),
            child: Center(
              child: Icon(Icons.clear, color: Colors.black, size: 20.h),
            ),
          ),
        ),
      );
  Widget _carTitle() {
    String brandName = car.mark.name ?? "";
    String modelName = car.model.name ?? "";
    int? year = car.generation.yearStart;

    return Text(
      "$brandName $modelName ${year ?? ""}",
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.fs,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        height: 0,
      ),
    );
  }
}
