import 'package:mashinki/exports.dart';

class Configuration {
  final String? id;
  final int? doorsCount;
  final BodyType? bodyType;
  final Notice? notice;
  final List<Modification>? modifications;

  Configuration({
    this.id,
    this.doorsCount,
    this.bodyType,
    this.notice,
    this.modifications,
  });

  factory Configuration.fromJson(Map<String, dynamic> json) => Configuration(
        id: json["id"],
        doorsCount: json["doors-count"],
        bodyType: bodyTypeValues.map[json["body-type"]]!,
        notice: noticeValues.map[json["notice"]]!,
        modifications: json["modifications"] == null
            ? []
            : List<Modification>.from(
                json["modifications"]!.map((x) => Modification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doors-count": doorsCount,
        "body-type": bodyTypeValues.reverse[bodyType],
        "notice": noticeValues.reverse[notice],
        "modifications": modifications == null
            ? []
            : List<dynamic>.from(modifications!.map((x) => x.toJson())),
      };
}

enum BodyType {
  AMBITIOUS,
  BODY_TYPE,
  BODY_TYPE_3,
  BODY_TYPE_5,
  EMPTY,
  FLUFFY,
  HILARIOUS,
  INDECENT,
  INDIGO,
  PURPLE,
  PURPLE_3,
  PURPLE_5,
  STICKY,
  TENTACLED,
  THE_2,
  THE_3,
  THE_5
}

final bodyTypeValues = EnumValues({
  "спидстер": BodyType.AMBITIOUS,
  "родстер": BodyType.BODY_TYPE,
  "универсал 3 дв.": BodyType.BODY_TYPE_3,
  "внедорожник 5 дв.": BodyType.BODY_TYPE_5,
  "купе": BodyType.EMPTY,
  "кабриолет": BodyType.FLUFFY,
  "минивэн": BodyType.HILARIOUS,
  "внедорожник открытый": BodyType.INDECENT,
  "лифтбек": BodyType.INDIGO,
  "седан": BodyType.PURPLE,
  "внедорожник 3 дв.": BodyType.PURPLE_3,
  "универсал 5 дв.": BodyType.PURPLE_5,
  "купе-хардтоп": BodyType.STICKY,
  "тарга": BodyType.TENTACLED,
  "седан 2 дв.": BodyType.THE_2,
  "хэтчбек 3 дв.": BodyType.THE_3,
  "хэтчбек 5 дв.": BodyType.THE_5
});
