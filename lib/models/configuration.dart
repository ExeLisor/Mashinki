import 'package:autoverse/exports.dart';

class Configuration {
  final String? id;
  final int? doorsCount;
  final String? bodyType;
  final String? configurationName;

  List<Modification>? modifications;
  bool isLoaded = false;

  Configuration({
    this.id,
    this.doorsCount,
    this.bodyType,
    this.configurationName,
    this.modifications,
    this.isLoaded = false,
  });

  factory Configuration.fromJson(Map<String, dynamic> json) => Configuration(
      id: json["id"],
      doorsCount: json["doors-count"],
      bodyType: json["body-type"],
      configurationName: json["configuration-name"],
      modifications: json["modifications"] == null
          ? []
          : List<Modification>.from(
              json["modifications"].map((x) => Modification.fromJson(x))),
      isLoaded: true);

  Map<String, dynamic> toJson() => {
        "id": id,
        "doors-count": doorsCount,
        "body-type": bodyType,
        "configuration-name": configurationName,
        "modifications": modifications == null
            ? []
            : List<dynamic>.from(modifications!.map((x) => x.toJson())),
      };
}


// final bodyTypeValues = EnumValues({
//   "спидстер": BodyType.AMBITIOUS,
//   "родстер": BodyType.BODY_TYPE,
//   "универсал 3 дв.": BodyType.BODY_TYPE_3,
//   "внедорожник 5 дв.": BodyType.BODY_TYPE_5,
//   "купе": BodyType.EMPTY,
//   "кабриолет": BodyType.FLUFFY,
//   "минивэн": BodyType.HILARIOUS,
//   "внедорожник открытый": BodyType.INDECENT,
//   "лифтбек": BodyType.INDIGO,
//   "седан": BodyType.PURPLE,
//   "внедорожник 3 дв.": BodyType.PURPLE_3,
//   "универсал 5 дв.": BodyType.PURPLE_5,
//   "купе-хардтоп": BodyType.STICKY,
//   "тарга": BodyType.TENTACLED,
//   "седан 2 дв.": BodyType.THE_2,
//   "хэтчбек 3 дв.": BodyType.THE_3,
//   "хэтчбек 5 дв.": BodyType.THE_5
// });
