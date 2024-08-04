import 'package:autoverse/exports.dart';

class SpecsBlockWidget extends StatelessWidget {
  const SpecsBlockWidget({super.key, required this.title, required this.specs});

  final String title;
  final List specs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _divider(),
        SizedBox(
          height: 20.h,
        ),
        _specsTitle(title),
        SizedBox(
          height: 20.h,
        ),
        ...specs.map(
          (spec) => _specsWidget(
            spec.keys.first,
            spec[spec.keys.first],
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }

  Widget _divider() => const Divider(
        color: primaryColor,
      );

  Widget _specsTitle(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.fs,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _specsWidget(String specs, String value) => Padding(
        padding: EdgeInsets.only(right: 25.w, bottom: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200.w,
              child: Text(
                '$specs:',
                maxLines: 2,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14.fs,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: 140.w,
              child: Text(
                value,
                textAlign: TextAlign.right,
                softWrap: true, // разрешаем переносить текст
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.fs,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      );
}
