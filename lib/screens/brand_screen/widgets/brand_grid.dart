import 'package:mashinki/exports.dart';
import 'package:mashinki/screens/brand_screen/widgets/bran_tile.dart';

class BrandGrid extends StatelessWidget {
  final List<Brand> brands;

  const BrandGrid({super.key, required this.brands});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemCount: brands.length,
      itemBuilder: (context, index) {
        return getGridItem(brands[index]);
      },
    );
  }

  Widget getGridItem(Brand brand) {
    return GestureDetector(
        onTap: () {}, child: brandCard(brand.name, brand.brandLogo));
  }
}
