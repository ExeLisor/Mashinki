import 'package:autoverse/exports.dart';

import 'package:autoverse/screens/filters_screen/models/main_options/main_options_list.dart';
import 'package:autoverse/screens/filters_screen/widgets/main_option_chips.dart';
import 'package:autoverse/screens/filters_screen/widgets/main_options_range.dart';
import 'package:autoverse/screens/filters_screen/widgets/main_options_selector.dart';

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
          _mainOptions(),
        ],
      ),
    );
  }

  Widget _mainOptions() => _container(
          child: Container(
        margin: EdgeInsets.only(top: 22.h),
        child: Column(
          children: List.generate(
            mainOptions.length,
            (index) {
              final mainOption = mainOptions[index];
              if (mainOption.type == "selector") {
                return MainOptionSelector(
                  mainOption: mainOption,
                );
              } else if (mainOption.type == "chips") {
                return MainOptionsChips(
                  mainOption: mainOption,
                );
              } else if (mainOption.type == "range") {
                return MainOptionsRangeWidget(
                    title: mainOption.title, field: mainOption.field);
              }
              return Container();
            },
          ),
        ),
      ));

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
