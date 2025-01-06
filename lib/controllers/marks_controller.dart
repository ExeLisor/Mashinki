import 'package:autoverse/exports.dart';

enum MarksState { success, loading, error }

class MarksController extends GetxController {
  static MarksController get to => Get.find();

  Rx<MarksState> state = MarksState.loading.obs;

  List<Mark> marks = [];
  List<Mark> popularMarks = [];

  @override
  Future<void> onInit() async {
    _initializeMarksController();
    super.onInit();
  }

  Future<bool> _initializeMarksController() async {
    try {
      popularMarks = await getOnlyPopularMarks();

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
      if (popularMarks.isNotEmpty) return popularMarks;

      final cache = await loadData("popularMarks");
      if (cache != null) return popularMarks = marksFromJson(cache);

      List<Mark> popular = await SupabaseController.to.getPopularMarks();
      await saveData("popularMarks", marksToJson(popular));

      return popular;
    } catch (e) {
      logW(e);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await Future.delayed(const Duration(seconds: 2));
      await getOnlyPopularMarks();
      rethrow;
    }
  }

  Future<List<Mark>> getAllMarks() async {
    try {
      final cache = await loadData("marks");
      if (cache != null) return marks = marksFromJson(cache);

      marks = await SupabaseController.to.getMarks();
      await saveData("marks", marksToJson(marks));

      update();

      return marks;
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

  final RxBool _isSearching = false.obs;
  bool get isSearching => _isSearching.value;
  set isSearching(bool value) => _isSearching.value = value;

  final RxString _query = "".obs;
  String get query => _query.value;
  set query(String value) => _query.value = value;

  List<Mark> results = <Mark>[];

  List<String> recentSearch = [];

  @override
  void onInit() {
    super.onInit();
    debounce(
      _query,
      (value) => search(),
      time: const Duration(milliseconds: 1500),
    );
  }

  @override
  TextEditingController controller = TextEditingController();

  @override
  void clearSearch() {
    query = "";
    controller.text = "";
    results = <Mark>[];
    isSearching = false;
  }

  void search() {
    final List<Mark> marks = List.from(MarksController.to.marks);
    isSearching = true;
    if (query.isEmpty) {
      results = [];
      isSearching = false;
      return;
    }

    results = marks.where(
      (Mark mark) {
        final String name = mark.name!.toLowerCase();
        final String cirillicName = mark.cyrillicName!.toLowerCase();
        final String input = query.toLowerCase();

        return name.contains(input) || cirillicName.contains(input);
      },
    ).toList();
    isSearching = false;
    update();
  }

  @override
  void startSearch(String text) {
    isSearching = true;

    query = text;

    update();
  }

  void startSearchFromRecent(String recentText) {
    MarksSearchController.to.controller.text = recentText;
    startSearch(recentText);
  }
}

class MarksSearchBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => MarksSearchController());
}
