import 'package:flutter/rendering.dart';
import 'package:mashinki/exports.dart';
import 'package:mashinki/screens/home_screen/widgets/home_shimmer.dart';

class BrandsWidget extends StatelessWidget {
  const BrandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _brandsWidgetTitle(),
        SizedBox(
          height: 15.h,
        ),
        _brandsView()
      ],
    );
  }

  Widget _brandsView() =>
      HomeShimmerWidget(shimmer: _brandsLoadingWidget(), child: _brandsList());

  Widget _brandsWidgetTitle() => Row(
        children: [
          Text(
            "Бренды",
            style: TextStyle(
                fontSize: 18.fs,
                color: primaryColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 13.w,
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: primaryColor,
          ),
        ],
      );

  Widget _brandsList() => SizedBox(
        height: 58.h,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            _brandTile(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Tesla_T_symbol.svg/640px-Tesla_T_symbol.svg.png"),
            SizedBox(
              width: 25.w,
            ),
            _brandTile(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3jLdiRIffyVvYjJSgZqFzc73YJSfqcRbR6Q&s"),
            SizedBox(
              width: 25.w,
            ),
            _brandTile(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png"),
            SizedBox(
              width: 25.w,
            ),
            _brandTile(
                "https://pngimg.com/uploads/lamborghini/lamborghini_PNG10709.png"),
            SizedBox(
              width: 25.w,
            ),
            _brandTile(
                "https://w7.pngwing.com/pngs/863/573/png-transparent-chevrolet-impala-car-general-motors-logo-chevrolet-logo-car-desktop-wallpaper-thumbnail.png"),
            SizedBox(
              width: 25.w,
            ),
            _brandTile(
                "https://pngimg.com/uploads/lamborghini/lamborghini_PNG10709.png"),
          ],
        ),
      );

  Widget _brandsLoadingWidget() => ShimmerWidget(
        child: SizedBox(
          height: 58.h,
          width: Get.width,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 5.h), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
      );

  Widget _brandTile(String imageUrl) => Container(
        height: 58.h,
        width: 58.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 5.h), // changes position of shadow
            ),
          ],
        ),
        child: Image.network(
          imageUrl,
        ),
      );
}
