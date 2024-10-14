import 'package:freezed_annotation/freezed_annotation.dart';

part 'exterior_elements.freezed.dart';
part 'exterior_elements.g.dart';

@unfreezed
class ExteriorElements with _$ExteriorElements {
  // Определение фабричного конструктора с начальным значением false для всех полей
  factory ExteriorElements({
    @Default(false) bool wheels14,
    @Default(false) bool wheels15,
    @Default(false) bool wheels16,
    @Default(false) bool wheels17,
    @Default(false) bool wheels18,
    @Default(false) bool wheels19,
    @Default(false) bool wheels20,
    @Default(false) bool wheels21,
    @Default(false) bool wheels22,
    @Default(false) bool bodyKit,
    @Default(false) bool bodyMouldings,
    @Default(false) bool duoBodyColor,
    @Default(false) bool paintMetallic,
    @Default(false) bool roofRails,
    @Default(false) bool steelWheels,
  }) = _ExteriorElements;

  // Определение заголовка на русском языке
  static const String rusTitle = "Элементы экстерьера";

  // Локализованные названия полей
  static const Map<String, String> localizedFieldNames = {
    "wheels14": "Диски 14",
    "wheels15": "Диски 15",
    "wheels16": "Диски 16",
    "wheels17": "Диски 17",
    "wheels18": "Диски 18",
    "wheels19": "Диски 19",
    "wheels20": "Диски 20",
    "wheels21": "Диски 21",
    "wheels22": "Диски 22",
    "bodyKit": "Обвес кузова",
    "bodyMouldings": "Декоративные молдинги",
    "duoBodyColor": "Двухцветная окраска кузова",
    "paintMetallic": "Металлик",
    "roofRails": "Рейлинги на крыше",
    "steelWheels": "Стальные диски",
  };

  // Метод для конвертации JSON в экземпляр ExteriorElements
  factory ExteriorElements.fromJson(Map<String, dynamic> json) =>
      _$ExteriorElementsFromJson(json);
}
