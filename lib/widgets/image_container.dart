import 'package:autoverse/exports.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer(
      {super.key,
      required this.imageData,
      this.height = 75,
      this.width = 75,
      this.margin,
      this.padding,
      this.function,
      this.shadows,
      this.loadingWidget});

  final ImageData imageData;

  final double width;
  final double height;
  final List<BoxShadow>? shadows;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final GestureTapCallback? function;

  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: FirebaseController.to
          .loadImage(imageData.path, imageData.id, type: imageData.type),
      builder: (context, snapshot) {
        return snapshot.data != null
            ? _image(snapshot.data!)
            : _loadingWidget();
      },
    );
  }

  Widget _image(String url) => GestureDetector(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(boxShadow: shadows),
          child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) =>
                  _imageBuilder(imageProvider),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  SizedBox(
                    width: width.h,
                    height: height.h,
                  )),
        ),
        // _loadingWidget()),
      );

  Widget _imageBuilder(ImageProvider<Object> image) => _markContainer(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Widget _markContainer({Widget? child}) => ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        child: Container(
          width: width.h,
          height: height.h,
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 15,
                offset: Offset(-1, 10),
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
          child: child,
        ),
      );

  Widget _loadingWidget() =>
      loadingWidget ??
      ShimmerWidget(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          height: height.h,
          width: width.w,
        ),
      );
}
