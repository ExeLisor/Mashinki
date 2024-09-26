import 'package:autoverse/exports.dart';

class Modification {
  final String? complectationId;
  final int? offersPriceFrom;
  final int? offersPriceTo;
  final String? groupName;
  final String? title;
  CarOptions? carOptions;
  CarSpecifications? carSpecifications;
  bool isLoading;

  Modification(
      {this.complectationId,
      this.offersPriceFrom,
      this.offersPriceTo,
      this.groupName,
      this.carOptions,
      this.carSpecifications,
      this.title,
      this.isLoading = true});

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
        "modification_title": title
      };

  Future<CarSpecifications?> loadCarSpecifications() async {
    try {
      if (carSpecifications?.complectationId != null) return carSpecifications;
      log("load car specifications");
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
      CarController controller = CarController.to;
      if (carOptions?.isLoaded == true) return carOptions;
      if (carOptions?.complectationId != null) return carOptions;
      controller.updateCarOptions(carOptions ?? CarOptions(isLoaded: false));
      Response response =
          await Dio().post("$baseUrl/options", data: {"id": complectationId});
      if ((response.data as List).isEmpty) return CarOptions(isLoaded: true);
      carOptions = CarOptions.fromJson(response.data.first);
      carOptions?.isLoaded = true;

      controller.updateCarOptions(carOptions ?? CarOptions(isLoaded: true));

      return carOptions;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }
}
