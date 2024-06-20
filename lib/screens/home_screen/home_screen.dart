import 'package:mashinki/exports.dart';

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
              const TopBar(title: "Каталог"),
              SizedBox(
                height: 25.h,
              ),
              const CarsSearchBar(),
              SizedBox(
                height: 20.h,
              ),
              const WeeklySelectionWidget(),
              SizedBox(
                height: 20.h,
              ),
              const HomeScreenAdsWidget(),
              SizedBox(
                height: 20.h,
              ),
              const BrandsWidget(),
              SizedBox(
                height: 20.h,
              ),
              const CarsCatalogListWidget(),
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
