import 'package:autoverse/exports.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: const Navigator(
        initialRoute: '/home',
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _homeScreen(),
      bottomNavigationBar: HomeScreenBottomBarWidget(),
    );
  }

  AppBar appBar() => AppBar(
        toolbarHeight: 0.h,
      );

  Widget _homeScreen() => SingleChildScrollView(
        child: Column(
          children: [
            const TopBar(
              title: "Каталог",
              isHomeScreen: true,
            ),
            const CarsSearchBar(
              isActive: false,
              showFilters: false,
            ),
            const WeeklySelectionWidget(),
            SizedBox(
              height: 20.h,
            ),
            const HomeScreenAdsWidget(),
            SizedBox(
              height: 20.h,
            ),
            const MarksWidget(),
            const CarsCatalogListWidget(),
          ],
        ),
      );
}
