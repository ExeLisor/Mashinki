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
  final Class? modelClass;
  final int? yearFrom;
  final int? yearTo;
  final List<Generation>? generations;

  Model({
    this.id,
    this.name,
    this.cyrillicName,
    this.modelClass,
    this.yearFrom,
    this.yearTo,
    this.generations,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json["id"],
        name: json["name"],
        cyrillicName: json["cyrillic-name"],
        modelClass: classValues.map[json["class"]]!,
        yearFrom: json["year-from"],
        yearTo: json["year-to"],
        generations: json["generations"] == null
            ? []
            : List<Generation>.from(
                json["generations"]!.map((x) => Generation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cyrillic-name": cyrillicName,
        "class": classValues.reverse[modelClass],
        "year-from": yearFrom,
        "year-to": yearTo,
        "generations": generations == null
            ? []
            : List<dynamic>.from(generations!.map((x) => x.toJson())),
      };
}
