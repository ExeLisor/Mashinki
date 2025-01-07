import 'package:autoverse/exports.dart';
import 'package:autoverse/models/alphabet.dart';

class AlphabetWidget extends StatelessWidget {
  const AlphabetWidget({super.key, this.isSelect = false});

  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _alphabet(),
          _body(),
        ],
      ),
    );
  }

  Widget _alphabet() => AlphabetRow(
        controller: AlphabetMarksController.to,
        alphabet: alphabet,
      );

  Widget _divider() => Expanded(
        child: Divider(
          color: paleColor.withOpacity(0.5),
          thickness: 1,
        ),
      );

  Widget _headerText(String symbol) => Padding(
        padding: EdgeInsets.symmetric(horizontal: symbol == '#' ? 0 : 12.0.h),
        child: Text(
          symbol == '#' ? 'popular-marks'.tr : symbol,
          style: TextStyle(
              color:
                  AppThemeController.to.isDarkTheme ? whiteColor : primaryColor,
              fontWeight: FontWeight.w500,
              fontSize: symbol == '#' ? 16.fs : 25.fs),
        ),
      );

  Widget _header(String symbol) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
        child: Row(
          children: [
            if (symbol != '#') _divider(),
            _headerText(symbol),
            if (symbol != '#') _divider(),
          ],
        ),
      );

  Widget _body() => Obx(() => Expanded(
      child: ScrollablePositionedList.builder(
          itemScrollController: AlphabetMarksController.to.itemScrollController,
          itemPositionsListener:
              AlphabetMarksController.to.itemPositionsListener,
          itemCount: alphabet.length,
          itemBuilder: (context, index) => _alphabetGrid(index))));

  Widget _alphabetGrid(int index) => Obx(
        () => Column(
          children: [
            _header(alphabet[index]),
            (AlphabetMarksController.to.itemsList.isNotEmpty &&
                    index < AlphabetMarksController.to.itemsList.length)
                ? _marks(AlphabetMarksController.to.itemsList[index])
                : Container(),
          ],
        ),
      );

  Widget _marks(List<Mark> marks) =>
      MarksGrid(marks: marks, isSelect: isSelect);
}

class AlphabetRow extends StatelessWidget {
  const AlphabetRow(
      {super.key, required this.controller, required this.alphabet});

  final Color paleBlueColor = paleColor;
  final AlphabetController controller;
  final List<String> alphabet;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: 10.h),
        height: 36.h,
        child: ListView.builder(
          controller: controller.scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: alphabet.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return SizedBox(width: 12.5.w);

            return _alphabetTile(alphabet[index - 1], index - 1);
          },
        ),
      );

  Widget _alphabetTile(String symbol, int index) => GestureDetector(
        onTap: () => controller.scrollToIndex(index),
        child: Obx(
          () => Container(
            height: 36.h,
            width: 35.h,
            decoration: BoxDecoration(
                color: controller.highlightedIndex == index
                    ? paleBlueColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(7.h)),
            alignment: Alignment.center,
            child: Text(
              symbol,
              style: TextStyle(
                color: controller.highlightedIndex == index
                    ? whiteColor
                    : AppThemeController.to.isDarkTheme
                        ? whiteColor
                        : primaryColor,
                fontSize: 16.fs,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
}
