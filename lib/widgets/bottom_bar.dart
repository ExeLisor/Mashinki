import 'package:autoverse/exports.dart';

class HomeScreenBottomBarWidget extends StatelessWidget {
  HomeScreenBottomBarWidget({super.key});

  final BarController _barController = Get.put(BarController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
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

  final List<BottomIcon> _icons = [
    BottomIcon.home(),
    BottomIcon.compare(),
    BottomIcon.favorite(),
    BottomIcon.account(),
  ];

  List<Widget> _items() {
    return List.generate(4, (index) => _item(index));
  }

  Widget _item(int index) {
    if (_icons[index] == comprIcon) {
      return Obx(
        () => _itemWithBudget(
          index,
          CompareController.to.comparedCars.length,
        ),
      );
    }

    return Obx(
      () => GestureDetector(
        onTap: () => _barController.changePage(index),
        child: Container(
          height: 70.h,
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
          ),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          child: SvgPicture.asset(
            _icons[index].getPath(index),
            color: _icons[index].isActive(index) ? primaryColor : unactiveColor,
            height: 24.h,
            width: 24.h,
          ),
        ),
      ),
    );
  }

  Widget _itemWithBudget(int index, int count) {
    return Obx(
      () => GestureDetector(
        onTap: () => _barController.changePage(index),
        child: Container(
          height: 70.h,
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
          ),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          child: Center(
            child: Badge(
              badgeStyle: const BadgeStyle(
                badgeColor: paleColor,
              ),
              showBadge: count > 0,
              badgeAnimation: const BadgeAnimation.rotation(),
              badgeContent: Text(
                count.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12.fs),
              ),
              child: SvgPicture.asset(
                _icons[index].getPath(index),
                height: 24.h,
                width: 24.h,
                color: _icons[index].isActive(index)
                    ? primaryColor
                    : unactiveColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomIcon {
  final String active;
  final String inactive;

  static const String path = "assets/svg";

  BottomIcon.home()
      : active = '$path/home_active.svg',
        inactive = '$path/home.svg';

  BottomIcon.compare()
      : active = '$path/comp_bottom.svg',
        inactive = '$path/comp_bottom.svg';

  BottomIcon.favorite()
      : active = '$path/favorite_blue.svg',
        inactive = '$path/favorite_bottom.svg';

  BottomIcon.account()
      : active = '$path/account_active.svg',
        inactive = '$path/account.svg';

  String getPath(int index) =>
      BarController.to.currentPageIndex.value == index ? active : inactive;

  bool isActive(int index) => BarController.to.currentPageIndex.value == index;
}
