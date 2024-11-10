import 'package:autoverse/exports.dart';

class SupabaseController extends GetxController {
  static SupabaseController get to => Get.find();

  SupabaseClient? supabase;

  Future<void> onInitComplete() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    supabase = Supabase.instance.client;
    super.onInit();
  }

  List<String> ids = ['22738666', '21491985', '21596394', '21468406'];

  Future<List<Car>> getWeeklyCars() async => await tryCatch(
        () async {
          List<Car> cars = [];
          final response = await from(AutoTable.configuration)
              .select('*, generation(*, model(*, mark(*)))')
              .inFilter("id", ids);

          for (Map<String, dynamic> json in response) {
            Car? car = await getWeeklyCar(json);
            if (car != null) cars.add(car);
          }
          log(cars.length);
          return cars;
        },
      );

  Future<Car>? getWeeklyCar(Map<String, dynamic> id) {
    return tryCatch(() async {
      final carJson = id;

      final configuration = Configuration.fromJson(carJson);
      final generation = Generation.fromJson(carJson['generation'] ?? {});
      final model = Model.fromJson(carJson['generation']['model'] ?? {});
      final mark = Mark.fromJson(carJson['generation']['model']['mark'] ?? {});

      final car = Car(
        mark: mark,
        model: model,
        generation: generation,
        configuration: configuration,
      );

      return car;
    });
  }

  SupabaseQueryBuilder from(AutoTable table) =>
      supabase!.schema("public").from(table.name);

  Future<List<Mark>> getPopularMarks() async {
    return tryCatch(() async {
      final response = await from(AutoTable.mark).select().eq("popular", 1);
      log(response);
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

  Future<String> getModificationDescription(String configurationId) async {
    try {
      // Получаем модификации для данной конфигурации
      final response = await from(AutoTable.modification)
          .select('*, specifications(*)')
          .eq('configuration_id', configurationId);

      final modifications = response as List<dynamic>;

      // Если модификации пусты
      if (modifications.isEmpty) {
        return "No modifications found";
      }

      // Собираем необходимые данные для описания
      final transmissionSet = <String>{};
      final driveSet = <String>{};
      final enginesSet = <String>{};
      final volumeLitres = <double>[];
      final power = <double>[];

      for (final mod in modifications) {
        if (mod['specifications'] != null && mod['specifications'].isNotEmpty) {
          transmissionSet.add(mod['specifications'][0]['transmission']);
          driveSet.add(mod['specifications'][0]['drive']);
          enginesSet
              .add(mod['specifications'][0]['engine-type']); // Тип двигателя

          if (mod['specifications'][0]['volume-litres'] != null) {
            volumeLitres.add(double.parse(
                mod['specifications'][0]['volume-litres'].toString()));
          }
          if (mod['specifications'][0]['horse-power'] != null) {
            power.add(double.parse(
                mod['specifications'][0]['horse-power'].toString()));
          }
        }
      }

      // Формируем строки описания
      final driveDesc =
          getSpecDescription(driveSet.toList(), 'привод', 'привод');
      final transmissionDesc =
          "Коробка ${getSpecDescription(transmissionSet.toList(), '', '')}";
      final engineDesc =
          "Типы двигателей: ${getSpecDescription(enginesSet.toList(), '', '')}";
      final volumeDesc = getMinMaxVolumeDescription(volumeLitres);
      final powerDesc = getMinMaxPowerDescription(power);

      // Финальное описание
      final description =
          "$driveDesc. $transmissionDesc. $engineDesc$volumeDesc $powerDesc";

      return description;
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }

// Вспомогательные функции
  String getSpecDescription(
      List<String> specs, String singlePrefix, String multiplePrefix) {
    if (specs.isEmpty) return "";
    if (specs.length == 1) return "${specs[0]} $singlePrefix".trim();
    if (specs.length == 2) {
      return "${specs[0]} и ${specs[1]} $multiplePrefix".trim();
    }
    final lastSpec = specs.removeLast();
    return "${specs.join(', ')} и $lastSpec $multiplePrefix".trim();
  }

  String getMinMaxVolumeDescription(List<double> volumeLitres) {
    if (volumeLitres.isEmpty) return "";
    volumeLitres.sort();
    final minVolume = volumeLitres.first;
    final maxVolume = volumeLitres.last;
    if (minVolume == maxVolume) return ", объёмом от $minVolume л. и";
    return ", объёмом от $minVolume до $maxVolume л. и";
  }

  String getMinMaxPowerDescription(List<double> power) {
    if (power.isEmpty) return "";
    power.sort();
    final minPower = power.first;
    final maxPower = power.last;
    if (minPower == maxPower) return "мощностью от $minPower л.с.";
    return "мощностью от $minPower до $maxPower л.с.";
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
