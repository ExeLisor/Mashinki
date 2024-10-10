import 'package:autoverse/exports.dart';

class FilterController extends GetxController {
  static FilterController get to => Get.find();

  final Rx<FilterModel> filterModelObs = FilterModel().obs;

  FilterModel get filterModel => filterModelObs.value;

  bool configurationsIsEmpty() => filterModel.configurations.isEmpty;

  addConfiguration(FilterModelConfiguration configuration) {
    filterModelObs.update((_) => _?.configurations.add(configuration));
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

  FilterModel({configurations}) : configurations = [FilterModelConfiguration()];

  FilterModel copyWith({
    List configurations = const [],
  }) =>
      FilterModel(
        configurations: configurations.isNotEmpty
            ? this.configurations
            : this.configurations.map((e) => e.copyWith()).toList(),
      );
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
}
