import 'package:mashinki/exports.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  List<Brand> brandList = [];
  List<Brand> popularBrands = [];

  @override
  void initState() {
    super.initState();
    brandList = getBrandList();
    popularBrands = getPopularBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 35.w, top: 46.h, right: 25.w),
            child: const TopBar(title: 'Бренды'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.w, top: 25.h),
            child: const CarsSearchBar(
              isActive: true,
              isActiveButton: false,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
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
                                color: Color(0xff4038FF),
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
          )
        ],
      ),
    );
  }

  List<AlphabetListViewItemGroup> _buildBrandItems() {
    List<AlphabetListViewItemGroup> itemGroups = [];

    itemGroups.add(
      AlphabetListViewItemGroup(
        tag: '☆',
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: BrandGrid(
              brands: popularBrands,
            ),
          )
        ],
      ),
    );

    Map<String, List<Brand>> groupedBrands = {};
    for (var brand in brandList) {
      String key = brand.name[0].toUpperCase();
      if (!groupedBrands.containsKey(key)) {
        groupedBrands[key] = [];
      }
      groupedBrands[key]!.add(brand);
    }

    groupedBrands.forEach((key, brands) {
      itemGroups.add(
        AlphabetListViewItemGroup(
          tag: key,
          children: [
            BrandGrid(
              brands: brands,
            ),
          ],
        ),
      );
    });

    return itemGroups;
  }

  List<Brand> getBrandList() {
    return [
      Brand(
          name: 'Audi',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'BMW',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Chevrolet',
          brandLogo:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3jLdiRIffyVvYjJSgZqFzc73YJSfqcRbR6Q&s'),
      Brand(
          name: 'Dodge',
          brandLogo:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3jLdiRIffyVvYjJSgZqFzc73YJSfqcRbR6Q&s'),
      Brand(
          name: 'Ford',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Tesla_T_symbol.svg/640px-Tesla_T_symbol.svg.png'),
      Brand(
          name: 'Honda',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Jaguar',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Kia',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Lexus',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Mazda',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Nissan',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Opel',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Peugeot',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Renault',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Skoda',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Toyota',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Volkswagen',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Volvo',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
    ];
  }

  List<Brand> getPopularBrands() {
    return [
      Brand(
          name: 'Tesla',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Toyota',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
      Brand(
          name: 'Honda',
          brandLogo:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo.svg/2048px-Mercedes-Logo.svg.png'),
    ];
  }
}
