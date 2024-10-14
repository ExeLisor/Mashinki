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

  FilterModel get getFilterModel => filterModel.value;

  Map<String, dynamic> get jsonModel => filterModel.value.toJson();

  bool configurationsIsEmpty() => getFilterModel.configurations.isEmpty;

  void actionWithValue(
          dynamic value, String category, String type, String field) =>
      checkValue(value, category, type, field)
          ? _removeValue(value, category, type, field)
          : _addValue(value, category, type, field);

  void _removeValue(dynamic value, String category, String type, String field) {
    var jsFilterModel = getFilterModel.toJson();
    var json = jsFilterModel[category];
    var jsonValue = json[field];

    if (type == "chips" || type == "selector") {
      jsonValue.remove(value);
    } else {
      jsonValue.clear();
    }

    json[field] = jsonValue;

    FilterModel filterModelJs = FilterModel.fromJson(jsFilterModel);

    filterModel.value = filterModelJs;
  }

  void _addValue(dynamic value, String category, String type, String field) {
    log("$value $category $type $field");
    var jsFilterModel = getFilterModel.toJson();
    var json = jsFilterModel[category];
    var jsonValue = json[field];

    log(json);

    if (type == "chips") {
      jsonValue = List.from(getFilterModel.toJson()[category][field]);
      jsonValue.add(value);
    } else if (type == "selector") {
      jsonValue = List.from(getFilterModel.toJson()[category][field]);
      jsonValue = value;
    } else {
      jsonValue = value;
    }

    json[field] = jsonValue;

    FilterModel filterModelJs = FilterModel.fromJson(jsFilterModel);

    filterModel.value = filterModelJs;
  }

  bool checkValue(dynamic value, String category, String type, String field) {
    try {
      var jsonList = List.from(getFilterModel.toJson()[category][field]);

      return jsonList.contains(value);
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
