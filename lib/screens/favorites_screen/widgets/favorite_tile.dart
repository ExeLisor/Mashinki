import 'package:autoverse/exports.dart';

class FavoriteTile extends StatelessWidget {
  const FavoriteTile({super.key, required this.car});

  final Car car;
  static AdsController get add => Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CarController.to.openCarPage(car, isLoadCar: true),
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h, right: 25.0.w),
        decoration: decoration(),
        child: Column(
          children: [
            _carImage(),
            SizedBox(
              height: 11.h,
            ),
            carInfo()
          ],
        ),
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
              color: blackColor,
              child: CachedNetworkImage(
                  imageUrl: "$baseUrl/image/${car.configuration.id}",
                  fit: BoxFit.cover),
            ),
          ),
          _iconsRow()
        ],
      );
  Widget _iconsRow() => Padding(
        padding: EdgeInsets.only(right: 25.0.w, top: 15.h),
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
  Widget _addToCompare() => Obx(
        () {
          CompareController controller = CompareController.to;

          bool isCarCompared = controller.isCarCompared(car.copyWith());
          

          return IconWidget(
            "assets/svg/comp.svg",
            "assets/svg/comp_active.svg",
            () => !isCarCompared
                ? controller.addToCompare(car)
                : controller.deleteFromCompare(car),
            condition: isCarCompared,
          );
        },
      );

  Widget _addToFavorite() => Obx(
        () {
          FavoriteController controller = FavoriteController.to;

          bool isCarFavorite = controller.isCarFavorite(car);

          return IconWidget(
            "assets/svg/favorite.svg",
            "assets/svg/favorite_active.svg",
            () => controller.removeFromFavorite(car),
            condition: isCarFavorite,
          );
        },
      );

  Widget icon(IconData icon, VoidCallback action) => GestureDetector(
        onTap: action,
        child: Container(
          width: 45.h,
          height: 45.h,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: blackColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              color: whiteColor,
            ),
          ),
        ),
      );

  Widget carInfo() => Padding(
        padding: EdgeInsets.fromLTRB(17.0.w, 0.h, 17.w, 17.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [carName(), carYear()],
        ),
      );

  Widget carName() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [carTitle(), _modificationTitle()],
      );

  Widget carTitle() {
    String brandName = car.mark.name ?? "";
    String modelName = car.model.name ?? "";
    String subtitle = car.generation.name ?? "";

    return Text(
      "$brandName $modelName $subtitle",
      style: TextStyle(
          fontSize: 25.fs, fontWeight: FontWeight.bold, color: primaryColor),
    );
  }

  Widget _modificationTitle() {
    Modification modification = car.selectedModification;

    return Text(
      "${modification.groupName ?? ""} ${modification.title}".trim(),
      style: TextStyle(
          color: blackColor, fontSize: 18.fs, fontWeight: FontWeight.bold),
    );
  }

  Widget carYear() {
    int? year = car.generation.yearStart;
    return Text(
      "$year",
      style: TextStyle(fontSize: 20.fs, fontWeight: FontWeight.w300),
    );
  }

  ShapeDecoration decoration() => ShapeDecoration(
        color: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
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
      );
}
