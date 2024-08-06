import 'package:autoverse/exports.dart';

class ModelsSearchBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ModelsSearchController());
}

class ModelsSearchController extends GetxController
    implements SearchFieldController {
  static ModelsSearchController get to => Get.find();

  final RxList<Model> _results = <Model>[].obs;
  final RxString _query = "".obs;

  List<Model> get results => _results;
  String get query => _query.value;

  @override
  TextEditingController controller = TextEditingController();

  @override
  void clearSearch() {
    _query.value = "";
    controller.text = "";
    _results.value = <Model>[];
  }

  @override
  void startSearch(String text) {
    _query.value = text;

    if (query.isEmpty) {
      _results.value = [];
    } else {
      _results.value = ModelsController.to.models.where(
        (Model model) {
          final String name = model.name!.toLowerCase();
          final String cirillicName = model.cyrillicName!.toLowerCase();
          final String input = query.toLowerCase();

          return name.contains(input) || cirillicName.contains(input);
        },
      ).toList();
    }
  }
}
