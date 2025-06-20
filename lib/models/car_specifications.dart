class CarSpecifications {
  final String? complectationId;
  final String? backBrake;
  final String? feeding;
  final int? horsePower; // Power is typically an integer
  final double? kvtPower; // Kilowatts are usually represented as a double
  final int? rpmPower; // RPM is an integer value
  final String? engineType;
  final String? transmission;
  final String? drive;
  final double? volume; // Volume is generally a double (e.g., liters)
  final double? timeTo100; // Time to 100km/h is a double
  final String? cylindersOrder;
  final int? maxSpeed; // Speed is typically an integer
  final double? compression; // Compression ratio is a double
  final int? cylindersValue; // Number of cylinders is an integer
  final double? diametr; // Diameter is usually a double
  final double? pistonStroke; // Stroke length is usually a double
  final String? engineFeeding;
  final String? engineOrder;
  final int? gearValue; // Number of gears is an integer
  final double? moment; // Torque (moment) is generally a double
  final String? petrolType;
  final int? valves; // Number of valves is an integer
  final int? weight; // Weight is generally an integer (e.g., kilograms)
  final String? wheelSize;
  final double? wheelBase; // Wheelbase is usually a double (e.g., meters)
  final double? frontWheelBase; // Front wheelbase is typically a double
  final double? backWheelBase; // Back wheelbase is typically a double
  final String? frontBrake;
  final String? frontSuspension;
  final String? backSuspension;
  final int? height; // Height is typically a double (e.g., meters)
  final int? width; // Width is typically a double (e.g., meters)
  final double?
      fuelTankCapacity; // Fuel tank capacity is usually a double (e.g., liters)
  final int? seats; // Number of seats is an integer
  final int? length; // Length is typically a double (e.g., meters)
  final String? emissionEuroClass;
  final double? volumeLitres; // Volume (liters) is typically a double
  final double?
      consumptionMixed; // Fuel consumption is usually a double (e.g., liters/100km)
  final double?
      clearance; // Ground clearance is typically a double (e.g., meters)
  final double? trunksMinCapacity; // Trunk capacity is usually a double
  final double? trunksMaxCapacity; // Trunk capacity is usually a double
  final double? consumptionHiway; // Highway consumption is typically a double
  final double? consumptionCity; // City consumption is typically a double
  final int? momentRpm; // RPM for torque is generally an integer
  final int?
      fullWeight; // Full weight is typically an integer (e.g., kilograms)
  final double?
      rangeDistance; // Range distance is typically a double (e.g., kilometers)
  final double?
      batteryCapacity; // Battery capacity is usually a double (e.g., kWh)
  final double? fuelEmission; // Fuel emissions is usually a double (e.g., g/km)
  final double?
      electricRange; // Electric range is typically a double (e.g., kilometers)
  final double? chargeTime; // Charge time is usually a double (e.g., hours)
  final int? safetyRating; // Safety rating is typically an integer
  final String? safetyGrade;

  CarSpecifications({
    this.complectationId,
    this.backBrake,
    this.feeding,
    this.horsePower,
    this.kvtPower,
    this.rpmPower,
    this.engineType,
    this.transmission,
    this.drive,
    this.volume,
    this.timeTo100,
    this.cylindersOrder,
    this.maxSpeed,
    this.compression,
    this.cylindersValue,
    this.diametr,
    this.pistonStroke,
    this.engineFeeding,
    this.engineOrder,
    this.gearValue,
    this.moment,
    this.petrolType,
    this.valves,
    this.weight,
    this.wheelSize,
    this.wheelBase,
    this.frontWheelBase,
    this.backWheelBase,
    this.frontBrake,
    this.frontSuspension,
    this.backSuspension,
    this.height,
    this.width,
    this.fuelTankCapacity,
    this.seats,
    this.length,
    this.emissionEuroClass,
    this.volumeLitres,
    this.consumptionMixed,
    this.clearance,
    this.trunksMinCapacity,
    this.trunksMaxCapacity,
    this.consumptionHiway,
    this.consumptionCity,
    this.momentRpm,
    this.fullWeight,
    this.rangeDistance,
    this.batteryCapacity,
    this.fuelEmission,
    this.electricRange,
    this.chargeTime,
    this.safetyRating,
    this.safetyGrade,
  });

  List<Map<String, dynamic>> getEngineSpecifications() {
    return [
      {
        'name': 'Мощность (л.с.)',
        'value': horsePower,
        'compareType': CompareType.higher
      },
      {
        'name': 'Мощность (кВт)',
        'value': kvtPower,
        'compareType': CompareType.higher
      },
      {
        'name': 'Обороты мощности (RPM)',
        'value': rpmPower,
        'compareType': CompareType.higher
      },
      {
        'name': 'Тип двигателя',
        'value': engineType,
        'compareType': CompareType.none
      },
      {'name': 'Объем', 'value': volume, 'compareType': CompareType.higher},
      {
        'name': 'Порядок цилиндров',
        'value': cylindersOrder,
        'compareType': CompareType.none
      },
      {
        'name': 'Степень сжатия',
        'value': compression,
        'compareType': CompareType.higher
      },
      {
        'name': 'Количество цилиндров',
        'value': cylindersValue,
        'compareType': CompareType.higher
      },
      {
        'name': 'Диаметр цилиндра',
        'value': diametr,
        'compareType': CompareType.higher
      },
      {
        'name': 'Ход поршня',
        'value': pistonStroke,
        'compareType': CompareType.higher
      },
      {
        'name': 'Система питания',
        'value': engineFeeding,
        'compareType': CompareType.none
      },
      {
        'name': 'Порядок работы цилиндров',
        'value': engineOrder,
        'compareType': CompareType.none
      },
      {
        'name': 'Крутящий момент',
        'value': moment,
        'compareType': CompareType.higher
      },
      {
        'name': 'Обороты крутящего момента',
        'value': momentRpm,
        'compareType': CompareType.higher
      },
    ];
  }

  List<Map<String, dynamic>> getSafetySpecifications() {
    return [
      {
        'name': 'Рейтинг безопасности',
        'value': safetyRating,
        'compareType': CompareType.higher
      },
      {
        'name': 'Оценка безопасности',
        'value': safetyGrade,
        'compareType': CompareType.none
      },
    ];
  }

  factory CarSpecifications.fromJson(Map<String, dynamic> json) {
    return CarSpecifications(
      complectationId: json['complectation_id'] ?? '',
      backBrake: json['back-brake'] ?? '',
      feeding: json['feeding'] ?? '',
      horsePower: int.tryParse(json['horse-power'] ?? '0') ?? 0,
      kvtPower: double.tryParse(json['kvt-power'] ?? '0') ?? 0,
      rpmPower: int.tryParse(json['rpm-power'] ?? '0') ?? 0,
      engineType: json['engine-type'] ?? '',
      transmission: json['transmission'] ?? '',
      drive: json['drive'] ?? '',
      volume: double.tryParse(json['volume'] ?? '0') ?? 0,
      timeTo100: double.tryParse(json['time-to-100'] ?? '0') ?? 0,
      cylindersOrder: json['cylinders-order'] ?? '',
      maxSpeed: int.tryParse(json['max-speed'] ?? '0') ?? 0,
      compression: double.tryParse(json['compression'] ?? '0') ?? 0,
      cylindersValue: int.tryParse(json['cylinders-value'] ?? '0') ?? 0,
      diametr: double.tryParse(json['diametr'] ?? '0') ?? 0,
      pistonStroke: double.tryParse(json['piston-stroke'] ?? '0') ?? 0,
      engineFeeding: json['engine-feeding'] ?? '',
      engineOrder: json['engine-order'] ?? '',
      gearValue: int.tryParse(json['gear-value'] ?? '0') ?? 0,
      moment: double.tryParse(json['moment'] ?? '0') ?? 0,
      petrolType: json['petrol-type'] ?? '',
      valves: int.tryParse(json['valves'] ?? '0') ?? 0,
      weight: int.tryParse(json['weight'] ?? '0') ?? 0,
      wheelSize: json['wheel-size'] ?? '',
      wheelBase: double.tryParse(json['wheel-base'] ?? '0') ?? 0,
      frontWheelBase: double.tryParse(json['front-wheel-base'] ?? '0') ?? 0,
      backWheelBase: double.tryParse(json['back-wheel-base'] ?? '0') ?? 0,
      frontBrake: json['front-brake'] ?? '',
      frontSuspension: json['front-suspension'] ?? '',
      backSuspension: json['back-suspension'] ?? '',
      height: int.tryParse(json['height'] ?? '0') ?? 0,
      width: int.tryParse(json['width'] ?? '0') ?? 0,
      fuelTankCapacity: double.tryParse(json['fuel-tank-capacity'] ?? '0') ?? 0,
      seats: int.tryParse(json['seats'] ?? '0') ?? 0,
      length: int.tryParse(json['length'] ?? '0') ?? 0,
      emissionEuroClass: json['emission-euro-class'] ?? '',
      volumeLitres: double.tryParse(json['volume-litres'] ?? '0') ?? 0,
      consumptionMixed: double.tryParse(json['consumption-mixed'] ?? '0') ?? 0,
      clearance: double.tryParse(json['clearance'] ?? '0') ?? 0,
      trunksMinCapacity:
          double.tryParse(json['trunks-min-capacity'] ?? '0') ?? 0,
      trunksMaxCapacity:
          double.tryParse(json['trunks-max-capacity'] ?? '0') ?? 0,
      consumptionHiway: double.tryParse(json['consumption-hiway'] ?? '0') ?? 0,
      consumptionCity: double.tryParse(json['consumption-city'] ?? '0') ?? 0,
      momentRpm: int.tryParse(json['moment-rpm'] ?? '0') ?? 0,
      fullWeight: int.tryParse(json['full-weight'] ?? '0') ?? 0,
      rangeDistance: double.tryParse(json['range-distance'] ?? '0') ?? 0,
      batteryCapacity: double.tryParse(json['battery-capacity'] ?? '0') ?? 0,
      fuelEmission: double.tryParse(json['fuel-emission'] ?? '0') ?? 0,
      electricRange: double.tryParse(json['electric-range'] ?? '0') ?? 0,
      chargeTime: double.tryParse(json['charge-time'] ?? '0') ?? 0,
      safetyRating: int.tryParse(json['safety-rating'] ?? '0') ?? 0,
      safetyGrade: json['safety-grade'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'complectation_id': complectationId,
        'drive': drive,
        'transmission': transmission,
        'volume': volume,
        'horse-power': horsePower,
        'kvt-power': kvtPower,
        'moment': moment,
        'moment-rpm': momentRpm,
        'rpm-power': rpmPower,
        'cylinders-order': cylindersOrder,
        'cylinders-value': cylindersValue,
        'valves': valves,
        'engine-feeding': engineFeeding,
        'compression': compression,
        'diametr': diametr,
        'piston-stroke': pistonStroke,
        'electric-range': electricRange,
        'battery-capacity': batteryCapacity,
        'charge-time': chargeTime,
        'weight': weight,
        'wheel-size': wheelSize,
        'wheel-base': wheelBase,
        'front-wheel-base': frontWheelBase,
        'back-wheel-base': backWheelBase,
        'front-brake': frontBrake,
        'front-suspension': frontSuspension,
        'back-suspension': backSuspension,
        'height': height,
        'width': width,
        'fuel-tank-capacity': fuelTankCapacity,
        'seats': seats,
        'length': length,
        'emission-euro-class': emissionEuroClass,
        'volume-litres': volumeLitres,
        'consumption-mixed': consumptionMixed,
        'clearance': clearance,
        'trunks-min-capacity': trunksMinCapacity,
        'trunks-max-capacity': trunksMaxCapacity,
        'consumption-hiway': consumptionHiway,
        'consumption-city': consumptionCity,
        'full-weight': fullWeight,
        'range-distance': rangeDistance,
        'fuel-emission': fuelEmission,
        'safety-rating': safetyRating,
        'safety-grade': safetyGrade,
      };
}

enum CompareType {
  higher, // Большее значение лучше
  lower, // Меньшее значение лучше
  none, // Нет числового сравнения
}
