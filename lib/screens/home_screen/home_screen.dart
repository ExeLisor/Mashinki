import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/filters_screen/select_marks_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeController.to.whiteColor,
        body: _homeScreen(),
        bottomNavigationBar: HomeScreenBottomBarWidget(),
        floatingActionButton: const FloatingActionButton(
          onPressed: navgiteToSelectMarks,
        ),
      ),
    );
  }

  void openGooglePlayPage() async {
    const String googlePlayUrl =
        'https://play.google.com/store/apps/details?id=com.ParallelSpace.Cerberus';

    // Замените <PackageName> на имя пакета вашего приложения, например: com.example.app
    final Uri playStoreUri = Uri.parse(googlePlayUrl);

    if (await canLaunch(playStoreUri.toString())) {
      await launch(playStoreUri.toString());
    } else {
      throw 'Не удалось открыть Google Play';
    }
  }

  Widget _appBar() => Obx(
        () => AppBar(
          backgroundColor: AppThemeController.to.whiteColor,
          title: _appBarText(),
          leadingWidth: 30.w,
          leading: Container(),
          centerTitle: true,
          actions: [_accountIcon(), SizedBox(width: 25.w)],
        ),
      );

  Widget _appBarText() => Obx(
        () => Text(
          'catalog'.tr,
          style: TextStyle(
            color:
                AppThemeController.to.isDarkTheme ? Colors.white : primaryColor,
            fontSize: 20.fs,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      );
  Widget _iconBack() => Center(
        child: SvgPicture.asset(
          "assets/svg/logo.svg",
        ),
      );

  Widget _accountIcon() => SvgPicture.asset(
        "assets/svg/account_active.svg",
        color: AppThemeController.to.appBarItemsColor,
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
