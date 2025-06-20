import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/marks_screen/widgets/mark_tile.dart';

class MarksGrid extends GetView<MarksController> {
  const MarksGrid({super.key, required this.marks, this.isSelect = false});

  final bool isSelect;
  final List<Mark> marks;

  static const SliverGridDelegate _delegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 0,
    crossAxisSpacing: 0,
  );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: _delegate,
        itemCount: marks.length,
        itemBuilder: (context, index) =>
            MarkGridTile(mark: marks[index], isSelect: isSelect));
  }
}

class LoadingMarksGrid extends StatelessWidget {
  const LoadingMarksGrid({super.key});

  static const SliverGridDelegate _delegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 15.0,
    crossAxisSpacing: 10.0,
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarksController>(
      builder: (controller) => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: _delegate,
        itemCount: 100,
        itemBuilder: (context, index) {
          return const LoadingMarkGridTile();
        },
      ),
    );
  }
}
