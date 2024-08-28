import 'package:autoverse/exports.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _topBar(),
      bottomNavigationBar: HomeScreenBottomBarWidget(),
      body: _body(),
    );
  }

  PreferredSize _topBar() => PreferredSize(
        preferredSize: Size.fromHeight(82.h),
        child: const TopBar(
          title: "Избранное",
          isHomeScreen: false,
          disableVerticalPadding: true,
          showShadow: false,
        ),
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
          padding: EdgeInsets.only(left: 25.w),
          itemCount: FavoriteController.to.favoriteCars.length,
          itemBuilder: (context, index) =>
              FavoriteTile(car: FavoriteController.to.favoriteCars[index]),
        ),
      );
}
