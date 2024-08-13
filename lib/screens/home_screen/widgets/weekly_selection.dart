import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/home_screen/widgets/home_shimmer.dart';

class WeeklySelectionWidget extends StatelessWidget {
  const WeeklySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _weeklyTitle(),
            SizedBox(
              height: 15.h,
            ),
            _weeklyCarousel()
          ],
        ),
      ],
    );
  }

  Widget _weeklyTitle() => Padding(
        padding: EdgeInsets.only(left: 25.w),
        child: Text(
          "Недельная подборка",
          style: TextStyle(
              color: primaryColor,
              fontSize: 18.fs,
              fontWeight: FontWeight.w700),
        ),
      );

  Widget _weeklyCarousel() => HomeShimmerWidget(
      shimmer: _weeklyWidgetLoadingShimmer(),
      successCondition: true,
      child: _weeklyPageView());

  Widget _weeklyPageView() => Container(
        width: Get.width,
        height: 136.h,
        child: PageView(
          controller: PageController(viewportFraction: 0.9),
          children: [
            WeeklyCarTile(
                carName: "Mercedes-Benz GLE",
                carImageUrl:
                    "https://avatars.mds.yandex.net/get-verba/787013/2a00000167116561097ce22cba5910afa46a/320x240"),
            WeeklyCarTile(
                carName: "Tesla CyberTruck",
                carImageUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Cybertruck-fremont-cropped.jpg/1200px-Cybertruck-fremont-cropped.jpg"),
            WeeklyCarTile(
                carName: "Jeep Wrangler",
                carImageUrl:
                    "https://www.autocar.co.uk/sites/autocar.co.uk/files/jeep-wrangler-review-2024-01-cornering-front.jpg"),
          ],
        ),
      );

  Widget _weeklyWidgetLoadingShimmer() => ShimmerWidget(
        child: Container(
          width: 362.w,
          height: 136.h,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      );
}

class WeeklyCarTile extends StatelessWidget {
  const WeeklyCarTile({super.key, this.carName, this.carImageUrl});

  final String? carName;
  final String? carImageUrl;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: 362.w,
        height: 136.h,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            _carImage(),
            _carNameText(),
          ],
        ),
      ),
    );
  }

  Widget _carNameText() => Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 18.0.w, bottom: 11.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 11.w),
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(
              carName ?? "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.fs,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  Widget _carImage() => SizedBox(
        width: 362.w,
        height: 136.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: carImageUrl == null
              ? Container()
              : CachedNetworkImage(
                  imageUrl: carImageUrl ?? "",
                  fit: BoxFit.cover,
                ),
        ),
      );
}
