import 'package:mashinki/exports.dart';

class HomeScreenAdsWidget extends StatelessWidget {
  const HomeScreenAdsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69.h,
      width: 362.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffF2F2F2),
      ),
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
  }
}
