class Specifications {
  final Brake? backBrake;
  final Feeding? feeding;
  final int? horsePower;
  final int? kvtPower;
  final List<int>? rpmPower;
  final EngineType? engineType;
  final Transmission? transmission;
  final Drive? drive;
  final int? volume;
  final double? timeTo100;
  final CylindersOrder? cylindersOrder;
  final int? maxSpeed;
  final double? compression;
  final int? cylindersValue;
  final double? diametr;
  final double? pistonStroke;
  final EngineFeeding? engineFeeding;
  final EngineOrder? engineOrder;
  final int? gearValue;
  final int? moment;
  final PetrolType? petrolType;
  final int? valves;
  final int? weight;
  final List<String>? wheelSize;
  final int? wheelBase;
  final int? frontWheelBase;
  final int? backWheelBase;
  final Brake? frontBrake;
  final Suspension? frontSuspension;
  final Suspension? backSuspension;
  final int? height;
  final int? width;
  final int? fuelTankCapacity;
  final List<String>? seats;
  final int? length;
  final int? doorsCount;
  final EmissionEuroClass? emissionEuroClass;
  final double? volumeLitres;
  final double? consumptionMixed;
  final List<int>? clearance;
  final int? trunksMinCapacity;
  final int? trunksMaxCapacity;
  final double? consumptionHiway;
  final double? consumptionCity;
  final List<int>? momentRpm;
  final int? fullWeight;
  final int? rangeDistance;
  final double? batteryCapacity;
  final int? fuelEmission;
  final int? electricRange;
  final double? chargeTime;
  final SafetyRating? safetyRating;
  final int? safetyGrade;

  Specifications({
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
    this.doorsCount,
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

  factory Specifications.fromJson(Map<String, dynamic> json) => Specifications(
        backBrake: brakeValues.map[json["back-brake"]]!,
        feeding: feedingValues.map[json["feeding"]]!,
        horsePower: json["horse-power"],
        kvtPower: json["kvt-power"],
        rpmPower: json["rpm-power"] == null
            ? []
            : List<int>.from(json["rpm-power"]!.map((x) => x)),
        engineType: engineTypeValues.map[json["engine-type"]]!,
        transmission: transmissionValues.map[json["transmission"]]!,
        drive: driveValues.map[json["drive"]]!,
        volume: json["volume"],
        timeTo100: json["time-to-100"]?.toDouble(),
        cylindersOrder: cylindersOrderValues.map[json["cylinders-order"]]!,
        maxSpeed: json["max-speed"],
        compression: json["compression"]?.toDouble(),
        cylindersValue: json["cylinders-value"],
        diametr: json["diametr"]?.toDouble(),
        pistonStroke: json["piston-stroke"]?.toDouble(),
        engineFeeding: engineFeedingValues.map[json["engine-feeding"]]!,
        engineOrder: engineOrderValues.map[json["engine-order"]]!,
        gearValue: json["gear-value"],
        moment: json["moment"],
        petrolType: petrolTypeValues.map[json["petrol-type"]]!,
        valves: json["valves"],
        weight: json["weight"],
        wheelSize: json["wheel-size"] == null
            ? []
            : List<String>.from(json["wheel-size"]!.map((x) => x)),
        wheelBase: json["wheel-base"],
        frontWheelBase: json["front-wheel-base"],
        backWheelBase: json["back-wheel-base"],
        frontBrake: brakeValues.map[json["front-brake"]]!,
        frontSuspension: suspensionValues.map[json["front-suspension"]]!,
        backSuspension: suspensionValues.map[json["back-suspension"]]!,
        height: json["height"],
        width: json["width"],
        fuelTankCapacity: json["fuel-tank-capacity"],
        seats: json["seats"] == null
            ? []
            : List<String>.from(json["seats"]!.map((x) => x)),
        length: json["length"],
        doorsCount: json["doors-count"],
        emissionEuroClass:
            emissionEuroClassValues.map[json["emission-euro-class"]]!,
        volumeLitres: json["volume-litres"]?.toDouble(),
        consumptionMixed: json["consumption-mixed"]?.toDouble(),
        clearance: json["clearance"] == null
            ? []
            : List<int>.from(json["clearance"]!.map((x) => x)),
        trunksMinCapacity: json["trunks-min-capacity"],
        trunksMaxCapacity: json["trunks-max-capacity"],
        consumptionHiway: json["consumption-hiway"]?.toDouble(),
        consumptionCity: json["consumption-city"]?.toDouble(),
        momentRpm: json["moment-rpm"] == null
            ? []
            : List<int>.from(json["moment-rpm"]!.map((x) => x)),
        fullWeight: json["full-weight"],
        rangeDistance: json["range-distance"],
        batteryCapacity: json["battery-capacity"]?.toDouble(),
        fuelEmission: json["fuel-emission"],
        electricRange: json["electric-range"],
        chargeTime: json["charge-time"]?.toDouble(),
        safetyRating: safetyRatingValues.map[json["safety-rating"]]!,
        safetyGrade: json["safety-grade"],
      );

  Map<String, dynamic> toJson() => {
        "back-brake": brakeValues.reverse[backBrake],
        "feeding": feedingValues.reverse[feeding],
        "horse-power": horsePower,
        "kvt-power": kvtPower,
        "rpm-power":
            rpmPower == null ? [] : List<dynamic>.from(rpmPower!.map((x) => x)),
        "engine-type": engineTypeValues.reverse[engineType],
        "transmission": transmissionValues.reverse[transmission],
        "drive": driveValues.reverse[drive],
        "volume": volume,
        "time-to-100": timeTo100,
        "cylinders-order": cylindersOrderValues.reverse[cylindersOrder],
        "max-speed": maxSpeed,
        "compression": compression,
        "cylinders-value": cylindersValue,
        "diametr": diametr,
        "piston-stroke": pistonStroke,
        "engine-feeding": engineFeedingValues.reverse[engineFeeding],
        "engine-order": engineOrderValues.reverse[engineOrder],
        "gear-value": gearValue,
        "moment": moment,
        "petrol-type": petrolTypeValues.reverse[petrolType],
        "valves": valves,
        "weight": weight,
        "wheel-size": wheelSize == null
            ? []
            : List<dynamic>.from(wheelSize!.map((x) => x)),
        "wheel-base": wheelBase,
        "front-wheel-base": frontWheelBase,
        "back-wheel-base": backWheelBase,
        "front-brake": brakeValues.reverse[frontBrake],
        "front-suspension": suspensionValues.reverse[frontSuspension],
        "back-suspension": suspensionValues.reverse[backSuspension],
        "height": height,
        "width": width,
        "fuel-tank-capacity": fuelTankCapacity,
        "seats": seats == null ? [] : List<dynamic>.from(seats!.map((x) => x)),
        "length": length,
        "doors-count": doorsCount,
        "emission-euro-class":
            emissionEuroClassValues.reverse[emissionEuroClass],
        "volume-litres": volumeLitres,
        "consumption-mixed": consumptionMixed,
        "clearance": clearance == null
            ? []
            : List<dynamic>.from(clearance!.map((x) => x)),
        "trunks-min-capacity": trunksMinCapacity,
        "trunks-max-capacity": trunksMaxCapacity,
        "consumption-hiway": consumptionHiway,
        "consumption-city": consumptionCity,
        "moment-rpm": momentRpm == null
            ? []
            : List<dynamic>.from(momentRpm!.map((x) => x)),
        "full-weight": fullWeight,
        "range-distance": rangeDistance,
        "battery-capacity": batteryCapacity,
        "fuel-emission": fuelEmission,
        "electric-range": electricRange,
        "charge-time": chargeTime,
        "safety-rating": safetyRatingValues.reverse[safetyRating],
        "safety-grade": safetyGrade,
      };
}

enum Brake { BRAKE, EMPTY, FLUFFY, PURPLE }

final brakeValues = EnumValues({
  "дисковые вентилируемые": Brake.BRAKE,
  "дисковые": Brake.EMPTY,
  "керамические вентилируемые": Brake.FLUFFY,
  "барабанные": Brake.PURPLE
});

enum Suspension {
  EMPTY,
  FLUFFY,
  INDECENT,
  INDIGO,
  PURPLE,
  STICKY,
  SUSPENSION,
  TENTACLED
}

final suspensionValues = EnumValues({
  "независимая, пружинная": Suspension.EMPTY,
  "зависимая, рессорная": Suspension.FLUFFY,
  "полунезависимая, торсионная": Suspension.INDECENT,
  "зависимая, пружинная": Suspension.INDIGO,
  "независимая, пневмоэлемент": Suspension.PURPLE,
  "полунезависимая, пружинная": Suspension.STICKY,
  "независимая, торсионная": Suspension.SUSPENSION,
  "независимая, рессорная": Suspension.TENTACLED
});

enum CylindersOrder { CYLINDERS_ORDER, EMPTY, V }

final cylindersOrderValues = EnumValues({
  "оппозитное": CylindersOrder.CYLINDERS_ORDER,
  "рядное": CylindersOrder.EMPTY,
  "V-образное": CylindersOrder.V
});

enum Drive { DRIVE, EMPTY, PURPLE }

final driveValues = EnumValues(
    {"передний": Drive.DRIVE, "задний": Drive.EMPTY, "полный": Drive.PURPLE});

enum EmissionEuroClass { EURO_3, EURO_4, EURO_5, EURO_6 }

final emissionEuroClassValues = EnumValues({
  "Euro 3": EmissionEuroClass.EURO_3,
  "Euro 4": EmissionEuroClass.EURO_4,
  "Euro 5": EmissionEuroClass.EURO_5,
  "Euro 6": EmissionEuroClass.EURO_6
});

enum EngineFeeding {
  EMPTY,
  ENGINE_FEEDING,
  FLUFFY,
  INDIGO,
  PURPLE,
  STICKY,
  TENTACLED
}

final engineFeedingValues = EnumValues({
  "распределенный впрыск (многоточечный)": EngineFeeding.EMPTY,
  "центральный впрыск (моновпрыск или одноточечный)":
      EngineFeeding.ENGINE_FEEDING,
  "непосредственный впрыск (прямой)": EngineFeeding.FLUFFY,
  "аккумуляторная топливная система": EngineFeeding.INDIGO,
  "карбюратор": EngineFeeding.PURPLE,
  "топливный насос высокого давления": EngineFeeding.STICKY,
  "комбинированный впрыск (непосредственно-распределенный)":
      EngineFeeding.TENTACLED
});

enum EngineOrder { EMPTY, ENGINE_ORDER, FLUFFY, PURPLE }

final engineOrderValues = EnumValues({
  "переднее, продольное": EngineOrder.EMPTY,
  "переднее, поперечное": EngineOrder.ENGINE_ORDER,
  "заднее": EngineOrder.FLUFFY,
  "центральное": EngineOrder.PURPLE
});

enum EngineType { EMPTY, ENGINE_TYPE, FLUFFY, PURPLE, TENTACLED }

final engineTypeValues = EnumValues({
  "бензин": EngineType.EMPTY,
  "гибрид": EngineType.ENGINE_TYPE,
  "дизель": EngineType.FLUFFY,
  "электро": EngineType.PURPLE,
  "СУГ": EngineType.TENTACLED
});

enum Feeding { EMPTY, FEEDING, PURPLE }

final feedingValues = EnumValues({
  "нет": Feeding.EMPTY,
  "турбонаддув": Feeding.FEEDING,
  "компрессор": Feeding.PURPLE
});

enum PetrolType { EMPTY, PETROL_TYPE, THE_76, THE_80, THE_92, THE_95, THE_98 }

final petrolTypeValues = EnumValues({
  "ДТ": PetrolType.EMPTY,
  "газ": PetrolType.PETROL_TYPE,
  "АИ-76": PetrolType.THE_76,
  "АИ-80": PetrolType.THE_80,
  "АИ-92": PetrolType.THE_92,
  "АИ-95": PetrolType.THE_95,
  "АИ-98": PetrolType.THE_98
});

enum SafetyRating { EURO_NCAP }

final safetyRatingValues = EnumValues({"EuroNCAP": SafetyRating.EURO_NCAP});

enum Transmission { EMPTY, FLUFFY, PURPLE, TRANSMISSION }

final transmissionValues = EnumValues({
  "механическая": Transmission.EMPTY,
  "вариатор": Transmission.FLUFFY,
  "робот": Transmission.PURPLE,
  "автоматическая": Transmission.TRANSMISSION
});

enum Notice {
  BERLINA,
  CROSSWAGON_Q4,
  EMPTY,
  GRAN_COUPE,
  JUNIOR_Z,
  L,
  LWB,
  NOTICE,
  PULLMAN,
  PURPLE,
  S,
  SPEEDSTER,
  SPIDER,
  SPRINT,
  SPYDER,
  THE_17502000_BERLINA,
  VOLANTE,
  VOLANTE_S
}

final noticeValues = EnumValues({
  "Berlina": Notice.BERLINA,
  "Crosswagon Q4": Notice.CROSSWAGON_Q4,
  "": Notice.EMPTY,
  "Gran Coupe": Notice.GRAN_COUPE,
  "Junior Z": Notice.JUNIOR_Z,
  "L": Notice.L,
  "LWB": Notice.LWB,
  "Открытый": Notice.NOTICE,
  "Pullman": Notice.PULLMAN,
  "Жёсткий верх": Notice.PURPLE,
  "S": Notice.S,
  "Speedster": Notice.SPEEDSTER,
  "Spider": Notice.SPIDER,
  "Sprint": Notice.SPRINT,
  "Spyder": Notice.SPYDER,
  "1750/2000 Berlina": Notice.THE_17502000_BERLINA,
  "Volante": Notice.VOLANTE,
  "Volante S": Notice.VOLANTE_S
});

enum Class { A, B, C, D, E, EMPTY, F, J, M, S }

final classValues = EnumValues({
  "A": Class.A,
  "B": Class.B,
  "C": Class.C,
  "D": Class.D,
  "E": Class.E,
  "": Class.EMPTY,
  "F": Class.F,
  "J": Class.J,
  "M": Class.M,
  "S": Class.S
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
