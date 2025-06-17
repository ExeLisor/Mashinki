import 'package:autoverse/exports.dart';
import 'package:autoverse/screens/filters_screen/models/exterior_elements/exterior_elements.dart';

import 'package:autoverse/screens/filters_screen/models/filter_model/filter_model.dart';
import 'package:autoverse/screens/filters_screen/models/main_options/main_options.dart';

class FilterController extends GetxController {
  static FilterController get to => Get.find();

  final Rx<FilterModel> filterModel = FilterModel(
          configurations: [],
          mainOptions: MainOptionsClass(),
          exteriorElements: ExteriorElements())
      .obs;

  RxMap filter =
      {"configurations": {}, "mainOptions": {}, "addOptions": {}}.obs;

  void clearField(String category, String type, String field) {
    if (filter[category]?[field] != null) filter[category]?[field].clear();
    if (filter[category]?[field].isEmpty) filter[category]!.remove(field);
  }

  void actionWithValue(
          dynamic value, String category, String type, String field) =>
      checkValue(value, category, type, field)
          ? removeValue(value, category, type, field)
          : addValue(value, category, type, field);

  void removeValue(dynamic value, String category, String type, String field) {
    Map<String, Map<dynamic, dynamic>> newFilter = Map.from(filter);
    dynamic categoryValue = newFilter[category];

    dynamic fieldValues = categoryValue![field];

    if (type == "chips") {
      fieldValues.remove(value);
    } else if (type == "selector") {
      if (value is List) {
        fieldValues = fieldValues..removeWhere((v) => value.contains(v));
      }
      fieldValues.remove(value);
    } else if (type == "range") {
      fieldValues = value;
    } else if (type == "checkbox") {
      fieldValues = "";
    }

    newFilter[category]![field] = fieldValues;
    filter.value = newFilter;

    if (filter[category]?[field].isEmpty) filter[category]!.remove(field);
  }

  _addNewField(String category, String field, String type) {
    if (type == "chips") {
      filter[category]?[field] = [];
    } else if (type == "selector") {
      filter[category]?[field] = [];
    }
  }

  void addValue(dynamic value, String category, String type, String field) {
    Map<String, Map<dynamic, dynamic>> newFilter = Map.from(filter);

    var categoryValue = newFilter[category];
    if (categoryValue?[field] == null) _addNewField(category, field, type);

    var fieldValues = categoryValue![field];

    switch (type) {
      case "chips":
        fieldValues = List.from(categoryValue[field]);
        fieldValues.add(value);
        break;
      case "selector":
        fieldValues = List.from(categoryValue[field]);
        fieldValues.addAll(value);
        break;
      default:
        fieldValues = value;
    }

    newFilter[category]![field] = fieldValues;
    filter.value = newFilter;
    log(filter);
  }

  bool checkValue(dynamic value, String category, String type, String field) {
    try {
      switch (type) {
        case "chips":
          return filter[category]?[field].contains(value);

        case "range":
          return filter[category]?[field].contains(value);

        case "selector":
          if (value.isEmpty) return true;
          if (value is List) return value.isSubsetOf(filter[category]?[field]);
          return filter[category]?[field].contains(value);

        case "checkbox":
          if (value == false) return true;
          return filter[category]?[field].contains(value);

        default:
          return true;
      }
    } catch (e) {
      return false;
    }
  }
}

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterController());
  }
}

class FilterModelConfiguration {
  String? markName;
  List<String> models = [];

  FilterModelConfiguration({this.markName, this.models = const []});

  FilterModelConfiguration copyWith({
    String? markName,
    List<String>? models,
  }) {
    return FilterModelConfiguration(
      markName: markName ?? this.markName,
      models: models ?? this.models,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'markName': markName,
      'models': models,
    };
  }

  FilterModelConfiguration.fromJson(Map<String, dynamic> json) {
    markName = json['markName'] as String?;
    models = List<String>.from(json['models'] as List<dynamic>);
  }
}
