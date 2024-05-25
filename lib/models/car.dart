import 'package:mashinki/exports.dart';

List<Car> carFromJson(String str) =>
    List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String carToJson(List<Car> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Car {
  final String? id;
  final String? name;
  final String? cyrillicName;
  final bool? popular;
  final String? country;
  final List<Model>? models;

  Car({
    this.id,
    this.name,
    this.cyrillicName,
    this.popular,
    this.country,
    this.models,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
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
