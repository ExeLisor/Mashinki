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
      this.loadingWidget});

  final ImageData imageData;

  final double width;
  final double height;

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
        child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) =>
                _imageBuilder(imageProvider),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                _loadingWidget()),
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
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 5.h), // changes position of shadow
              ),
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
