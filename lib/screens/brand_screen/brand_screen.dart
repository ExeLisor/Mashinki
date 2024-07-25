import 'package:autoverse/exports.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  // List<Brand> brandList = [];
  // List<Brand> popularBrands = [];

  @override
  void initState() {
    super.initState();
  }

  AppBar _appBar() => AppBar(
        toolbarHeight: 0.h,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TopBar(title: 'Бренды'),
            const CarsSearchBar(
              isActive: true,
              isActiveButton: false,
            ),
            SizedBox(
              height: 20.h,
            ),
            _aplhabet(),
          ],
        ),
      ),
    );
  }

  Widget _aplhabet() => Expanded(
        child: AlphabetListView(
          options: AlphabetListViewOptions(
            listOptions: ListOptions(
              stickySectionHeader: false,
              padding: EdgeInsets.zero,
              topOffset: 0,
              listHeaderBuilder: (context, symbol) => Padding(
                padding: EdgeInsets.only(
                  left: 25.w,
                  right: 25.w,
                ),
                child: Row(
                  children: [
                    if (symbol != '☆')
                      Expanded(
                        child: Divider(
                          color: const Color(0xff7974FF).withOpacity(0.5),
                          thickness: 1,
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.h,
                      ),
                      child: Text(
                        symbol == '☆' ? 'Популярные марки авто' : symbol,
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
                ),
              ),
            ),
            scrollbarOptions: const ScrollbarOptions(
              symbols: alphabet,
              backgroundColor: Colors.white,
            ),
            overlayOptions: OverlayOptions(
              showOverlay: true,
              overlayBuilder: (context, symbol) => Container(
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
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
          items: _buildBrandItems(),
        ),
      );

  List<AlphabetListViewItemGroup> _buildBrandItems() {
    List<AlphabetListViewItemGroup> itemGroups = [];

    itemGroups.add(
      AlphabetListViewItemGroup(
        tag: '☆',
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: const BrandGrid(
              popular: true,
            ),
          )
        ],
      ),
    );

    Map<String, List<Mark>> groupedBrands = {};
    for (var brand in MarksController.to.marks) {
      String key = brand.name![0].toUpperCase();
      if (!groupedBrands.containsKey(key)) {
        groupedBrands[key] = [];
      }
      groupedBrands[key]!.add(brand);
    }

    groupedBrands.forEach(
      (key, brands) {
        itemGroups.add(
          AlphabetListViewItemGroup(
            tag: key,
            children: [
              const BrandGrid(
                popular: false,
              ),
            ],
          ),
        );
      },
    );

    return itemGroups;
  }
}
