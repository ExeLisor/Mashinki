import 'package:autoverse/exports.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeController.to.whiteColor,
      appBar: _appBar(),
      bottomNavigationBar: HomeScreenBottomBarWidget(),
      body: _body(),
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: AppThemeController.to.whiteColor,
        title: _appBarText(),
        leading: _iconBack(),
        centerTitle: true,
        actions: [_accountIcon(), SizedBox(width: 25.w)],
      );

  Widget _appBarText() => Column(
        children: [
          Text(
            'favorite'.tr,
            style: TextStyle(
              color: AppThemeController.to.appBarItemsColor,
              fontSize: 20.fs,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );

  Widget _iconBack() => GestureDetector(
        onTap: Get.back,
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          child: Padding(
            padding: EdgeInsets.only(left: 4.0.w),
            child: SizedBox(
              child: SvgPicture.asset(
                "assets/svg/back.svg",
                color: AppThemeController.to.appBarItemsColor,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      );

  Widget _accountIcon() => SvgPicture.asset(
        "assets/svg/account_active.svg",
        height: 24.h,
        color: AppThemeController.to.appBarItemsColor,
        width: 24.w,
      );

  Widget _body() => Obx(
        () => FavoriteController.to.favoriteCars.isEmpty
            ? _emptyFavoriteCars()
            : _favoriteCarsView(),
      );

  Widget _emptyFavoriteCars() => Center(
        child: Text(
          "💔🚗",
          style: TextStyle(fontSize: 40.fs),
        ),
      );

  Widget _favoriteCarsView() => Obx(
        () => ListView.builder(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          itemCount: FavoriteController.to.favoriteCars.length,
          itemBuilder: (context, index) =>
              CatalogTile(car: FavoriteController.to.favoriteCars[index]),
        ),
      );
}
