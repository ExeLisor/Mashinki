import 'package:autoverse/exports.dart';

class SupabaseController extends GetxController {
  static SupabaseController get to => Get.find();

  SupabaseClient? supabase;

  @override
  Future<void> onInit() async {
    super.onInit();

    supabase = Supabase.instance.client;
  }

  SupabaseQueryBuilder from(AutoTable table) =>
      supabase!.schema("public").from(table.name);

  Future<List<Mark>> getPopularMarks() async {
    return tryCatch(() async {
      final response = await from(AutoTable.mark).select().eq("popular", 1);

      List<Mark> marks = marksFromJson(response);

      return marks;
    });
  }

  Future<List<Mark>> getMarks() async {
    try {
      final response = await from(AutoTable.mark).select();

      List<Mark> marks = marksFromJson(response);
      return marks;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<List<Model>> getModels(String markId) async {
    try {
      final response = await from(AutoTable.model)
          .select('*, generation(*, configuration(*))')
          .eq('mark_id', markId);

      List<Model> models = modelsFromJson(response);
      return models;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<List<Configuration>> getConfigurations(String generationId) async {
    try {
      final response = await from(AutoTable.configuration)
          .select()
          .eq('generation_id', generationId);

      List<Configuration> configurations = configurationsFromJson(response);

      return configurations;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<List<Modification>> getModifications(String configurationId) async {
    final response = await from(AutoTable.modification)
        .select(
            '*, specifications!inner(volume-litres, transmission, horse-power)')
        .eq('configuration_id', configurationId);
    log(response);
    final modifications = response.map((modification) {
      final specification = modification['specifications'].first;
      final volumeLitres = double.tryParse(specification['volume-litres']);
      final transmission = specification['transmission'];
      final horsePower = specification['horse-power'];
      modification["specifications"] = [];

      // Определяем тип трансмиссии
      String transmissionType;
      switch (transmission) {
        case 'механическая':
          transmissionType = 'MT';
          break;
        case 'автоматическая':
          transmissionType = 'AT';
          break;
        case 'робот':
          transmissionType = 'AMT';
          break;
        case 'вариатор':
          transmissionType = 'CVT';
          break;
        default:
          transmissionType = 'Unknown';
      }

      // Формируем modification_title
      final modificationTitle = '$volumeLitres $transmissionType $horsePower';

      return {
        ...modification,
        'modification_title': modificationTitle,
      };
    }).toList();

    List<Modification> modificataions = modificationsFromJson(modifications);
    return modificataions;
  }

  Future<CarSpecifications> getSpecifications(String complecatationId) async {
    try {
      final response = await from(AutoTable.specifications)
          .select('*')
          .eq('complectation_id', complecatationId);

      CarSpecifications specifications =
          CarSpecifications.fromJson(response.first);
      return specifications;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }

  Future<CarOptions> getOptions(String complecatationId) async {
    try {
      final response = await from(AutoTable.options)
          .select('*')
          .eq('complectation_id', complecatationId);

      if (response.isEmpty) return CarOptions();
      CarOptions options = CarOptions.fromJson(response.first);
      return options;
    } catch (error) {
      logW(error);
      rethrow;
    }
  }
}

enum AutoTable {
  configuration,
  generation,
  mark,
  model,
  modification,
  options,
  specifications
}
