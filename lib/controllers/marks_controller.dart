import 'package:autoverse/exports.dart';

enum MarksState { success, loading, error }

class MarksController extends GetxController {
  static MarksController get to => Get.find();

  final Dio dio = Dio(BaseOptions());

  Rx<MarksState> state = MarksState.loading.obs;

  List<Mark> marks = [];
  List<Mark> popularMarks = [];

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

class MarksBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ModelsController());
}

class MarksSearchController extends GetxController
    implements SearchFieldController {
  static MarksSearchController get to => Get.find();

  List<Mark> results = <Mark>[];
  String query = "";
  List<String> recentSearch = [];

  @override
  TextEditingController controller = TextEditingController();

  @override
  void clearSearch() {
    query = "";
    controller.text = "";
    results = <Mark>[];
  }

  @override
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
