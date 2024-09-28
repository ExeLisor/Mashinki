import 'package:autoverse/exports.dart';

List<Model> modelsFromJson(List<dynamic> jsonList) {
  return List<Model>.from(jsonList.map((item) => Model.fromJson(item)));
}

String modelsToJson(List<Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Model {
  final String? id;
  final String? name;
  final String? cyrillicName;
  final String? modelClass;
  final int? yearFrom;
  final int? yearTo;
  List<Generation> generations = <Generation>[];

  Model({
    this.id,
    this.name,
    this.cyrillicName,
    this.modelClass,
    this.yearFrom,
    this.yearTo,
    this.generations = const [],
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        name: json["name"],
        cyrillicName: json["cyrillic-name"],
        modelClass: json["class"],
        yearFrom: json["year-from"],
        yearTo: json["year-to"],
        generations: json["generation"] == null
            ? []
            : List<Generation>.from(
                json["generation"]!.map((x) => Generation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cyrillic-name": cyrillicName,
        "class": modelClass,
        "year-from": yearFrom,
        "year-to": yearTo,
        "generations": List<dynamic>.from(generations.map((x) => x.toJson())),
      };
}
