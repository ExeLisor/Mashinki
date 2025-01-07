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

  void _actionWithMark() => isSelect ? _selectMark() : _openModelsPage();
  void _selectMark() => MarkSelectController.to.actionWithMark(mark);
  void _openModelsPage() => ModelsController.to.openModelsPage(mark);

  Widget _markLogo() => GetBuilder<MarkSelectController>(
        builder: (controller) => MarkLogo(
          mark: mark,
          isHighlighted: isSelect && controller.checkMark(mark),
          actionWithMark: _actionWithMark,
        ),
      );

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

class MarkLogo extends StatelessWidget {
  const MarkLogo({
    super.key,
    required this.mark,
    this.actionWithMark,
    this.height = 75,
    this.width = 75,
    this.isHighlighted = false,
    this.showShadow = true,
  });

  final Mark mark;

  final double height;
  final double width;
  final VoidCallback? actionWithMark;
  final bool isHighlighted;
  final bool showShadow;

  @override
  Widget build(BuildContext context) => _markContainer(
        child: ImageContainer(
          height: height,
          width: width,
          imageData: ImageData.mark(id: mark.id ?? ""),
          function: actionWithMark,
          loadingWidget: const MarkLoadingWidget(),
        ),
      );

  Widget _markContainer({Widget? child}) => Container(
        height: height.h,
        width: width.h,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: showShadow ? _shadows : null,
            border: isHighlighted
                ? Border.all(color: primaryColor, width: 2)
                : null),
        child: child,
      );

  final List<BoxShadow> _shadows = const [
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
  ];
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
