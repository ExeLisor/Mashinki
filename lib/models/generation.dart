import 'package:autoverse/exports.dart';

class Generation {
  final String? id;
  final String? name;
  final int? yearStart;
  final int? yearStop;
  final bool isRestyle;
  final List<Configuration>? configurations;

  Generation({
    this.id,
    this.name,
    this.yearStart,
    this.yearStop,
    this.isRestyle = false,
    this.configurations,
  });

  factory Generation.fromJson(Map<String, dynamic> json) => Generation(
        id: json["id"],
        name: json["name"],
        yearStart: json["year-start"],
        yearStop: json["year-stop"],
        isRestyle: json["is-restyle"] == "1",
        configurations: json["configurations"] == null
            ? []
            : List<Configuration>.from(
                json["configurations"]!.map((x) => Configuration.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year-start": yearStart,
        "year-stop": yearStop,
        "is-restyle": isRestyle,
        "configurations": configurations == null
            ? []
            : List<dynamic>.from(configurations!.map((x) => x.toJson())),
      };
}
