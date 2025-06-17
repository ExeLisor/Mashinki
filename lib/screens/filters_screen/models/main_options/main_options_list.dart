List<MainOptionField> mainOptions = [
  MainOptionField(type: "selector", field: "bodyType", title: "Кузов", values: {
    "Седан": ["седан", "седан 2 дв.", "седан-хардтоп"],
    "Универсал": ["универсал 3 дв.", "универсал 5 дв."],
    "Хэтчбек": ["хэтчбек 3 дв.", "хэтчбек 4 дв.", "хэтчбек 5 дв."],
    "Купе": ["купе", "купе-хардтоп"],
    "Кабриолет": ["Кабриолет"],
    "Тарга": ["Тарга"],
    "Спидстер": ["Спидстер"],
    "Внедорожник": [
      "внедорожник 3 дв.",
      "внедорожник 5 дв.",
      "внедорожник открытый"
    ],
    "Пикап": [
      "пикап одинарная кабина",
      "пикап полуторная кабина",
      "пикап двойная кабина"
    ],
    "Минивэн": ["минивэн", "компактвэн", "микровэн"],
    "Фургон": ["фургон", "фаэтон", "фаэтон-универсал"],
    "Родстер": ["Родстер"],
    "Лифтбек": ["Лифтбек"],
    "лимузин": ["Лимузин"],
    "фастбек": ["Фастбек"],
  }),
  MainOptionField(
    type: "selector",
    field: "transmission",
    title: "Коробка",
    values: {
      "Механическая": ["Механическая"],
      "Автомат": ["Автоматическая", "Робот", "Вариатор"],
    },
  ),
  MainOptionField(
    type: "selector",
    field: "engine",
    title: "Двигатель",
    values: {
      "": ["гидроген", "дизель", "гибрид", "электро", "СУГ", "бензин"]
    },
  ),
  MainOptionField(
    type: "chips",
    field: "drives",
    title: "Привод",
    values: ["Передний", "Задний", "Полный"],
  ),
  MainOptionField(
    type: "chips",
    field: "steeringWheel",
    title: "Руль",
    values: ["Левый", "Правый"],
  ),
  MainOptionField(
    type: "chips",
    field: "seatsCount",
    title: "Кол-во мест",
    values: ["1", "2", "3", "4", "5", "6", "7"],
  ),
  MainOptionField(
    type: "range",
    field: "engineVolume",
    title: "Объем двигателя, л",
  ),
  MainOptionField(
    type: "range",
    field: "year",
    title: "Год выпуска",
  ),
  MainOptionField(
    type: "range",
    field: "power",
    title: "Мощность, л.с.",
  ),
];

class MainOptionField {
  final String type;
  final String title;
  final String field;
  final dynamic values;

  MainOptionField({
    required this.type,
    required this.title,
    required this.field,
    this.values,
  });
}
