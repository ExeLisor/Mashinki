import 'package:mashinki/exports.dart';

class CarsSearchBar extends StatelessWidget {
  const CarsSearchBar({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarsSearchTextField(
          isActive: isActive,
        ),
        _filtersIcon()
      ],
    );
  }

  Widget _filtersIcon() => isActive
      ? Container(
          height: 48.h,
          width: 48.h,
          padding: EdgeInsets.symmetric(horizontal: 17.w),
          decoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 5.h), // changes position of shadow
              ),
            ],
          ),
          child: SvgPicture.asset(
            filtersIconAsset,
            fit: BoxFit.scaleDown,
          ),
        )
      : Container();
}

class CarsSearchTextField extends StatelessWidget {
  const CarsSearchTextField({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isActive ? 296.w : 362.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xfffef7ff),
        borderRadius: BorderRadius.circular(41),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5.h), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        enabled: isActive,
        textAlignVertical: TextAlignVertical.bottom,
        autovalidateMode: AutovalidateMode.always,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(41),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(41),
            borderSide: BorderSide(
                color: Theme.of(context)
                    .inputDecorationTheme
                    .border!
                    .borderSide
                    .color),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(41),
            borderSide: BorderSide(
                color: Theme.of(context)
                    .inputDecorationTheme
                    .border!
                    .borderSide
                    .color),
          ),
          hintText: "Поиск",
          hintStyle: TextStyle(fontSize: 18.fs, color: Colors.grey),
          prefixIcon: const SvgIcon(assetPath: lensIcon),
        ),
      ),
    );
  }
}
