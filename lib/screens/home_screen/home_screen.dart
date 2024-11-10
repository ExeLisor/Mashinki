import 'package:autoverse/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => SupabaseController.to.getWeeklyCars(),
      ),
      bottomNavigationBar: HomeScreenBottomBarWidget(),
    );
  }

  AppBar _appBar() => AppBar(
        title: _appBarText(),
        leadingWidth: 30.w,
        leading: _iconBack(),
        centerTitle: true,
        actions: [_accountIcon(), SizedBox(width: 25.w)],
      );

  Widget _appBarText() => Text(
        'Каталог',
        style: TextStyle(
          color: primaryColor,
          fontSize: 20.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
      );
  Widget _iconBack() => Center(
        child: SvgPicture.asset(
          "assets/svg/logo.svg",
        ),
      );

  Widget _accountIcon() => SvgPicture.asset(
        "assets/svg/account_active.svg",
        height: 24.h,
        width: 24.w,
      );

  Widget _homeScreen() => SingleChildScrollView(
        child: Column(
          children: [
            _appBar(),
            SizedBox(height: 5.h),
            const CarsSearchBar(),
            SizedBox(height: 20.h),
            const WeeklySelectionWidget(),
            SizedBox(height: 20.h),
            const MarksWidget(),
            const CarsCatalogListWidget(),
          ],
        ),
      );
}
