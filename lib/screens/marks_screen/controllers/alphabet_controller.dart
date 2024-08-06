import 'package:autoverse/exports.dart';

class AlphabetController extends GetxController {
  static AlphabetController get to => Get.find();

  final Rx<ScrollController> _horizontalController = ScrollController().obs;
  final Rx<ItemScrollController> _itemScrollController =
      ItemScrollController().obs;
  final Rx<ItemPositionsListener> _itemPositionsListener =
      ItemPositionsListener.create().obs;

  final RxList<List<Mark>> _alphabetList = <List<Mark>>[].obs;
  final RxInt _highlightedIndex = 0.obs;

  ScrollController get horizontalController => _horizontalController.value;
  ItemScrollController get itemScrollController => _itemScrollController.value;
  ItemPositionsListener get itemPositionsListener =>
      _itemPositionsListener.value;
  List<List<Mark>> get alphabetList => _alphabetList;
  int get highlightedIndex => _highlightedIndex.value;

  @override
  void onInit() {
    super.onInit();
    itemPositionsListener.itemPositions.addListener(_updateHighlightedIndex);
    initAlphabetList();
  }

  @override
  void dispose() {
    horizontalController.dispose();
    itemPositionsListener.itemPositions.removeListener(_updateHighlightedIndex);
    super.dispose();
  }

  void _updateHighlightedIndex() {
    final visibleItems = itemPositionsListener.itemPositions.value;
    if (visibleItems.isNotEmpty) {
      final firstVisibleItem = visibleItems.first;
      if (firstVisibleItem.index != highlightedIndex) {
        _highlightedIndex.value = firstVisibleItem.index;
      }
    }
  }

  void initAlphabetList() {
    List<Mark> popularMarks = _getPopularMarks();
    _alphabetList.add(popularMarks);
    List<List<Mark>> groupedMarks = _getGroupedMarks();
    _alphabetList.addAll(groupedMarks);
    return;
  }

  List<List<Mark>> _getGroupedMarks() {
    Map<String, List<Mark>> groupedBrands = {};
    List<Mark> brands = _getAllMarks();
    List<String> keys = [];

    for (var brand in brands) {
      String key = brand.id![0].toUpperCase();

      if (!groupedBrands.containsKey(key)) {
        keys.add(key);
        groupedBrands[key] = [];
      }
      groupedBrands[key]!.add(brand);
    }

    // Преобразуем Map в List<List<Mark>>
    List<List<Mark>> result = [];
    for (var group in groupedBrands.values) {
      result.add(group);
    }

    return result;
  }

  List<Mark> _getPopularMarks() => MarksController.to.popularMarks;

  List<Mark> _getAllMarks() => MarksController.to.marks;

  void scrollToIndex(int index) => itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
}

class AlphabetBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => AlphabetController());
}
