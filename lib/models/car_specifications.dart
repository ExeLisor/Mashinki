class CarSpecifications {
  final String complectationId;
  final String backBrake;
  final String feeding;
  final String horsePower;
  final String kvtPower;
  final String rpmPower;
  final String engineType;
  final String transmission;
  final String drive;
  final String volume;
  final String timeTo100;
  final String cylindersOrder;
  final String maxSpeed;
  final String compression;
  final String cylindersValue;
  final String diametr;
  final String pistonStroke;
  final String engineFeeding;
  final String engineOrder;
  final String gearValue;
  final String moment;
  final String petrolType;
  final String valves;
  final String weight;
  final String wheelSize;
  final String wheelBase;
  final String frontWheelBase;
  final String backWheelBase;
  final String frontBrake;
  final String frontSuspension;
  final String backSuspension;
  final String height;
  final String width;
  final String fuelTankCapacity;
  final String seats;
  final String length;
  final String emissionEuroClass;
  final String volumeLitres;
  final String consumptionMixed;
  final String clearance;
  final String trunksMinCapacity;
  final String trunksMaxCapacity;
  final String consumptionHiway;
  final String consumptionCity;
  final String momentRpm;
  final String fullWeight;
  final String rangeDistance;
  final String batteryCapacity;
  final String fuelEmission;
  final String electricRange;
  final String chargeTime;
  final String safetyRating;
  final String safetyGrade;

  CarSpecifications({
    required this.complectationId,
    required this.backBrake,
    required this.feeding,
    required this.horsePower,
    required this.kvtPower,
    required this.rpmPower,
    required this.engineType,
    required this.transmission,
    required this.drive,
    required this.volume,
    required this.timeTo100,
    required this.cylindersOrder,
    required this.maxSpeed,
    required this.compression,
    required this.cylindersValue,
    required this.diametr,
    required this.pistonStroke,
    required this.engineFeeding,
    required this.engineOrder,
    required this.gearValue,
    required this.moment,
    required this.petrolType,
    required this.valves,
    required this.weight,
    required this.wheelSize,
    required this.wheelBase,
    required this.frontWheelBase,
    required this.backWheelBase,
    required this.frontBrake,
    required this.frontSuspension,
    required this.backSuspension,
    required this.height,
    required this.width,
    required this.fuelTankCapacity,
    required this.seats,
    required this.length,
    required this.emissionEuroClass,
    required this.volumeLitres,
    required this.consumptionMixed,
    required this.clearance,
    required this.trunksMinCapacity,
    required this.trunksMaxCapacity,
    required this.consumptionHiway,
    required this.consumptionCity,
    required this.momentRpm,
    required this.fullWeight,
    required this.rangeDistance,
    required this.batteryCapacity,
    required this.fuelEmission,
    required this.electricRange,
    required this.chargeTime,
    required this.safetyRating,
    required this.safetyGrade,
  });

  factory CarSpecifications.fromJson(Map<String, dynamic> json) {
    return CarSpecifications(
      complectationId: json['complectation_id'] ?? '',
      backBrake: json['back-brake'] ?? '',
      feeding: json['feeding'] ?? '',
      horsePower: json['horse-power'] ?? '',
      kvtPower: json['kvt-power'] ?? '',
      rpmPower: json['rpm-power'] ?? '',
      engineType: json['engine-type'] ?? '',
      transmission: json['transmission'] ?? '',
      drive: json['drive'] ?? '',
      volume: json['volume'] ?? '',
      timeTo100: json['time-to-100'] ?? '',
      cylindersOrder: json['cylinders-order'] ?? '',
      maxSpeed: json['max-speed'] ?? '',
      compression: json['compression'] ?? '',
      cylindersValue: json['cylinders-value'] ?? '',
      diametr: json['diametr'] ?? '',
      pistonStroke: json['piston-stroke'] ?? '',
      engineFeeding: json['engine-feeding'] ?? '',
      engineOrder: json['engine-order'] ?? '',
      gearValue: json['gear-value'] ?? '',
      moment: json['moment'] ?? '',
      petrolType: json['petrol-type'] ?? '',
      valves: json['valves'] ?? '',
      weight: json['weight'] ?? '',
      wheelSize: json['wheel-size'] ?? '',
      wheelBase: json['wheel-base'] ?? '',
      frontWheelBase: json['front-wheel-base'] ?? '',
      backWheelBase: json['back-wheel-base'] ?? '',
      frontBrake: json['front-brake'] ?? '',
      frontSuspension: json['front-suspension'] ?? '',
      backSuspension: json['back-suspension'] ?? '',
      height: json['height'] ?? '',
      width: json['width'] ?? '',
      fuelTankCapacity: json['fuel-tank-capacity'] ?? '',
      seats: json['seats'] ?? '',
      length: json['length'] ?? '',
      emissionEuroClass: json['emission-euro-class'] ?? '',
      volumeLitres: json['volume-litres'] ?? '',
      consumptionMixed: json['consumption-mixed'] ?? '',
      clearance: json['clearance'] ?? '',
      trunksMinCapacity: json['trunks-min-capacity'] ?? '',
      trunksMaxCapacity: json['trunks-max-capacity'] ?? '',
      consumptionHiway: json['consumption-hiway'] ?? '',
      consumptionCity: json['consumption-city'] ?? '',
      momentRpm: json['moment-rpm'] ?? '',
      fullWeight: json['full-weight'] ?? '',
      rangeDistance: json['range-distance'] ?? '',
      batteryCapacity: json['battery-capacity'] ?? '',
      fuelEmission: json['fuel-emission'] ?? '',
      electricRange: json['electric-range'] ?? '',
      chargeTime: json['charge-time'] ?? '',
      safetyRating: json['safety-rating'] ?? '',
      safetyGrade: json['safety-grade'] ?? '',
    );
  }
}
