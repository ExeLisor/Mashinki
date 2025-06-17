import 'package:autoverse/exports.dart';

class AlphabetWidget extends StatelessWidget {
  const AlphabetWidget({super.key});

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

  Widget _alphabet() => const AlphabetRow();

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
          itemScrollController: AlphabetController.to.itemScrollController,
          itemPositionsListener: AlphabetController.to.itemPositionsListener,
          itemCount: alphabet.length,
          itemBuilder: (context, index) => _alphabetGrid(index))));

  Widget _alphabetGrid(int index) => Obx(
        () => Column(
          children: [
            _header(alphabet[index]),
            (AlphabetController.to.alphabetList.isNotEmpty &&
                    index < AlphabetController.to.alphabetList.length)
                ? _marks(AlphabetController.to.alphabetList[index])
                : Container(),
          ],
        ),
      );

  Widget _marks(List<Mark> marks) => MarksGrid(marks: marks);
}

class AlphabetRow extends StatelessWidget {
  const AlphabetRow({super.key});

  final Color paleBlueColor = paleColor;

  @override
  Widget build(BuildContext context) => _alphabet();

  Widget _alphabet() => SizedBox(
        height: 36.h,
        child: ListView(
          controller: AlphabetController.to.horizontalController,
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(width: 12.5.w),
            ...List.generate(alphabet.length,
                (index) => _alphabetTile(alphabet[index], index))
          ],
        ),
      );

  Widget _alphabetTile(String symbol, int index) => GestureDetector(
        onTap: () => AlphabetController.to.scrollToIndex(index),
        child: Obx(
          () => Container(
            height: 36.h,
            width: 35.h,
            decoration: BoxDecoration(
                color: AlphabetController.to.highlightedIndex == index
                    ? paleBlueColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(7.h)),
            alignment: Alignment.center,
            child: Text(
              symbol,
              style: TextStyle(
                color: AlphabetController.to.highlightedIndex == index
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
