import 'package:autoverse/exports.dart';

class SelectMarksScreen extends GetView<MarkSelectController> {
  const SelectMarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppThemeController.to.whiteColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: _bottomBar(),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _appBar(),
                SizedBox(height: 5.h),
                _searchBar(),
                SizedBox(height: 20.h),
                _marksScreenBody(),
              ],
            ),
            _selectButtons()
          ],
        ),
      ),
    );
  }

  Widget _selectButtons() => Obx(
        () => controller.selectedMarks.isNotEmpty
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _clearButton(),
                    SizedBox(width: 8.w),
                    _applyButton()
                  ],
                ),
              )
            : Container(),
      );

  Widget _clearButton() => _button(
      'Сбросить'.tr,
      AppThemeController.to.searchContainerColor,
      AppThemeController.to.appBarItemsColor,
      controller.clear);

  Widget _applyButton() =>
      _button('Применить'.tr, paleColor, Colors.white, controller.addMarks);

  Widget _button(String text, Color buttonColor, Color textColor,
          VoidCallback? onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          width: 165.w,
          height: 44.h,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: const [
              BoxShadow(
                color: boxShadowColor,
                blurRadius: 15,
                offset: Offset(-1, 10),
                spreadRadius: 2,
              ),
              BoxShadow(
                color: boxShadowColor,
                blurRadius: 15,
                offset: Offset(1, 1),
                spreadRadius: 2,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15.fs,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      );

  Widget _searchBar() => CarsSearchBar(
        showFilters: false,
        controller: MarksSearchController.to,
        isDevelop: false,
      );

  Widget _bottomBar() => HomeScreenBottomBarWidget();

  AppBar _appBar() => AppBar(
        backgroundColor: AppThemeController.to.whiteColor,
        title: _appBarText(),
        leading: _iconBack(),
        actions: [_accountIcon(), SizedBox(width: 25.w)],
      );

  Widget _appBarText() => Column(
        children: [
          Text(
            'marks'.tr,
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

  Widget _marksScreenBody() => GetBuilder<MarksSearchController>(
        builder: (controller) => controller.query.isNotEmpty
            ? controller.isSearching
                ? _loadingWidget()
                : _searchingResults(controller.results)
            : const AlphabetWidget(isSelect: true),
      );
  Widget _loadingWidget() =>
      const Expanded(child: Center(child: CircularProgressIndicator()));

  Widget _searchingResults(List<Mark> result) => Expanded(
        child: result.isEmpty
            ? Center(child: Text("🚗❓🤷‍♂️", style: TextStyle(fontSize: 40.fs)))
            : SingleChildScrollView(
                child: MarksGrid(
                  marks: result,
                  isSelect: true,
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

class MarkSelectController extends GetxController {
  static MarkSelectController get to => Get.find();

  final RxList<Mark> _selectedMarks = <Mark>[].obs;
  List<Mark> get selectedMarks => _selectedMarks;

  @override
  void onInit() {
    ever(_selectedMarks, (_) => update());
    super.onInit();
  }

  bool checkMark(Mark mark) =>
      _selectedMarks.any((element) => element.id == mark.id);

  void actionWithMark(Mark mark) =>
      checkMark(mark) ? removeMark(mark) : addMark(mark);

  void addMark(Mark mark) => _selectedMarks.add(mark);

  void removeMark(Mark mark) =>
      _selectedMarks.removeWhere((element) => element.id == mark.id);

  void clear() => _selectedMarks.clear();

  void addMarks() {
    Get.back();
  }
}

void navgiteToSelectMarks() {
  Get.put(MarkSelectController());
  MarksSearchController.to.clearSearch();

  Get.toNamed('/selectMarks');
}
