import 'package:autoverse/exports.dart';

class HomeScreenBottomBarWidget extends StatelessWidget {
  HomeScreenBottomBarWidget({super.key});

  final BarController _barController = Get.put(BarController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77.h,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 13,
            offset: Offset(0, -1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _items(),
      ),
    );
  }

  final List<String> _icons = [
    homeIcon,
    listIcon,
    comprIcon,
    accountCircleIcon
  ];

  List<Widget> _items() {
    return List.generate(
      4,
      (index) => Obx(
        () => GestureDetector(
          onTap: () => _barController.currentPageIndex(index),
          child: Container(
            height: 70.h,
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
            ),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.transparent)),
            child: SvgPicture.asset(
              _icons[index],
              height: 28.h,
              width: 28.h,
              color: _barController.currentPageIndex.value == index
                  ? primaryColor
                  : unactiveColor,
            ),
          ),
        ),
      ),
    );
  }
}
