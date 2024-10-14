import 'package:autoverse/exports.dart';

class ModelSelectorWidget extends StatelessWidget {
  const ModelSelectorWidget({super.key});

  static FilterController controller = FilterController.to;

  @override
  Widget build(BuildContext context) =>
      Container(margin: EdgeInsets.only(bottom: 22.h), child: Container()
          // _selectorsList(),
          );

  // Widget _selectorsList() => Obx(() => Column(children: [
  //       ...List.generate(controller.getFilterModel.configurations.length,
  //           (index) => _selectorBloc())
  //     ]));

  Widget _selectorBloc() => Container(
        margin: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xffF5F4FF),
        ),
        child: const Column(
          children: [MarkSelectField(), ModelSelectorField()],
        ),
      );
}

class MarkSelectField extends StatefulWidget {
  const MarkSelectField({super.key});

  @override
  State<MarkSelectField> createState() => _MarkSelectFieldState();
}

class _MarkSelectFieldState extends State<MarkSelectField> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        // onTap: () => FilterController.to
        //     .addConfiguration(FilterModelConfiguration(markName: "Audi")),
        child: Container(
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  'Марка',
                  style: TextStyle(
                    color: const Color(0xFF848484),
                    fontSize: 16.fs,
                    fontWeight: FontWeight.w400,
                    height: 0.08,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class ModelSelectorField extends StatefulWidget {
  const ModelSelectorField({super.key});

  @override
  State<ModelSelectorField> createState() => _ModelSelectorFieldState();
}

class _ModelSelectorFieldState extends State<ModelSelectorField> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        // onTap: () => FilterController.to
        //     .addConfiguration(FilterModelConfiguration(markName: "Audi")),
        child: Container(
          height: 50.h,
          margin: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 13.h),
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Text(
                  'Модель',
                  style: TextStyle(
                    color: const Color(0xFF848484),
                    fontSize: 16.fs,
                    fontWeight: FontWeight.w400,
                    height: 0.08,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
