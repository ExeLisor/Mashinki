import 'package:autoverse/exports.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final BarController _barController = Get.put(BarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _bottomBar(),
      body: _body(),
    );
  }

  AppBar _appBar() => AppBar(
        toolbarHeight: 0.h,
      );

  Widget _bottomBar() => HomeScreenBottomBarWidget();

  Widget _homeScreen() => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              const TopBar(
                title: "Каталог",
                isHomeScreen: true,
              ),

              // const CarsSearchBar(
              //   isActive: false,
              //   isActiveButton: false,
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
              // const WeeklySelectionWidget(),
              // SizedBox(
              //   height: 20.h,
              // ),
              // const HomeScreenAdsWidget(),
              // SizedBox(
              //   height: 20.h,
              // ),
              MarksWidget(),
              // SizedBox(
              //   height: 20.h,
              // ),
              // CarsCatalogListWidget(),
            ],
          ),
        ),
      );

  Widget _body() => Obx(
      () => _bodyWidgets().elementAt(_barController.currentPageIndex.value));

  List<Widget> _bodyWidgets() => <Widget>[
        _homeScreen(),
        Container(),
        Container(),
        Container(),
      ];
}
