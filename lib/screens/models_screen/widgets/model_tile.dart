import 'package:autoverse/exports.dart';

class ModelTile extends StatelessWidget {
  ModelTile({
    super.key,
    required this.model,
    required this.generation,
    required this.configuration,
    this.isSingle = true,
  });

  final Model model;
  final Generation generation;
  final Configuration configuration;
  final bool isSingle;

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
          width: isSingle ? containerWidth : containerWidth - 30.w,
          margin: EdgeInsets.fromLTRB(25.w, 15.h, 10.w, 15.h),
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
  Widget _modelYear() =>
      _textContainer(model.yearFrom.toString(), setMinWidth: false);

  Widget _textContainer(String text, {bool setMinWidth = true}) => text.isEmpty
      ? Container()
      : Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 7.w),
          constraints: BoxConstraints(maxWidth: 180.w),
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
              fontSize: 20.fs,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
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
            padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 7.w),
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

  Widget _modelImage() => SizedBox(
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

extension NullOrEmptyExtension on String? {
  bool get nullOrEmpty => this == null || this!.isEmpty;
}
