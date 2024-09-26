import 'package:autoverse/exports.dart';

class MarkGridTile extends StatelessWidget {
  const MarkGridTile({super.key, required this.mark});

  final Mark mark;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _markLogo(),
          SizedBox(
            height: 5.h,
          ),
          _markName(),
        ],
      );

  Widget _markLogo() => ImageContainer(
        imageData: ImageData.mark(id: mark.id ?? ""),
        function: () => ModelsController.to.openModelsPage(mark),
        margin: EdgeInsets.only(right: 12.h, bottom: 10.h),
        padding: EdgeInsets.all(5.h),
        loadingWidget: const MarkLoadingWidget(),
      );

  Widget _markName() => Text(
        mark.name ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 12.fs, fontWeight: FontWeight.w600),
      );
}

class LoadingMarkGridTile extends StatelessWidget {
  const LoadingMarkGridTile({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _markLogo(),
          SizedBox(
            height: 5.h,
          ),
          _markName(),
        ],
      );

  Widget _markLogo() => Container(
      // margin: EdgeInsets.only(bottom: 5.h),
      // padding: EdgeInsets.all(5.h),
      child: const MarkLoadingWidget());

  Widget _markName() => Text(
        "",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 12.fs, fontWeight: FontWeight.w600),
      );
}
