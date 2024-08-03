import 'package:autoverse/exports.dart';

enum MarksState { success, loading, error }

class MarksController extends GetxController {
  static MarksController get to => Get.find();

  final Dio dio = Dio(BaseOptions());

  Rx<MarksState> state = MarksState.loading.obs;

  List<Mark> marks = [];
  List<Mark> popularMarks = [];
  List<AlphabetListViewItemGroup> alphabetList = [];

  @override
  Future<void> onInit() async {
    _initializeMarksController();
    super.onInit();
  }

  void goToModels(Mark mark) =>
      Get.toNamed("/${mark.id}/models", arguments: {"mark": mark});

  Future<bool> _initializeMarksController() async {
    try {
      popularMarks = await getOnlyPopularMarks();
      marks = await getAllMarks();
      alphabetList = _initAlphabetList();

      Get.put(MarksSearchController());
      state.value = MarksState.success;
      update();
      return true;
    } catch (error) {
      state.value = MarksState.error;
      return false;
    }
  }

  bool isMarksLoaded() => state.value == MarksState.success ? true : false;

  List<AlphabetListViewItemGroup> _initAlphabetList() {
    try {
      alphabetList = _addPopularMarksToAlphabet();
      Map<String, List<Mark>> taggedElements = _createTagsForAlphabet();
      alphabetList = _createGridsForEveryTag(taggedElements);

      return alphabetList;
    } catch (error) {
      _clearAlphabetList();
      rethrow;
    }
  }

  void _clearAlphabetList() {
    alphabetList.clear();
    update();
  }

  List<AlphabetListViewItemGroup> _addPopularMarksToAlphabet() {
    alphabetList.add(
      AlphabetListViewItemGroup(
        tag: '☆',
        children: [
          BrandGrid(brands: popularMarks),
        ],
      ),
    );
    return alphabetList;
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

  List<AlphabetListViewItemGroup> _createGridsForEveryTag(
      Map<String, List<Mark>> tags) {
    tags.forEach(
      (key, brands) {
        alphabetList.add(
          AlphabetListViewItemGroup(
            tag: key,
            children: [
              BrandGrid(brands: brands),
            ],
          ),
        );
      },
    );
    return alphabetList;
  }

  Future<List<Mark>> getOnlyPopularMarks() async {
    try {
      Response response = await dio.get("$baseUrl/marks/popular");
      List<Mark> popularMarksFromResponse = marksFromJson(response.data);

      return popularMarksFromResponse;
    } catch (e) {
      logW(e);
      await Future.delayed(const Duration(seconds: 2));
      await getOnlyPopularMarks();
      rethrow;
    }
  }

  Future<List<Mark>> getAllMarks() async {
    try {
      Response response = await dio.get("$baseUrl/marks");

      List<Mark> marksFromResponse = marksFromJson(response.data);

      return marksFromResponse;
    } catch (e) {
      logW(e);
      await Future.delayed(const Duration(seconds: 2));
      await getAllMarks();
      rethrow;
    }
  }
}

class MarksSearchController extends GetxController {
  static MarksSearchController get to => Get.find();

  TextEditingController controller = TextEditingController();
  List<Mark> results = <Mark>[];
  String query = "";

  List<String> recentSearch = [];

  void clearSearch() {
    query = "";
    controller.text = "";
    results = <Mark>[];
  }

  void startSearch(String text) {
    query = text;

    if (query.isEmpty) {
      results = [];
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

  void startSearchFromRecent(String recentText) {
    MarksSearchController.to.controller.text = recentText;
    startSearch(recentText);
  }
}
