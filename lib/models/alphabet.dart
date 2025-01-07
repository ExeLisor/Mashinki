import 'package:autoverse/exports.dart';

abstract class AlphabetController<T> extends GetxController {
  final Rx<ScrollController> _scrollController = ScrollController().obs;
  final Rx<ItemScrollController> _itemScrollController =
      ItemScrollController().obs;
  final Rx<ItemPositionsListener> _itemPositionsListener =
      ItemPositionsListener.create().obs;

  final RxList<List<T>> _itemsList = <List<T>>[].obs;
  final RxInt _highlightedIndex = 0.obs;
  final RxBool _isLoading = true.obs;

  // Геттеры для общих данных
  bool get isLoading => _isLoading.value;
  ScrollController get scrollController => _scrollController.value;
  ItemScrollController get itemScrollController => _itemScrollController.value;
  ItemPositionsListener get itemPositionsListener =>
      _itemPositionsListener.value;
  List<List<T>> get itemsList => _itemsList;
  int get highlightedIndex => _highlightedIndex.value;

  set isLoading(bool value) => _isLoading.value = value;
  set highlightedIndex(int value) => _highlightedIndex.value = value;
  set itemsList(List<List<T>> value) => _itemsList.assignAll(value);

  set itemScrollController(ItemScrollController value) =>
      _itemScrollController.value = value;
  set itemPositionsListener(ItemPositionsListener value) =>
      _itemPositionsListener.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    itemPositionsListener.itemPositions.addListener(_updateHighlightedIndex);
    await initItemsList();
  }

  @override
  void dispose() {
    scrollController.dispose();
    itemPositionsListener.itemPositions.removeListener(_updateHighlightedIndex);
    super.dispose();
  }

  // Обновление выделенного индекса при скролле
  void _updateHighlightedIndex() {
    final visibleItems = itemPositionsListener.itemPositions.value;
    if (visibleItems.isNotEmpty) {
      final firstVisibleItem = visibleItems.first;
      if (firstVisibleItem.index != highlightedIndex) {
        _highlightedIndex.value = firstVisibleItem.index;
      }
    }
  }

  // Инициализация списка элементов (абстрактный метод)
  Future<void> initItemsList();

  // Метод для скролла к определенному индексу
  void scrollToIndex(int index) => itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
}
