import 'package:autoverse/exports.dart';

class MarksController extends GetxController {
  static MarksController get to => Get.find();

  final Dio dio = Dio(BaseOptions());

  List<Mark> marks = [];
  List<Mark> popularMarks = [];
  List<AlphabetListViewItemGroup> aplphabetList = [];

  @override
  Future<void> onInit() async {
    await getOnlyPopularMarks();
    await getAllMarks();
    initAlphabetList();
    super.onInit();
  }

  void initAlphabetList() {
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
