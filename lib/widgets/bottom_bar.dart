import 'package:mashinki/exports.dart';

class HomeScreenBottomBarWidget extends StatelessWidget {
  HomeScreenBottomBarWidget({super.key});

  final BarController _barController = Get.put(BarController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        showSelectedLabels: false,
        items: _items(),
        currentIndex: _barController.currentPageIndex.value,
        onTap: _barController.changePage,
      ),
    );
  }

  List<BottomNavigationBarItem> _items() {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          homeIcon,
          color: _barController.currentPageIndex.value == 0
              ? primaryColor
              : unactiveColor,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          listIcon,
          color: _barController.currentPageIndex.value == 1
              ? primaryColor
              : unactiveColor,
        ),
        label: 'Business',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          comprIcon,
          color: _barController.currentPageIndex.value == 2
              ? primaryColor
              : unactiveColor,
        ),
        label: 'School',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          accountCircleIcon,
          color: _barController.currentPageIndex.value == 3
              ? primaryColor
              : unactiveColor,
        ),
        label: 'School',
      ),
    ];
  }
}
