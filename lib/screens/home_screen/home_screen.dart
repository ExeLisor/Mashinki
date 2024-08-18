import 'package:autoverse/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: Column(
          children: [
            const TopBar(
              title: "Каталог",
              isHomeScreen: true,
            ),
            const CarsSearchBar(
              isActive: false,
            ),
            const WeeklySelectionWidget(),
            SizedBox(
              height: 20.h,
            ),
            const HomeScreenAdsWidget(),
            SizedBox(
              height: 20.h,
            ),
            MarksWidget(),
            CarsCatalogListWidget(),
          ],
        ),
      );

  Widget _body() => Obx(
      () => _bodyWidgets().elementAt(BarController.to.currentPageIndex.value));

  List<Widget> _bodyWidgets() => <Widget>[
        _homeScreen(),
        _construction(),
        _construction(),
        _construction(),
      ];

  Widget _construction() => Center(
          child: Text(
        "👷 🚧 🛑",
        style: TextStyle(fontSize: 50.h),
      ));
}
