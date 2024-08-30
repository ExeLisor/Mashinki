import 'package:autoverse/exports.dart';

class Car {
  Mark mark = Mark();
  Model model = Model();
  Generation generation = Generation();
  Configuration configuration = Configuration();
  List<Modification> modifications = <Modification>[];
  Modification selectedModification = Modification();
  bool isDownloaded;

  Car({
    required this.mark,
    required this.model,
    required this.generation,
    required this.configuration,
    required this.modifications,
    required this.selectedModification,
    this.isDownloaded = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'mark': mark.toJson(),
      'model': model.toJson(),
      'generation': generation.toJson(),
      'configuration': configuration.toJson(),
      'modifications': modifications.map((mod) => mod.toJson()).toList(),
      'selectedModification': selectedModification.toJson(),
    };
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      mark: Mark.fromJson(json['mark']),
      model: Model.fromJson(json['model']),
      generation: Generation.fromJson(json['generation']),
      configuration: Configuration.fromJson(json['configuration']),
      modifications: (json['modifications'] as List)
          .map((mod) => Modification.fromJson(mod))
          .toList(),
      selectedModification: Modification.fromJson(json['selectedModification']),
    );
  }

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

  String getDescription() {
    String bodyType = (configuration.bodyType ?? "").capitalizeFirstLetter();
    String classType = model.modelClass == null
        ? ""
        : model.modelClass!.isEmpty
            ? ""
            : "${model.modelClass}-класса,";
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

    return "$bodyType $classType$drive. $transmission. $engines$endingesVolume $horsePower";
  }

  List<String> getAllTransmissionTypes() {
    Set<String> transmissions = {};

    for (Modification modification in modifications) {
      transmissions.add(modification.carSpecifications!.transmission);
    }

    return transmissions.toList();
  }

  List<String> getAllDrivesTypes() {
    Set<String> drives = {};

    for (Modification modification in modifications) {
      drives.add(modification.carSpecifications!.drive);
    }

    return drives.toList();
  }

  List<String> getAllEndgineTypes() {
    Set<String> engines = {};

    for (Modification modification in modifications) {
      engines.add(modification.carSpecifications!.engineType);
    }

    return engines.toList();
  }

  List<double> minMaxVolumeEngine() {
    List<double> volumeLitres = [];
    for (Modification modification in modifications) {
      volumeLitres.add(modification.carSpecifications!.volumeLitres);
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

  List<int> minMaxPower() {
    try {
      List<int> power = [];
      for (Modification modification in modifications) {
        power.add(modification.carSpecifications!.horsePower);
      }

      power.sort();

      return [power.first, power.last];
    } catch (e) {
      return [];
    }
  }

  String getMinMaxPowerDescription() {
    List<int> power = minMaxPower();
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

    String lastTransmission = specs.removeLast();
    return "${specs.join(', ')} и $lastTransmission $multiplePreffix".trim();
  }
}
