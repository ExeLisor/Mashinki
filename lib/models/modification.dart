import 'package:autoverse/exports.dart';

class Modification {
  final String? complectationId;
  final int? offersPriceFrom;
  final int? offersPriceTo;
  final String? groupName;
  CarOptions? carOptions;
  CarSpecifications? carSpecifications;

  Modification({
    this.complectationId,
    this.offersPriceFrom,
    this.offersPriceTo,
    this.groupName,
    this.carOptions,
    this.carSpecifications,
  });

  factory Modification.fromJson(Map<String, dynamic> json) => Modification(
        complectationId: json["complectation-id"],
        offersPriceFrom: json["offers-price-from"],
        offersPriceTo: json["offers-price-to"],
        groupName: json["group-name"],
      );

  Map<String, dynamic> toJson() => {
        "complectation-id": complectationId,
        "offers-price-from": offersPriceFrom,
        "offers-price-to": offersPriceTo,
        "group-name": groupName,
      };

  Future<CarSpecifications?> loadCarSpecifications() async {
    try {
      if (carSpecifications?.complectationId != null) return carSpecifications;

      Response response = await Dio()
          .post("$baseUrl/specifications", data: {"id": complectationId});

      carSpecifications = CarSpecifications.fromJson(response.data.first);

      return carSpecifications;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<CarOptions?> loadCarOptions() async {
    try {
      if (carOptions?.complectationId != null) return carOptions;

      Response response = await Dio()
          .post("$baseUrl/specifications", data: {"id": complectationId});

      carOptions = CarOptions.fromJson(response.data.first);

      return carOptions;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }
}
