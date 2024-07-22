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

  Widget _weeklyTitle() => Text(
        "Недельная подборка",
        style: TextStyle(
            color: primaryColor, fontSize: 18.fs, fontWeight: FontWeight.w700),
      );

  Widget _weeklyCarousel() => HomeShimmerWidget(
      shimmer: _weeklyWidgetLoadingShimmer(), child: _weeklyPageView());

  Widget _weeklyPageView() => SizedBox(
        width: 362.w,
        height: 136.h,
        child: PageView(
          children: const [
            WeeklyCarTile(
                carName: "Mercedes-Benz GLE",
                carImageUrl:
                    "https://avatars.mds.yandex.net/get-verba/787013/2a00000167116561097ce22cba5910afa46a/320x240"),
            WeeklyCarTile(
                carName: "Tesla Model 3",
                carImageUrl:
                    "https://tesla-cars.by/wp-content/uploads/2022/02/Tesla-Model-3_2023_1000x660_1-optimized.jpg")
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
    return Container(
      width: 362.w,
      height: 136.h,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          _carImage(),
          _arrows(),
          _carNameText(),
        ],
      ),
    );
  }

  Widget _carNameText() => Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 18.0.w, bottom: 11.h),
          child: Text(
            carName ?? "",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.fs,
                fontWeight: FontWeight.bold),
          ),
        ),
      );

  Widget _arrows() => Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_arrowButton(true), _arrowButton(false)],
        ),
      );

  Widget _arrowButton(bool isBack) => Icon(
        isBack ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded,
        color: Colors.white,
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
                  fit: BoxFit.fitWidth,
                ),
        ),
      );
}
