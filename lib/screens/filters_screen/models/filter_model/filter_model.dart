import 'package:autoverse/screens/filters_screen/controllers.dart/filter_controller.dart';
import 'package:autoverse/screens/filters_screen/models/exterior_elements/exterior_elements.dart';
import 'package:autoverse/screens/filters_screen/models/main_options/main_options.dart';

class FilterModel {
  List<FilterModelConfiguration> configurations;
  MainOptionsClass mainOptions;
  ExteriorElements exteriorElements;

  FilterModel({
    required this.configurations,
    required this.mainOptions,
    required this.exteriorElements,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      configurations: List<FilterModelConfiguration>.from(
        json['configurations'].map<FilterModelConfiguration>(
          (json) => FilterModelConfiguration.fromJson(json),
        ),
      ),
      mainOptions: MainOptionsClass.fromJson(json['mainOptions']),
      exteriorElements: ExteriorElements.fromJson(json['exteriorElements']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'configurations': configurations.map((c) => c.toJson()).toList(),
      'mainOptions': mainOptions.toJson(),
      'exteriorElements': exteriorElements.toJson(),
    };
  }
}
