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
          color: const Color(0xff7974FF).withOpacity(0.5),
          thickness: 1,
        ),
      );

  Widget _headerText(String symbol) => Padding(
        padding: EdgeInsets.symmetric(horizontal: symbol == '#' ? 0 : 12.0.h),
        child: Text(
          symbol == '#' ? 'Популярные бренды' : symbol,
          style: TextStyle(
              color: primaryColor,
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
            _marks(AlphabetController.to.alphabetList[index]),

            // AlphabetController.to.isLoading
            //     ? const LoadingMarksGrid()
            //     :
          ],
        ),
      );

  Widget _marks(List<Mark> marks) => MarksGrid(marks: marks);
}

class AlphabetRow extends StatelessWidget {
  const AlphabetRow({super.key});

  final Color paleBlueColor = const Color(0xff7974FF);

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
                    ? Colors.white
                    : primaryColor,
                fontSize: 16.fs,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
}
