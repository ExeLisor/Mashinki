import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/brand_screen/widgets/bran_tile.dart';

class BrandGrid extends StatelessWidget {
  const BrandGrid({super.key, required this.popular});

  final bool popular;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarksController>(
      builder: (controller) => GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount:
            popular ? controller.popularMarks.length : controller.marks.length,
        itemBuilder: (context, index) {
          return getGridItem(popular
              ? controller.popularMarks[index]
              : controller.marks[index]);
        },
      ),
    );
  }

  Widget getGridItem(Mark brand) {
    return GestureDetector(onTap: () {}, child: brandCard(brand));
  }
}
