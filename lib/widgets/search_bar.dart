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
      this.controller,
      this.filterAction});

  final bool isActive;
  final bool showFilters;
  final T? controller;
  final VoidCallback? filterAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 48.h,
        margin: EdgeInsets.only(bottom: 20.h, left: 25.w, right: 25.w),
        decoration: BoxDecoration(
          color: const Color(0xfffef7ff),
          borderRadius: BorderRadius.circular(41),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: controller == null
            ? TextField(
                enabled: false,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: decoration(),
              )
            : GetBuilder<T>(
                dispose: (_) => controller?.clearSearch(),
                builder: (controller) => TextField(
                  enabled: isActive,
                  controller: controller.controller,
                  textAlignVertical: TextAlignVertical.bottom,
                  // autovalidateMode: AutovalidateMode.always,
                  onChanged: controller.startSearch,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  decoration: decoration(),
                ),
              ),
      ),
    );
  }

  InputDecoration decoration() => InputDecoration(
        suffixIcon: showFilters ? _filtersIcon() : null,
        filled: true,
        fillColor: Colors.white,
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
        hintText: "Поиск",
        hintStyle: TextStyle(fontSize: 18.fs, color: Colors.grey),
        prefixIcon: SvgPicture.asset(
          lensIcon,
          height: 22.h,
          width: 20.w,
          fit: BoxFit.scaleDown,
        ),
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
