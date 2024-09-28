import 'package:autoverse/exports.dart';

List<Modification> modificationsFromJson(List<dynamic> jsonList) {
  return List<Modification>.from(
      jsonList.map((item) => Modification.fromJson(item)));
}

class Modification {
  final String? complectationId;
  final int? offersPriceFrom;
  final int? offersPriceTo;
  final String? groupName;
  final String? title;
  CarOptions? carOptions;
  CarSpecifications? carSpecifications;
  bool isLoaded;

  Modification(
      {this.complectationId,
      this.offersPriceFrom,
      this.offersPriceTo,
      this.groupName,
      this.carOptions,
      this.carSpecifications,
      this.title,
      this.isLoaded = true});

  factory Modification.fromJson(Map<String, dynamic> json) => Modification(
        complectationId: json["complectation-id"],
        offersPriceFrom: json["offers-price-from"],
        offersPriceTo: json["offers-price-to"],
        groupName: json["group-name"],
        title: json["modification_title"],
      );

  Map<String, dynamic> toJson() => {
        "complectation-id": complectationId,
        "offers-price-from": offersPriceFrom,
        "offers-price-to": offersPriceTo,
        "group-name": groupName,
        "modification_title": title,
        "car-specifications": carSpecifications,
        "isLoaded": isLoaded
      };

  Future<CarSpecifications?> loadCarSpecifications() async {
    try {
      if (carSpecifications?.complectationId != null) return carSpecifications;

      carSpecifications =
          await SupabaseController.to.getSpecifications(complectationId ?? "");

      return carSpecifications;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<CarOptions?> loadCarOptions() async {
    try {
      CarController controller = CarController.to;
      if (carOptions?.isLoaded == true) return carOptions;
      if (carOptions?.complectationId != null) return carOptions;
      controller.updateCarOptions(carOptions ?? CarOptions(isLoaded: false));
      carOptions =
          await SupabaseController.to.getOptions(complectationId ?? "");

      carOptions?.isLoaded = true;

      controller.updateCarOptions(carOptions ?? CarOptions(isLoaded: true));

      return carOptions;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }
}
