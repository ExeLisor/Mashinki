import 'package:autoverse/exports.dart';

enum MarksState { success, loading, error }

class MarksController extends GetxController {
  static MarksController get to => Get.find();

  final Dio dio = Dio(BaseOptions());

  Rx<MarksState> state = MarksState.loading.obs;

  List<Mark> marks = [];
  List<Mark> popularMarks = [];
  List<AlphabetListViewItemGroup> aplphabetList = [];

  @override
  Future<void> onInit() async {
    await getOnlyPopularMarks();
    await _initAllMarksPage();

    super.onInit();
  }

  Future<void> _initAllMarksPage() async {
    {
      await getAllMarks();
      _initAlphabetList();
      Get.put(MarksSearchController());
      state.value = MarksState.success;
      log(state.value == MarksState.success);
    }
  }

  bool isMarksLoaded() => state.value == MarksState.success ? true : false;

  void _initAlphabetList() {
    _addPopularMarksToAlphabet();
    Map<String, List<Mark>> taggedElements = _createTagsForAlphabet();
    _createGridsForEveryTag(taggedElements);

    update();
  }

  void _addPopularMarksToAlphabet() {
    aplphabetList.add(
      AlphabetListViewItemGroup(
        tag: '☆',
        children: [
          BrandGrid(brands: popularMarks),
        ],
      ),
    );
  }

  Map<String, List<Mark>> _createTagsForAlphabet() {
    Map<String, List<Mark>> groupedBrands = {};

    for (var brand in MarksController.to.marks) {
      String key = brand.name![0].toUpperCase();
      if (!groupedBrands.containsKey(key)) {
        groupedBrands[key] = [];
      }
      groupedBrands[key]!.add(brand);
    }
    return groupedBrands;
  }

  void _createGridsForEveryTag(Map<String, List<Mark>> tags) {
    tags.forEach(
      (key, brands) {
        aplphabetList.add(
          AlphabetListViewItemGroup(
            tag: key,
            children: [
              BrandGrid(brands: brands),
            ],
          ),
        );
      },
    );
    return;
  }

  Future<List<Mark>?> getOnlyPopularMarks() async {
    try {
      Response response = await dio.get("$baseUrl/marks/popular");

      popularMarks = marksFromJson(response.data);
      update();
      return marks;
    } catch (e) {
      logW(e);
      return null;
    }
  }

  Future<List<Mark>?> getAllMarks() async {
    try {
      Response response = await dio.get("$baseUrl/marks");

      marks = marksFromJson(response.data);
      update();
      return marks;
    } catch (e) {
      logW(e);
      return null;
    }
  }
}

class MarksSearchController extends GetxController {
  static MarksSearchController get to => Get.find();

  List<Mark> results = <Mark>[];

  String query = "";

  void clearSearch() {
    query = "";
    results = <Mark>[];
  }

  void startSearch(String text) {
    query = text;

    if (query.isEmpty) {
      results = MarksController.to.marks;
    } else {
      results = MarksController.to.marks.where(
        (Mark mark) {
          final String name = mark.name!.toLowerCase();
          final String cirillicName = mark.cyrillicName!.toLowerCase();
          final String input = query.toLowerCase();

          return name.contains(input) || cirillicName.contains(input);
        },
      ).toList();
    }

    update();
  }
}
