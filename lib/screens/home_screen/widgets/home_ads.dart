import 'package:mashinki/exports.dart';
import 'package:mashinki/screens/home_screen/widgets/home_shimmer.dart';

class HomeScreenAdsWidget extends StatelessWidget {
  const HomeScreenAdsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeShimmerWidget(shimmer: _adsLoadingWidget(), child: _adsWidget());
  }

  Widget _adsContainer({Widget? child}) => Container(
      height: 69.h,
      width: 362.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffF2F2F2),
      ),
      child: child ?? Container());

  Widget _adsWidget() => _adsContainer(
        child: Center(
          child: Text(
            "Здесь могла бы быть ваша реклама)",
            style: TextStyle(
                fontSize: 18.fs,
                color: primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      );

  Widget _adsLoadingWidget() => ShimmerWidget(
        child: _adsContainer(),
      );
}
