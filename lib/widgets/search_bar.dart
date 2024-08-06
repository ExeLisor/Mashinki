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
      this.isActiveButton = true,
      this.controller});

  final bool isActive;
  final bool isActiveButton;
  final T? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h, left: 25.w, right: 25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CarsSearchTextField<T>(
            isActive: isActive,
            isActiveButton: isActiveButton,
            controller: controller,
          ),
          _filtersIcon()
        ],
      ),
    );
  }

  Widget _filtersIcon() => isActiveButton
      ? Container(
          height: 48.h,
          width: 48.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: SvgPicture.asset(
            filtersIconAsset,
            height: 22.h,
            width: 22.w,
            fit: BoxFit.scaleDown,
          ),
        )
      : Container();
}

class CarsSearchTextField<T extends SearchFieldController>
    extends StatelessWidget {
  const CarsSearchTextField(
      {super.key,
      required this.isActive,
      required this.isActiveButton,
      this.controller});

  final bool isActive;
  final bool isActiveButton;
  final T? controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: isActiveButton ? 296.w : 362.w,
        height: 48.h,
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
        child: GetBuilder<T>(
          dispose: (_) => controller?.clearSearch(),
          builder: (controller) => TextFormField(
            enabled: isActive,
            controller: controller.controller,
            textAlignVertical: TextAlignVertical.bottom,
            autovalidateMode: AutovalidateMode.always,
            onChanged: controller.startSearch,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
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
            ),
          ),
        ),
      ),
    );
  }
}
