import 'package:autoverse/exports.dart';

enum ResourceType { youtube, google, pinterest, tiktok }

class CarController extends GetxController {
  static CarController get to => Get.find();

  Dio dio = Dio();
  Rx<Status> state = Status.loading.obs;

  final Rxn<Mark> _mark = Rxn<Mark>();
  final Rxn<Model> _model = Rxn<Model>();
  final Rxn<Generation> _generation = Rxn<Generation>();
  final Rxn<Configuration> _configuration = Rxn<Configuration>();
  final Rxn<List<Modification>> _modifications = Rxn<List<Modification>>();
  final Rxn<Modification> _selectedModification = Rxn<Modification>();

  Mark get mark => _mark.value!;
  Model get model => _model.value!;
  Generation get generation => _generation.value!;
  Configuration get configuration => _configuration.value!;
  List<Modification> get modifications => _modifications.value!;
  Modification get selectedModification => _selectedModification.value!;

  void selectModification(Modification modification) =>
      _selectedModification.value = modification;

  @override
  Future<void> onInit() async {
    _emitLoadingState();
    _mark.value = Get.arguments["mark"];
    _model.value = Get.arguments["model"];
    _generation.value = Get.arguments["generation"];
    _configuration.value = Get.arguments["configuration"];
    _modifications.value = configuration.modifications;

    for (Modification modification in configuration.modifications ?? []) {
      final specs = await _getSpecs(modification.complectationId ?? "");
      modification.carOptions = _getOptions(specs["options"]);
      modification.carSpecifications =
          _getSpecifications(specs["specifications"]);
    }
    _selectedModification.value = configuration.modifications?.first;

    _emitSussessState();

    super.onInit();
  }

  @override
  void onClose() {
    dio.close();
    super.onClose();
  }

  CarOptions? _getOptions(List data) {
    if (data.isEmpty) return null;

    CarOptions options = CarOptions.fromJson(data.first);
    return options;
  }

  CarSpecifications _getSpecifications(List data) {
    CarSpecifications specifications = CarSpecifications.fromJson(data.first);
    return specifications;
  }

  Future _getSpecs(String complecationId) async {
    try {
      log("$baseUrl/specs/${configuration.id}");
      Response response = await dio.get("$baseUrl/specs/$complecationId");

      return response.data;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionError:
        default:
          _emitErrorState();
          await Future.delayed(const Duration(seconds: 5));
          await _getSpecs(complecationId);
      }
      rethrow;
    } catch (e) {
      logW(e);
      _emitErrorState();

      return false;
    }
  }

  Future<void> openResource(ResourceType type) async {
    final String brandName = CarController.to.mark.name ?? "";
    final String modelName = CarController.to.model.name ?? "";
    final String generationName = CarController.to.generation.name ?? "";

    final String searchText = "$brandName $modelName $generationName";

    String url = "";

    switch (type) {
      case ResourceType.google:
        url = _launchGoogle(searchText);
        break;
      case ResourceType.pinterest:
        url = _launchPinterest(searchText);
        break;
      case ResourceType.youtube:
        url = _launchYoutube(searchText);
        break;
      case ResourceType.tiktok:
        url = _launchTiktok(searchText);
        break;
      default:
    }

    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  String _launchYoutube(String searchText) =>
      "https://www.youtube.com/results?search_query=$searchText";

  String _launchPinterest(String searchText) =>
      "https://www.pinterest.com/search/pins/?q=$searchText&rs=typed";

  String _launchGoogle(String searchText) =>
      "https://www.google.com/search?q=$searchText";

  String _launchTiktok(String searchText) =>
      "https://www.tiktok.com/search?q=$searchText";

  void _emitSussessState() => state.value = Status.success;
  void _emitLoadingState() => state.value = Status.loading;
  void _emitErrorState() => state.value = Status.error;
  void _setState(Status newState) => state.value = newState;
}

class CarBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CarController());
}
