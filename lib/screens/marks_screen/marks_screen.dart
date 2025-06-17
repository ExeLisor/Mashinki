import 'package:autoverse/exports.dart';

class MarksScreen extends StatelessWidget {
  const MarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeController.to.whiteColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: _bottomBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _appBar(),
            SizedBox(height: 5.h),
            _searchBar(),
            SizedBox(height: 20.h),
            _marksScreenBody(),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() =>
      CarsSearchBar(showFilters: false, controller: MarksSearchController.to);

  Widget _bottomBar() => HomeScreenBottomBarWidget();

  AppBar _appBar() => AppBar(
        backgroundColor: AppThemeController.to.whiteColor,
        title: _appBarText(),
        leading: _iconBack(),
        actions: [_accountIcon(), SizedBox(width: 25.w)],
      );

  Widget _appBarText() => Text(
        'marks'.tr,
        style: TextStyle(
          color: AppThemeController.to.appBarItemsColor,
          fontSize: 20.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
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

  Widget _marksScreenBody() => GetBuilder<MarksSearchController>(
        builder: (controller) => controller.query.isNotEmpty
            ? _searchingResults(controller.results)
            : const AlphabetWidget(),

        // : _recentSearch(),
      );

  Widget _searchingResults(List<Mark> result) => Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(
            child: MarksGrid(marks: result),
          ),
        ),
      );

  Widget _recentSearch() => ListView.builder(
        shrinkWrap: true,
        itemCount: MarksSearchController.to.recentSearch.length,
        itemBuilder: (context, index) =>
            _recentSearchTile(MarksSearchController.to.recentSearch[index]),
      );

  Widget _recentSearchTile(String request) => GestureDetector(
        onTap: () => MarksSearchController.to.startSearchFromRecent(request),
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _recentTitle(request),
                    SvgPicture.asset(
                      crossIcon,
                      color: primaryColor,
                      height: 20.h,
                      width: 20.h,
                    )
                  ],
                ),
                const Divider(
                  color: paleColor,
                )
              ],
            ),
          ),
        ),
      );
  Widget _recentTitle(String request) => Row(
        children: [
          SvgPicture.asset(
            recentIcon,
            color: primaryColor,
            height: 24.h,
            width: 24.h,
          ),
          SizedBox(
            width: 17.h,
          ),
          Text(
            request,
            style: TextStyle(
                fontSize: 16.fs,
                fontWeight: FontWeight.normal,
                color: blackColor),
          ),
        ],
      );
}
