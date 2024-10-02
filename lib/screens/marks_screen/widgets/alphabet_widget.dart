import 'package:autoverse/exports.dart';

class AlphabetWidget extends StatelessWidget {
  const AlphabetWidget({super.key});
  final Color paleBlueColor = const Color(0xff7974FF);

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

  Widget _header(String symbol) => Row(
        children: [
          if (symbol != '☆')
            Expanded(
              child: Divider(
                color: const Color(0xff7974FF).withOpacity(0.5),
                thickness: 1,
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.h),
            child: Text(
              symbol == '☆' ? 'Популярные бренды' : symbol,
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: symbol == '☆' ? 16.fs : 25.fs),
            ),
          ),
          if (symbol != '☆')
            Expanded(
              child: Divider(
                color: const Color(0xff7974FF).withOpacity(0.5),
                thickness: 1,
              ),
            ),
        ],
      );

  Widget _alphabet() => Container(
        height: 33.h,
        margin: EdgeInsets.only(bottom: 20.h),
        child: ListView(
          controller: AlphabetController.to.horizontalController,
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              height: 33 - 8.h,
              width: 33 - 8.h,
            ),
            ...List.generate(alphabet.length,
                (index) => _alphabetTile(alphabet[index], index))
          ],
        ),
      );

  Widget _alphabetTile(String symbol, int index) => GestureDetector(
        onTap: () => AlphabetController.to.scrollToIndex(index),
        child: UnconstrainedBox(
          child: Obx(
            () => Container(
              height: 33.h,
              width: 33.h,
              margin: EdgeInsets.only(right: 13.w),
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
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      );
  Widget _body() => Obx(() => Expanded(
      child: ScrollablePositionedList.builder(
          itemScrollController: AlphabetController.to.itemScrollController,
          itemPositionsListener: AlphabetController.to.itemPositionsListener,
          itemCount: alphabet.length,
          padding: EdgeInsets.only(bottom: 25.h),
          itemBuilder: (context, index) => _alphabetGrid(index))));

  Widget _alphabetGrid(int index) => Obx(
        () => Container(
          margin: EdgeInsets.symmetric(horizontal: 17.w),
          child: Column(
            children: [
              _header(alphabet[index]),
              SizedBox(
                height: 20.h,
              ),
              AlphabetController.to.isLoading
                  ? const LoadingMarksGrid()
                  : MarksGrid(marks: AlphabetController.to.alphabetList[index])
            ],
          ),
        ),
      );
}
