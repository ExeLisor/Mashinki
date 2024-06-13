import 'package:flutter_svg/flutter_svg.dart';
import 'package:mashinki/exports.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String icon;

  CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.icon = '',
  });

  final TextFieldController _textFieldController =
      Get.put(TextFieldController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342.w,
      height: 55.h,
      child: Obx(() => TextFormField(
            controller: controller,
            style: TextStyle(
                color: Theme.of(context).inputDecorationTheme.hintStyle!.color),
            keyboardType: keyboardType,
            obscureText: _textFieldController.obscureText.value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.h),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.h),
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .border!
                        .borderSide
                        .color),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.h),
                borderSide: BorderSide(
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .border!
                        .borderSide
                        .color),
              ),
              hintText: hint,
              prefixIcon: SvgPicture.asset(
                
                icon,
                width: 16.w,
                height: 20.h,
                fit: BoxFit.scaleDown,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _textFieldController.obscureText.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Theme.of(context).inputDecorationTheme.iconColor,
                      ),
                      onPressed: _textFieldController.togglePasswordVisibility,
                    )
                  : null,
            ),
          )),
    );
  }
}
