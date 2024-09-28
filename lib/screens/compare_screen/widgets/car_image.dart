import 'package:autoverse/exports.dart';

class CompareCarImage extends StatelessWidget {
  const CompareCarImage({super.key, required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) => _carColumn();

  Widget _carColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _carImage(),
          SizedBox(
            height: 12.h,
          ),
          _carTitle()
        ],
      );

  Widget _carImage() => GestureDetector(
        onTap: () {
          log(car.copyWith().selectedModification.toJson());

          // CarController.to.openCarPage(car.copyWith());
        },
        child: Stack(
          children: [
            ImageContainer(
              imageData: ImageData.photo(id: car.configuration.id ?? ""),
              width: 177.w,
              height: 129.h,
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
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3), shape: BoxShape.circle),
            child: ClipRRect(
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
      );

  Widget _carTitle() {
    String brandName = car.mark.name ?? "";
    String modelName = car.model.name ?? "";
    int? year = car.generation.yearStart;
    Modification modification = car.selectedModification;
    String groupName = modification.groupName ?? "Базовая";
    CarSpecifications specification = modification.carSpecifications!;

    String transmission = getTransmissionAbb(specification.transmission);
    String power = specification.horsePower.toString();
    double? volume = specification.volumeLitres;

    return SizedBox(
      width: 177.w,
      child: Text(
        "$brandName $modelName ${year ?? ""}\n$groupName $power $transmission $volume",
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
