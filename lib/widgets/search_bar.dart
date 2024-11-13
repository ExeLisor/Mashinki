import 'package:autoverse/exports.dart';

abstract class SearchFieldController extends GetxController {
  void clearSearch();
  void startSearch(String query);
  TextEditingController get controller;
}

class CarsSearchBar<T extends SearchFieldController> extends StatelessWidget {
  const CarsSearchBar(
      {super.key,
      this.isActive = true,
      this.showFilters = true,
      this.searchIconColor = blackColor,
      this.controller,
      this.filterAction});

  final bool isActive;
  final bool showFilters;
  final Color searchIconColor;
  final T? controller;
  final VoidCallback? filterAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Row(
        children: [_searchContainer(), _filterButton()],
      ),
    );
  }

  Widget _filterButton() => showFilters
      ? Row(
          children: [
            SizedBox(width: 15.w),
            _iconContainer(),
          ],
        )
      : Container();

  Widget _filterIcon() => GestureDetector(
        onTap: filterAction,
        child: SizedBox(
          height: 48.h,
          width: 48.h,
          child: SvgPicture.asset(
            "assets/svg/filters.svg",
            height: 48.h,
            width: 48.h,
            fit: BoxFit.scaleDown,
          ),
        ),
      );

  Widget _iconContainer() => Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(41),
          boxShadow: const [
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
        child: _filterIcon(),
      );

  Widget _searchContainer() => Container(
        height: 48.h,
        width: showFilters ? 298.w : 362.w,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(41),
          boxShadow: const [
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
        child: _searchField(),
      );

  Widget _searchField() => TextField(
        enabled: false,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: decoration(),
      );

  InputDecoration decoration() => InputDecoration(
        // suffixIcon: showFilters ? _filtersIcon() : null,
        filled: true,
        fillColor: whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        hintText: 'search'.tr,
        hintStyle: TextStyle(
            fontSize: 16.fs,
            fontWeight: FontWeight.w400,
            fontFamily: "Inter",
            height: 0,
            color: unactiveColor),
        prefixIcon: SvgPicture.asset(
          'assets/svg/zoom.svg',
          height: 22.h,
          width: 20.w,
          fit: BoxFit.scaleDown,
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 12.h), // Adjust padding to center hint text
      );

  Widget _filtersIcon() => GestureDetector(
        onTap: filterAction,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SvgPicture.asset(
            filtersIconAsset,
            height: 22.h,
            width: 20.w,
            fit: BoxFit.scaleDown,
            color: primaryColor,
          ),
        ),
      );
}
