import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/brand_screen/widgets/bran_tile.dart';

class BrandGrid extends StatelessWidget {
  const BrandGrid({super.key, required this.brands});

  final List<Mark> brands;

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
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return MarkGridTile(mark: brands[index]);
        },
      ),
    );
  }
}
