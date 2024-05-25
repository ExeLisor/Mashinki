import 'package:mashinki/exports.dart';

class Modification {
  final String? complectationId;
  final int? offersPriceFrom;
  final int? offersPriceTo;
  final String? groupName;
  final Specifications? specifications;
  final Map<String, int>? options;
  final List<OptionPackage>? optionPackages;

  Modification({
    this.complectationId,
    this.offersPriceFrom,
    this.offersPriceTo,
    this.groupName,
    this.specifications,
    this.options,
    this.optionPackages,
  });

  factory Modification.fromJson(Map<String, dynamic> json) => Modification(
        complectationId: json["complectation-id"],
        offersPriceFrom: json["offers-price-from"],
        offersPriceTo: json["offers-price-to"],
        groupName: json["group-name"],
        specifications: json["specifications"] == null
            ? null
            : Specifications.fromJson(json["specifications"]),
        options: Map.from(json["options"]!)
            .map((k, v) => MapEntry<String, int>(k, v)),
        optionPackages: json["option-packages"] == null
            ? []
            : List<OptionPackage>.from(
                json["option-packages"]!.map((x) => OptionPackage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "complectation-id": complectationId,
        "offers-price-from": offersPriceFrom,
        "offers-price-to": offersPriceTo,
        "group-name": groupName,
        "specifications": specifications?.toJson(),
        "options":
            Map.from(options!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "option-packages": optionPackages == null
            ? []
            : List<dynamic>.from(optionPackages!.map((x) => x.toJson())),
      };
}
