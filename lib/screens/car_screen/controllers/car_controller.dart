import 'package:autoverse/exports.dart';

enum ResourceType { youtube, google, pinterest, tiktok }

class Car {
  Mark mark = Mark();
  Model model = Model();
  Generation generation = Generation();
  Configuration configuration = Configuration();
  List<Modification> modifications = <Modification>[];
  Modification selectedModification = Modification();

  Car({
    required this.mark,
    required this.model,
    required this.generation,
    required this.configuration,
    required this.modifications,
    required this.selectedModification,
  });

  Car copyWith({
    Mark? mark,
    Model? model,
    Generation? generation,
    Configuration? configuration,
    List<Modification>? modifications,
    Modification? selectedModification,
  }) {
    return Car(
      mark: mark ?? this.mark,
      model: model ?? this.model,
      generation: generation ?? this.generation,
      configuration: configuration ?? this.configuration,
      modifications: modifications ?? this.modifications,
      selectedModification: selectedModification ?? this.selectedModification,
    );
  }
}

class CarController extends GetxController {
  static CarController get to => Get.find();

  Dio dio = Dio();
  Rx<Status> state = Status.loading.obs;

  final Rxn<Car> _car = Rxn<Car>();

  Car get car => _car.value!;
  set car(Car value) => _car.value = value;

  void selectModification(Modification modification) =>
      _car.update((car) => car?.selectedModification = modification);

  @override
  Future<void> onInit() async {
    _emitLoadingState();

    car = Get.arguments["car"];

    for (int i = 0; i < car.modifications.length; i++) {
      final specs = await _getSpecs(car.modifications[i].complectationId ?? "");
      car.modifications[i].carOptions = _getOptions(specs["options"]);
      car.modifications[i].carSpecifications =
          _getSpecifications(specs["specifications"]);
    }

    car.selectedModification = car.modifications.first;

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
    final String brandName = CarController.to.car.mark.name ?? "";
    final String modelName = CarController.to.car.model.name ?? "";
    final String generationName = CarController.to.car.generation.name ?? "";

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

  String getDescription() {
    String bodyType =
        (car.configuration.bodyType ?? "").capitalizeFirstLetter();
    String classType =
        car.model.modelClass == null ? "" : "${car.model.modelClass}-класса";
    String drive = getSpecDescription(getAllDrivesTypes(), "привод", "привод");
    String transmission =
        "Коробка ${getSpecDescription(getAllTransmissionTypes(), "", "")}"
            .capitalizeFirstLetter();

    String engines =
        "Типы двигателей: ${getSpecDescription(getAllEndgineTypes(), "", "")}";

    String endingesVolume = getMinMaxVolumeDescription().isEmpty
        ? ","
        : getMinMaxVolumeDescription();
    String horsePower = getMinMaxPowerDescription();

    return "$bodyType $classType, $drive. $transmission. $engines$endingesVolume $horsePower";
  }

  List<String> getAllTransmissionTypes() {
    Set<String> transmissions = {};

    for (Modification modification in car.modifications) {
      transmissions.add(modification.carSpecifications!.transmission);
    }

    return transmissions.toList();
  }

  List<String> getAllDrivesTypes() {
    Set<String> drives = {};

    for (Modification modification in car.modifications) {
      drives.add(modification.carSpecifications!.drive);
    }

    return drives.toList();
  }

  List<String> getAllEndgineTypes() {
    Set<String> engines = {};

    for (Modification modification in car.modifications) {
      engines.add(modification.carSpecifications!.engineType);
    }

    return engines.toList();
  }

  List<double> minMaxVolumeEngine() {
    List<double> volumeLitres = [];
    for (Modification modification in car.modifications) {
      volumeLitres
          .add(double.parse(modification.carSpecifications!.volumeLitres));
    }

    volumeLitres.sort();

    return [volumeLitres.first, volumeLitres.last];
  }

  String getMinMaxVolumeDescription() {
    try {
      List<double> volumeLitres = minMaxVolumeEngine();
      if (volumeLitres.isEmpty) return "";
      if (volumeLitres.first == volumeLitres[1]) {
        return ", объёмом от ${volumeLitres.first} л. и";
      }
      if (volumeLitres.first != volumeLitres[1]) {
        return ", объёмом от ${volumeLitres.first} до ${volumeLitres[1]} л. и";
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  List<double> minMaxPower() {
    try {
      List<double> power = [];
      for (Modification modification in car.modifications) {
        power.add(double.parse(modification.carSpecifications!.horsePower));
      }

      power.sort();

      return [power.first, power.last];
    } catch (e) {
      return [];
    }
  }

  String getMinMaxPowerDescription() {
    List<double> power = minMaxPower();
    if (power.isEmpty) return "";
    if (power.first == power[1]) {
      return "мощностью от ${power.first} л.с.";
    }
    if (power.first != power[1]) {
      return "мощностью от ${power.first} до ${power[1]} л.с.";
    }
    return "";
  }

  String getSpecDescription(
      List specs, String singlePreffix, String multiplePreffix) {
    if (specs.isEmpty) {
      return "";
    }

    if (specs.length == 1) {
      return "${specs.first} $singlePreffix".trim();
    }

    if (specs.length == 2) {
      return "${specs[0]} и ${specs[1]} $multiplePreffix".trim();
    }

    // Если больше двух типов трансмиссий
    String lastTransmission = specs.removeLast();
    return "${specs.join(', ')} и $lastTransmission $multiplePreffix".trim();
  }
}

class CarBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CarController());
}

extension StringExtensions on String {
  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
