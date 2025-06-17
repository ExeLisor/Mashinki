import 'package:autoverse/exports.dart';

class Generation {
  final String? id;
  final String? name;
  final int? yearStart;
  final int? yearStop;
  final bool isRestyle;
  List<Configuration> configurations = <Configuration>[];

  Generation({
    this.id,
    this.name,
    this.yearStart,
    this.yearStop,
    this.isRestyle = false,
    this.configurations = const [],
  });

  factory Generation.fromJson(Map<String, dynamic> json) => Generation(
        id: json["id"],
        name: json["name"],
        yearStart: json["year-start"],
        yearStop: json["year-stop"],
        isRestyle: json["is-restyle"] == "1",
        configurations: json["configuration"] == null
            ? []
            : List<Configuration>.from(
                json["configuration"]!.map((x) => Configuration.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year-start": yearStart,
        "year-stop": yearStop,
        "is-restyle": isRestyle,
        "configuration": configurations.isEmpty
            ? []
            : List<dynamic>.from(configurations.map((x) => x.toJson())),
      };
}
