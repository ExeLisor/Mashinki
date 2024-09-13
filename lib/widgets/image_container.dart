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

  final double height;
  final double width;

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
            : loadingWidget ?? _emptyWidget();
      },
    );
  }

  Widget _emptyWidget() => SizedBox(
        height: height.h,
        width: width.w,
      );

  Widget _image(String url) => GestureDetector(
        onTap: function,
        child: _markContainer(
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.contain,
          ),
        ),
      );

  Widget _markContainer({Widget? child}) => Container(
        width: height.h,
        height: width.h,
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
      );
}
