import 'package:autoverse/exports.dart';

class RegistrationErrorWidget extends StatelessWidget {
  const RegistrationErrorWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: SizedBox(
                width: 342.w,
                child: Text(
                  text,
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 12.fs, color: const Color(0xffff4141)),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ],
    );
  }
}
