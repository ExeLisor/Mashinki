import 'package:autoverse/exports.dart';

class HomeScreenBottomBarWidget extends StatelessWidget {
  HomeScreenBottomBarWidget({super.key});

  final BarController _barController = Get.put(BarController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        showSelectedLabels: false,
        items: _items(),
        backgroundColor: Colors.white,
        currentIndex: _barController.currentPageIndex.value,
        onTap: _barController.changePage,
      ),
    );
  }

  final List<String> _icons = [
    homeIcon,
    listIcon,
    comprIcon,
    accountCircleIcon
  ];

  List<BottomNavigationBarItem> _items() {
    return List.generate(
      4,
      (index) => BottomNavigationBarItem(
        label: "",
        backgroundColor: Colors.white,
        icon: SvgPicture.asset(
          _icons[index],
          height: 22.h,
          width: 22.h,
          color: _barController.currentPageIndex.value == index
              ? primaryColor
              : unactiveColor,
        ),
      ),
    );
  }
}
