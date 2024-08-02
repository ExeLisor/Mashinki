import 'package:autoverse/exports.dart';

class Modification {
  final String? complectationId;
  final int? offersPriceFrom;
  final int? offersPriceTo;
  final String? groupName;
  final Specifications? specifications;

  Modification({
    this.complectationId,
    this.offersPriceFrom,
    this.offersPriceTo,
    this.groupName,
    this.specifications,
  });

  factory Modification.fromJson(Map<String, dynamic> json) => Modification(
        complectationId: json["complectation-id"],
        offersPriceFrom: json["offers-price-from"],
        offersPriceTo: json["offers-price-to"],
        groupName: json["group-name"],
        specifications: json["specifications"] == null
            ? null
            : Specifications.fromJson(json["specifications"]),
      );

  Map<String, dynamic> toJson() => {
        "complectation-id": complectationId,
        "offers-price-from": offersPriceFrom,
        "offers-price-to": offersPriceTo,
        "group-name": groupName,
        "specifications": specifications?.toJson(),
      };
}
