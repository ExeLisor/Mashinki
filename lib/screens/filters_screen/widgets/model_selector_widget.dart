import 'package:autoverse/exports.dart';

class ModelSelectorWidget extends StatelessWidget {
  const ModelSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.w, 28.h, 15.w, 22.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffF5F4FF),
      ),
      child: Column(
        children: [_markField()],
      ),
    );
  }

  Widget _markField() => Container(
        height: 50.h,
        margin: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 13.h),
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Text(
                'Марка',
                style: TextStyle(
                  color: Color(0xFF848484),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 0.08,
                ),
              ),
            ),
          ],
        ),
      );
}
