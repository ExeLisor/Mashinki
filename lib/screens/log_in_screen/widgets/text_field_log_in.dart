import 'package:flutter_svg/flutter_svg.dart';
import 'package:autoverse/exports.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool showPassword;
  final String icon;
  final Widget? suffixIcon;
  final Function(String text)? onFieldSubmitted;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.showPassword = false,
    this.icon = '',
    this.suffixIcon,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342.w,
      height: 55.h,
      child: TextFormField(
        controller: controller,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        autovalidateMode: AutovalidateMode.always,
        onFieldSubmitted: (_) =>
            onFieldSubmitted == null ? (_) : onFieldSubmitted!(_),
        keyboardType: keyboardType,
        obscureText: isPassword && !showPassword ? true : false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Theme.of(context)
                    .inputDecorationTheme
                    .border!
                    .borderSide
                    .color),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Theme.of(context)
                    .inputDecorationTheme
                    .border!
                    .borderSide
                    .color),
          ),
          hintText: hint,
          prefixIcon: SvgIcon(assetPath: icon),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

class SvgIcon extends StatelessWidget {
  const SvgIcon({super.key, required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.h),
      child: SizedBox(
        child: SvgPicture.asset(
          assetPath,
          height: 4.h,
          width: 4.h,
        ),
      ),
    );
  }
}
