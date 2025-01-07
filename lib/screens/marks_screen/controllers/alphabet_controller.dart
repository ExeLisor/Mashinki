import 'package:autoverse/exports.dart';
import 'package:autoverse/models/alphabet.dart';

class AlphabetMarksController extends AlphabetController<Mark> {
  static AlphabetMarksController get to => Get.find();

  @override
  Future<void> initItemsList() async {
    isLoading = true;
    itemsList.clear();

    List<Mark> popularMarks = _getPopularMarks();
    itemsList.add(popularMarks);

    List<List<Mark>> groupedMarks = await _getGroupedMarks();
    itemsList.addAll(groupedMarks);

    isLoading = false;
  }

  List<Mark> _getPopularMarks() => List.from(MarksController.to.popularMarks);

  Future<List<List<Mark>>> _getGroupedMarks() async {
    Map<String, List<Mark>> groupedMarks = {};
    List<Mark> marks = await MarksController.to.getAllMarks();
    List<String> keys = [];

    for (var brand in marks) {
      String key = brand.id![0].toUpperCase();

      if (!groupedMarks.containsKey(key)) {
        keys.add(key);
        groupedMarks[key] = [];
      }
      groupedMarks[key]!.add(brand);
    }

    List<List<Mark>> result = [];
    for (var group in groupedMarks.values) {
      result.add(group);
    }

    return result;
  }

  @override
  void scrollToIndex(int index) => itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
}

class AlphabetBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => AlphabetMarksController());
}
