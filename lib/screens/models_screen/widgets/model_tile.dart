import 'package:autoverse/exports.dart';

class ModelTile extends StatelessWidget {
  ModelTile({
    super.key,
    required this.model,
    required this.generation,
    required this.configuration,
  });

  final Model model;
  final Generation generation;
  final Configuration configuration;

  final containerHeight = 250.h;
  final containerWidth = 362.w;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          Car car = Car(
              mark: ModelsController.to.mark,
              model: model,
              generation: generation,
              configuration: configuration,
              modifications: configuration.modifications ?? [],
              selectedModification: (configuration.modifications ?? []).first);
          CarController.to.openCarPage(car, isLoadCar: true);
        },
        child: Container(
          height: containerHeight,
          width: containerWidth,
          margin: EdgeInsets.fromLTRB(0.w, 15.h, 10.w, 15.h),
          child: Stack(
            children: [
              _modelImage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_modelTitle(), _modelYear()],
              ),
              _configurationType()
            ],
          ),
        ),
      );

  Widget _modelTitle() => _textContainer(generation.name ?? "");
  Widget _modelYear() => _textContainer(model.yearFrom.toString(),
      setMinWidth: false, fontSize: 16.fs, fontWeight: FontWeight.w400);

  Widget _textContainer(String text,
          {bool setMinWidth = true,
          double fontSize = 18,
          FontWeight fontWeight = FontWeight.w600}) =>
      text.isEmpty
          ? Container()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 7.w),
              constraints: BoxConstraints(maxWidth: 180.w, minHeight: 38.h),
              margin: EdgeInsets.all(15.h),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize.fs,
                  fontFamily: 'Inter',
                  fontWeight: fontWeight,
                ),
              ),
            );

  Widget _configurationType() => configuration.bodyType.nullOrEmpty
      ? Container()
      : Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 31.h,
            margin: EdgeInsets.all(15.h),
            padding: EdgeInsets.fromLTRB(18.w, 6.h, 18.w, 8.h),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  (configuration.bodyType ?? "").capitalizeFirstLetter(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.fs,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        );

  Widget _modelImage() => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 15,
              offset: Offset(0, 3),
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 15,
              offset: Offset(1, 1),
              spreadRadius: 2,
            )
          ],
        ),
        height: containerHeight,
        width: containerWidth,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          child: CachedNetworkImage(
            imageUrl: "$baseUrl/image/${configuration.id ?? ""}",
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      );
}
