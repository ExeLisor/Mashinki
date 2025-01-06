import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/filters_screen/select_marks_screen.dart';

class MarkGridTile extends StatelessWidget {
  const MarkGridTile({super.key, required this.mark, this.isSelect = false});
  final bool isSelect;
  final Mark mark;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _markLogo(),
          SizedBox(height: 10.h),
          _markName(),
        ],
      );

  Widget _markContainer({Widget? child}) => GetBuilder<MarkSelectController>(
      builder: (controller) => Container(
            width: 75.h,
            height: 75.h,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: boxShadowColor,
                  blurRadius: 15,
                  offset: Offset(-1, 10),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: boxShadowColor,
                  blurRadius: 15,
                  offset: Offset(1, 1),
                  spreadRadius: 2,
                )
              ],
              border: isSelect && controller.checkMark(mark)
                  ? Border.all(color: primaryColor, width: 2)
                  : null,
            ),
            child: child,
          ));

  void _actionWithMark() => isSelect ? _selectMark() : _openModelsPage();
  void _selectMark() => MarkSelectController.to.actionWithMark(mark);
  void _openModelsPage() => ModelsController.to.openModelsPage(mark);

  Widget _markLogo() => _markContainer(
          child: ImageContainer(
        imageData: ImageData.mark(id: mark.id ?? ""),
        function: _actionWithMark,
        loadingWidget: const MarkLoadingWidget(),
      ));

  Widget _markName() => Text(
        mark.name ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppThemeController.to.isDarkTheme ? whiteColor : blackColor,
            fontSize: 14.fs,
            fontWeight: FontWeight.w400),
      );
}

class LoadingMarkGridTile extends StatelessWidget {
  const LoadingMarkGridTile({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _markLogo(),
          SizedBox(height: 5.h),
          _markName(),
        ],
      );

  Widget _markLogo() => const MarkLoadingWidget();

  Widget _markName() => Text(
        "",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: blackColor, fontSize: 12.fs, fontWeight: FontWeight.w600),
      );
}
