import 'package:autoverse/exports.dart';

class MarkGridTile extends StatelessWidget {
  const MarkGridTile({super.key, required this.mark});

  final Mark mark;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _markLogo(),
          SizedBox(height: 10.h),
          _markName(),
        ],
      );

  Widget _markContainer({Widget? child}) => Container(
        width: 75.h,
        height: 75.h,
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
      );

  Widget _markLogo() => _markContainer(
          child: ImageContainer(
        imageData: ImageData.mark(id: mark.id ?? ""),
        function: () => ModelsController.to.openModelsPage(mark),
        loadingWidget: const MarkLoadingWidget(),
      ));

  Widget _markName() => Text(
        mark.name ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 14.fs, fontWeight: FontWeight.w400),
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
