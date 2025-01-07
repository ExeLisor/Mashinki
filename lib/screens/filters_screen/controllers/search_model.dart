import 'package:autoverse/exports.dart';

class ModelSearchController extends GetxController
    implements SearchFieldController {
  static ModelSearchController get to => Get.find();

  final RxBool _isSearching = false.obs;
  bool get isSearching => _isSearching.value;
  set isSearching(bool value) => _isSearching.value = value;

  final RxString _query = "".obs;
  String get query => _query.value;
  set query(String value) => _query.value = value;

  List<Model> results = <Model>[];

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
    results = <Model>[];
    isSearching = false;
  }

  void search() {
    final List<Model> models = List.from(ModelsController.to.models);
    log(models.length);
    isSearching = true;
    if (query.isEmpty) {
      results = [];
      isSearching = false;
      return;
    }

    results = models.where(
      (Model model) {
        final String name = model.name!.toLowerCase();
        final String cirillicName = model.cyrillicName!.toLowerCase();
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
