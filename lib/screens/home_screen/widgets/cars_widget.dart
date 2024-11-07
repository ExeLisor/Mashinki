import 'package:autoverse/exports.dart';

class CarsCatalogListWidget extends StatelessWidget {
  const CarsCatalogListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(),
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
        successCondition: true,
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

  Widget _title() => Padding(
        padding: EdgeInsets.only(left: 25.0.w),
        child: Text(
          "Автомобили",
          style: TextStyle(
              fontSize: 16.fs,
              color: primaryColor,
              fontWeight: FontWeight.w600),
        ),
      );

  Widget _carsGrid() => ListView(
        padding: EdgeInsets.only(bottom: 25.h, left: 25.w, right: 25.w),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          CatalogTile(
            name: "Toyota Camry",
            year: "2023",
            imageUrl:
                "https://avatars.mds.yandex.net/get-verba/997355/2a0000018e0fd1de72d4ecb8fef86d78a72e/cattouchret",
          ),
          CatalogTile(
            name: "Toyota Camry",
            year: "2025",
            imageUrl:
                "https://motortrend.com/files/661fed9cfceecf0008b212e4/001-2025-toyota-camry-se-awd-lead.jpg?w=768&width=768&q=75&format=webp",
          ),
          CatalogTile(
            name:
                "Toyota CorollaToyota CorollaToyota CorollaToyota CorollaToyota CorollaToyota CorollaToyota CorollaToyota Corolla",
            year: "2023",
            imageUrl:
                "https://d8a6a33f-3369-444b-9b5f-793c13ff0708.selcdn.net/media/common/just_strip/tradeins.space/uploads/models_gallery_image/13778/450d7266a8acac506ddc97c36c79cedee2addd42.jpeg?v77",
          ),
          CatalogTile(
            name: "Toyota Yaris",
            year: "2019",
            imageUrl:
                "https://s.auto.drom.ru/img5/catalog/photos/fullsize/toyota/yaris/toyota_yaris_297782.jpg",
          )
        ],
      );
}

class CatalogTile extends StatelessWidget {
  const CatalogTile(
      {super.key,
      required this.name,
      required this.year,
      required this.imageUrl});

  final String name;
  final String year;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: _decoration(),
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

  Widget _carImage() => Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            child: Container(
              height: 225.h,
              width: 361.w,
              color: Colors.black,
              child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
            ),
          ),
          _iconsRow()
        ],
      );
  Widget _iconsRow() => Padding(
        padding: EdgeInsets.only(right: 15.0.w, top: 13.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _addToCompare(),
            SizedBox(
              width: 10.w,
            ),
            _addToFavorite()
          ],
        ),
      );
  Widget _addToFavorite() => _icon("favorite", () {});
  Widget _addToCompare() => _icon("comp", () {});

  Widget _icon(String icon, VoidCallback action) => GestureDetector(
        onTap: action,
        child: Container(
          width: 32.h,
          height: 32.h,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/svg/$icon.svg",
            ),
          ),
        ),
      );

  Widget _carInfo() => Padding(
        padding: EdgeInsets.fromLTRB(17.0.w, 0.h, 17.w, 17.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_carName(), _carYear()],
        ),
      );

  Widget _carName() => SizedBox(
        width: 200.w,
        child: Text(
          name,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20.fs,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      );

  Widget _carYear() => Text(
        year,
        style: TextStyle(fontSize: 20.fs, fontWeight: FontWeight.w300),
      );

  ShapeDecoration _decoration() => ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 15,
            offset: Offset(-1, 10),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 15,
            offset: Offset(1, 1),
            spreadRadius: 2,
          )
        ],
      );
}
