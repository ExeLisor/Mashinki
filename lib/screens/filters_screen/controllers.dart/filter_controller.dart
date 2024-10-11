import 'package:autoverse/exports.dart';

class FilterController extends GetxController {
  static FilterController get to => Get.find();

  final Rx<FilterModel> filterModel = FilterModel().obs;

  FilterModel get getFilterModel => filterModel.value;

  bool configurationsIsEmpty() => getFilterModel.configurations.isEmpty;

  void actionWithValue(dynamic value, String field) => checkValue(value, field)
      ? _removeValue(value, field)
      : _addValue(value, field);

  void _removeValue(dynamic value, String field) {
    var jsonValue = List.from(getFilterModel.toJson()[field]);

    switch (jsonValue.runtimeType) {
      case const (List<dynamic>):
        jsonValue.remove(value);
        break;

      default:
        jsonValue.clear();
        break;
    }

    var json = getFilterModel.toJson();
    json[field] = jsonValue;

    filterModel.value = FilterModel.fromJson(json);

    log(filterModel.toJson());
  }

  void _addValue(dynamic value, String field) {
    log(field);
    var jsonValue = getFilterModel.toJson()[field];
    log(jsonValue.runtimeType);
    switch (jsonValue.runtimeType) {
      case const (List<dynamic>):
        jsonValue = List.from(getFilterModel.toJson()[field]);
        jsonValue.add(value);
        break;

      default:
        jsonValue = value;
        break;
    }

    var json = getFilterModel.toJson();
    json[field] = jsonValue;

    filterModel.value = FilterModel.fromJson(json);

    log(filterModel.toJson());
  }

  bool checkValue(dynamic value, String field) {
    try {
      var jsonList = List.from(getFilterModel.toJson()[field]);

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

class FilterModel {
  List<FilterModelConfiguration> configurations = [];
  List<String> drives = [];
  List<String> steeringWheel = [];
  List<String> seatsCount = [];
  String engineVolumeStart = "";
  String engineVolumeEnd = "";
  String yearStart = "";
  String yearEnd = "";
  String powerStart = "";
  String powerEnd = "";

  FilterModel({
    this.configurations = const [],
    this.drives = const [],
    this.steeringWheel = const [],
    this.seatsCount = const [],
    this.engineVolumeStart = "",
    this.engineVolumeEnd = "",
    this.yearStart = "",
    this.yearEnd = "",
    this.powerStart = "",
    this.powerEnd = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'configurations': configurations.map((c) => c.toJson()).toList(),
      'drives': drives,
      'steeringWheel': steeringWheel,
      'seatsCount': seatsCount,
      'engineVolumeStart': engineVolumeStart,
      'engineVolumeEnd': engineVolumeEnd,
      'yearStart': yearStart,
      'yearEnd': yearEnd,
      'powerStart': powerStart,
      'powerEnd': powerEnd,
    };
  }

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      configurations: (json['configurations'] as List<dynamic>)
          .map<FilterModelConfiguration>(
              (c) => FilterModelConfiguration.fromJson(c))
          .toList(),
      drives: List<String>.from(json['drives'] as List<dynamic>),
      steeringWheel: List<String>.from(json['steeringWheel'] as List<dynamic>),
      seatsCount: List<String>.from(json['seatsCount'] as List<dynamic>),
      engineVolumeStart: json['engineVolumeStart'] as String,
      engineVolumeEnd: json['engineVolumeEnd'] as String,
      yearStart: json['yearStart'] as String,
      yearEnd: json['yearEnd'] as String,
      powerStart: json['powerStart'] as String,
      powerEnd: json['powerEnd'] as String,
    );
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
