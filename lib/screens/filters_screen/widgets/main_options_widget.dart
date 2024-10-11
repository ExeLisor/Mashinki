import 'package:autoverse/exports.dart';

class MainOptionsWidget extends StatelessWidget {
  const MainOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 22.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _title(),
          _container(
              child: Column(
            children: [
              _selectors(),
              _chips(),
              _range(),
            ],
          )),
        ],
      ),
    );
  }

  Widget _selectors() => const Column(
        children: [
          MainOptionSelector(text: "Кузов"),
          MainOptionSelector(text: "Коробка"),
          MainOptionSelector(text: "Двигатель"),
        ],
      );

  Widget _chips() => Container(
        margin: EdgeInsets.only(top: 28.h),
        child: const Column(
          children: [
            MainOptionsChips(
              title: "Привод",
              chips: ["Передний", "Задний", "Полный"],
            ),
            MainOptionsChips(
              title: "Руль",
              chips: ["Левый", "Правый"],
            ),
            MainOptionsChips(
              title: "Кол-во мест",
              chips: ["1", "2", "3", "4", "5", "6", "7"],
              roundChips: true,
            ),
          ],
        ),
      );

  Widget _range() => const Column(
        children: [
          MainOptionsRangeWidget(
            title: "Объём двигателя, л",
          ),
          MainOptionsRangeWidget(
            title: "Мощность, л.с.",
          ),
          MainOptionsRangeWidget(
            title: "Разгон до 100 км/ч, (с)",
          ),
          MainOptionsRangeWidget(
            title: "Год выпуска",
          ),
        ],
      );

  Widget _title() => Container(
        margin: EdgeInsets.only(bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Основные параметры',
              style: TextStyle(
                color: const Color(0xFF4038FF),
                fontSize: 14.fs,
                fontWeight: FontWeight.w600,
                height: 0.10,
              ),
            )
          ],
        ),
      );

  Widget _container({required Widget child}) => Container(
      margin: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 0.h),
      padding: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xffF5F4FF),
      ),
      child: child);
}

class MainOptionSelector extends StatelessWidget {
  const MainOptionSelector({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 0.h),
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
              text,
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
    );
  }
}

class MainOptionsChips extends StatelessWidget {
  const MainOptionsChips(
      {super.key,
      required this.title,
      required this.chips,
      this.roundChips = false});

  final String title;
  final List<String> chips;
  final bool roundChips;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(height: 18.h),
          _chips(),
        ],
      ),
    );
  }

  Widget _chips() => Row(
        mainAxisAlignment: chips.length < 3
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: List.generate(
            chips.length,
            (index) =>
                roundChips ? _roundedChip(chips[index]) : _chip(chips[index])),
      );

  Widget _title() => Container(
        margin: EdgeInsets.only(left: 9.w),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF4038FF),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 0.08,
          ),
        ),
      );

  Widget _chip(String value) => Container(
        height: 36.h,
        padding: chips.length > 5
            ? EdgeInsets.all(10.h)
            : EdgeInsets.symmetric(horizontal: 22.w),
        margin: chips.length < 3 ? EdgeInsets.only(right: 10.w) : null,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xFF4038FF),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8700000047683716),
                fontSize: 16.fs,
                fontWeight: FontWeight.w400,
                height: 0.08,
              ),
            ),
          ],
        ),
      );

  Widget _roundedChip(String value) => Container(
        width: 36.w,
        height: 36.w,
        margin: chips.length < 3 ? EdgeInsets.only(right: 10.w) : null,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xFF4038FF),
          ),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8700000047683716),
                fontSize: 16.fs,
                fontWeight: FontWeight.w400,
                height: 0.08,
              ),
            ),
          ],
        ),
      );
}

class MainOptionsRangeWidget extends StatelessWidget {
  const MainOptionsRangeWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_title(), SizedBox(height: 18.h), _rangeWidget()],
      ),
    );
  }

  Widget _title() => Container(
        margin: EdgeInsets.only(left: 9.w),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF4038FF),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 0.08,
          ),
        ),
      );

  Widget _rangeWidget() => Row(
        children: [
          _rangeContainer("От"),
          Container(
            width: 10,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFF4038FF),
                ),
              ),
            ),
          ),
          _rangeContainer("До"),
        ],
      );

  Widget _rangeContainer(String text) => Container(
        height: 40.h,
        width: 160.w,
        padding: EdgeInsets.only(left: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                  color: const Color(0xFF848484),
                  fontSize: 16.fs,
                  fontWeight: FontWeight.w400,
                  height: 0.08,
                )),
          ],
        ),
      );
}
