import 'package:mashinki/exports.dart';

class CarsCatalogListWidget extends StatelessWidget {
  const CarsCatalogListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _carsCatalogWidgetTitle(),
            SizedBox(
              height: 15.h,
            ),
            const CatalogTile()
          ],
        ),
      ],
    );
  }

  Widget _carsCatalogWidgetTitle() => Text(
        "Автомобили",
        style: TextStyle(
            fontSize: 18.fs, color: primaryColor, fontWeight: FontWeight.w600),
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
