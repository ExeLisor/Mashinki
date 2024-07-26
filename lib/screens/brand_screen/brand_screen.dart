import 'package:autoverse/exports.dart';

class MarksScreen extends StatelessWidget {
  const MarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //alpabet gets smaller if resize set to true
      resizeToAvoidBottomInset: false,

      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TopBar(title: 'Бренды'),
            const CarsSearchBar(
              isActiveButton: false,
            ),
            SizedBox(
              height: 20.h,
            ),
            _marksScreenBody()
          ],
        ),
      ),
    );
  }

  Widget _marksScreenBody() => GetBuilder<MarksSearchController>(
        builder: (controller) => controller.query.isNotEmpty
            ? Expanded(
                child: ListView(
                  children: [BrandGrid(brands: controller.results)],
                ),
              )
            : _aplhabet(),
      );

  AppBar _appBar() => AppBar(
        toolbarHeight: 0.h,
      );

  Widget _aplhabet() => Expanded(
        child: GetBuilder<MarksController>(
          builder: (controller) => AlphabetListView(
            options: AlphabetListViewOptions(
              listOptions: ListOptions(
                stickySectionHeader: false,
                padding: EdgeInsets.zero,
                topOffset: 0,
                listHeaderBuilder: (context, symbol) => Padding(
                  padding: EdgeInsets.only(bottom: 12.0.h),
                  child: Row(
                    children: [
                      if (symbol != '☆')
                        Expanded(
                          child: Divider(
                            color: const Color(0xff7974FF).withOpacity(0.5),
                            thickness: 1,
                          ),
                        ),
                      Text(
                        symbol == '☆' ? 'Популярные бренды' : symbol,
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: symbol == '☆' ? 16.fs : 25.fs),
                      ),
                      if (symbol != '☆')
                        Expanded(
                          child: Divider(
                            color: const Color(0xff7974FF).withOpacity(0.5),
                            thickness: 1,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              scrollbarOptions: ScrollbarOptions(
                symbols: alphabet,
                padding: EdgeInsets.all(5.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
              ),
              overlayOptions: OverlayOptions(
                showOverlay: true,
                overlayBuilder: (context, symbol) => Container(
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    symbol,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.fs,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            items: controller.aplphabetList,
          ),
        ),
      );
}
