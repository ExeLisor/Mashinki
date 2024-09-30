import 'package:autoverse/exports.dart';

List<Mark> marksFromJson(List<dynamic> jsonList) {
  return List<Mark>.from(jsonList.map((item) => Mark.fromJson(item)));
}

String marksToJson(List<Mark> data) {
  // Преобразуем список объектов Mark в один JSON-строку
  return jsonEncode(data.map((mark) => mark.toJson()).toList());
}

class Mark {
  final String? id;
  final String? name;
  final String? cyrillicName;
  final int? popular;
  final String? country;
  final List<Model>? models;

  Mark({
    this.id,
    this.name,
    this.cyrillicName,
    this.popular,
    this.country,
    this.models,
  });

  factory Mark.fromJson(Map<String, dynamic> json) => Mark(
        id: json["id"],
        name: json["name"],
        cyrillicName: json["cyrillic-name"],
        popular: json["popular"],
        country: json["country"],
        models: json["models"] == null
            ? []
            : List<Model>.from(json["models"]!.map((x) => Model.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cyrillic-name": cyrillicName,
        "popular": popular,
        "country": country,
        "models": models == null
            ? []
            : List<dynamic>.from(models!.map((x) => x.toJson())),
      };
}
