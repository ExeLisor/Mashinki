import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/home_screen/widgets/home_shimmer.dart';

class CarsCatalogListWidget extends StatelessWidget {
  CarsCatalogListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _carsCatalogWidgetTitle(),
              SizedBox(
                height: 15.h,
              ),
              _carsView(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _carsView() => HomeShimmerWidget(
        shimmer: _carsGridLoading(),
        child: _carsGrid(),
      );

  Widget _carsGridLoading() => ShimmerWidget(
        child: Row(
          children: [
            _catalogTileContainer(),
            SizedBox(
              width: 18.w,
            ),
            _catalogTileContainer(),
          ],
        ),
      );

  Widget _catalogTileContainer() => Container(
        height: 169.h,
        width: 172.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5.h), // changes position of shadow
            ),
          ],
        ),
      );

  Widget _carsCatalogWidgetTitle() => Text(
        "Автомобили",
        style: TextStyle(
            fontSize: 18.fs, color: primaryColor, fontWeight: FontWeight.w600),
      );
  final SliverGridDelegate _gridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // number of items in each row
    mainAxisSpacing: 18.0.w, // spacing between rows
    crossAxisSpacing: 8.0, // spacing between columns
  );
  Widget _carsGrid() => GridView.builder(
        padding: EdgeInsets.only(bottom: 16.h),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: _gridDelegate,
        itemCount: 4,
        itemBuilder: (_, index) => const CatalogTile(),
      );
}

class CatalogTile extends StatelessWidget {
  const CatalogTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 169.h,
      width: 172.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5.h), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          _carImage(),
          SizedBox(
            height: 11.h,
          ),
          _carInfo()
        ],
      ),
    );
  }

  Widget _carImage() => ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        child: Container(
          height: 131.h,
          width: 172.w,
          color: Colors.black,
        ),
      );

  Widget _carInfo() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_carName(), _carYear()],
        ),
      );

  Widget _carName() => Text(
        "BMW X3 30i xDrive",
        style: TextStyle(
            fontSize: 12.fs, fontWeight: FontWeight.bold, color: Colors.black),
      );

  Widget _carYear() => Text(
        "2025",
        style: TextStyle(fontSize: 12.fs, fontWeight: FontWeight.w300),
      );
}
