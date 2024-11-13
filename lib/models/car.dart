import 'package:autoverse/exports.dart';

class Car {
  Mark mark = Mark();
  Model model = Model();
  Generation generation = Generation();
  Configuration configuration = Configuration();
  List<Modification> modifications = <Modification>[];
  Modification selectedModification;
  String description;
  bool isDownloaded;

  Car({
    required this.mark,
    required this.model,
    required this.generation,
    required this.configuration,
    this.description = "",
    this.modifications = const <Modification>[],
    Modification? selectedModification,
    this.isDownloaded = false,
  }) : selectedModification = selectedModification ?? Modification();

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
    );
  }

  Future loadCar() async {
    if (modifications.isEmpty) await loadCarModification();
    if (description.isEmpty) await loadCarDescription();

    return;
  }

  Future<String> loadCarDescription() async {
    try {
      String description = await SupabaseController.to
          .getModificationDescription(configuration.id ?? "");

      String bodyType =
          (configuration.bodyType ?? "").tr.capitalizeFirstLetter();

      String modelClass = model.modelClass.nullOrEmpty
          ? ""
          : "${model.modelClass}-${"класса".tr}";

      this.description = "$bodyType $modelClass, $description";
      return description;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<List<Modification>> loadCarModification() async {
    try {
      if (modifications.isNotEmpty) return modifications;

      modifications =
          await SupabaseController.to.getModifications(configuration.id ?? "");

      selectedModification = modifications.first;

      await selectedModification.loadCarSpecifications();

      selectedModification.isLoaded = true;

      return modifications;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Car copyWith(
      {Mark? mark,
      Model? model,
      Generation? generation,
      Configuration? configuration,
      List<Modification>? modifications,
      Modification? selectedModification,
      String? description}) {
    return Car(
      mark: mark ?? this.mark,
      model: model ?? this.model,
      generation: generation ?? this.generation,
      configuration: configuration ?? this.configuration,
      modifications: modifications ?? this.modifications,
      selectedModification: selectedModification ?? this.selectedModification,
      description: description ?? this.description,
    );
  }
}
