enum CarBodyType {
  // Группа: Купе
  coupe("купе", "assets/configurations/coupe.svg"),
  coupeHardtop("купе-хардтоп",
      "assets/configurations/coupe.svg"), // Используем coupe как аналог

  // Группа: Родстер
  roadster("родстер",
      "assets/configurations/cabrio.svg"), // Используем cabrio как аналог

  // Группа: Седан
  sedan("седан", "assets/configurations/sedan.svg"),
  sedan2Doors("седан 2 дв.",
      "assets/configurations/sedan.svg"), // Используем sedan как аналог
  sedanHardtop("седан-хардтоп",
      "assets/configurations/sedan.svg"), // Используем sedan как аналог

  // Группа: Хэтчбек
  hatchback3Doors("хэтчбек 3 дв.",
      "assets/configurations/sedan.svg"), // Используем sedan как аналог
  hatchback4Doors("хэтчбек 4 дв.",
      "assets/configurations/sedan.svg"), // Используем sedan как аналог
  hatchback5Doors("хэтчбек 5 дв.",
      "assets/configurations/sedan.svg"), // Используем sedan как аналог

  // Группа: Внедорожник
  allroad3Doors("внедорожник 3 дв.",
      "assets/configurations/jeep.svg"), // Используем jeep как аналог
  allroad5Doors("внедорожник 5 дв.",
      "assets/configurations/jeep.svg"), // Используем jeep как аналог
  allroadOpen("внедорожник открытый",
      "assets/configurations/jeep.svg"), // Используем jeep как аналог

  // Группа: Универсал
  wagon("универсал", "assets/configurations/wagon.svg"),
  wagon5Doors("универсал 5 дв.",
      "assets/configurations/wagon.svg"), // Используем wagon как аналог
  wagon3Doors("универсал 3 дв.",
      "assets/configurations/wagon.svg"), // Используем wagon как аналог

  // Другие типы кузовов
  cabrio("кабриолет", "assets/configurations/cabrio.svg"),
  targa("тарга",
      "assets/configurations/cabrio.svg"), // Используем cabrio как аналог
  minivan("минивэн", "assets/configurations/minivan.svg"),
  liftback("лифтбек",
      "assets/configurations/sedan.svg"), // Используем sedan как аналог
  speedster("спидстер",
      "assets/configurations/cabrio.svg"), // Используем cabrio как аналог
  limousine("лимузин", "assets/configurations/limousine.svg"),
  pickupOne("пикап одинарная кабина", "assets/configurations/pickup.svg"),
  pickupOneHalf("пикап полуторная кабина",
      "assets/configurations/pickup.svg"), // Используем pickup как аналог
  pickupTwo("пикап двойная кабина",
      "assets/configurations/pickup.svg"), // Используем pickup как аналог
  compactvan("компактвэн",
      "assets/configurations/minivan.svg"), // Используем minivan как аналог
  fastback("фастбек", "assets/configurations/fastback.svg"),
  microvan("микровэн",
      "assets/configurations/minivan.svg"), // Используем minivan как аналог
  van("фургон", "assets/configurations/van.svg"),
  phaeton("фаэтон",
      "assets/configurations/cabrio.svg"), // Используем cabrio как аналог
  phaetonWagon("фаэтон-универсал",
      "assets/configurations/wagon.svg"), // Используем wagon как аналог
  pickup("пикап", "assets/configurations/pickup.svg"),
  unknow("", "assets/configurations/coupe.svg");

  final String cyrillicName;
  final String assetPath;

  const CarBodyType(this.cyrillicName, this.assetPath);

  static CarBodyType fromCyrillicName(String cyrillic) {
    return CarBodyType.values.firstWhere(
      (bodyType) => bodyType.cyrillicName == cyrillic,
      orElse: () => unknow,
    );
  }

  String getAssetPath() {
    return assetPath;
  }
}
