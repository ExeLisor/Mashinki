import 'package:autoverse/screens/filters_screen/models/main_options/main_options_list.dart';

//TO-DO генерировать список при запуске приложения
Map<String, List<MainOptionField>> options = {
  "Салон": [
    MainOptionField(
        type: "checkbox",
        field: "alcantara",
        title: "Алькантара (Материал салона)"),
    MainOptionField(
        type: "checkbox",
        field: "black-roof",
        title: "Отделка потолка чёрного цвета"),
    MainOptionField(
        type: "checkbox",
        field: "combo-interior",
        title: "Комбинированный (Материал салона)"),
    MainOptionField(
        type: "checkbox",
        field: "decorative-interior-lighting",
        title: "Декоративная подсветка салона"),
    MainOptionField(
        type: "checkbox",
        field: "door-sill-panel",
        title: "Накладки на пороги"),
    MainOptionField(
        type: "checkbox",
        field: "driver-seat-electric",
        title: "Электрорегулировка сиденья водителя"),
    MainOptionField(
        type: "checkbox",
        field: "driver-seat-memory",
        title: "Память сиденья водителя"),
    MainOptionField(
        type: "checkbox",
        field: "front-seat-heating",
        title: "Подогрев передних сидений"),
    MainOptionField(
        type: "checkbox", field: "leather", title: "Кожаный (Материал салона)"),
  ],
  "Комфорт": [
    MainOptionField(
        type: "checkbox", field: "360-camera", title: "Камера 360°"),
    MainOptionField(
        type: "checkbox",
        field: "adj-pedals",
        title: "Регулируемый педальный узел"),
    MainOptionField(
        type: "checkbox",
        field: "ashtray-and-cigarette-lighter",
        title: "Прикуриватель и пепельница"),
    MainOptionField(
        type: "checkbox",
        field: "auto-cruise",
        title: "Адаптивный круиз-контроль"),
    MainOptionField(
        type: "checkbox",
        field: "auto-parking",
        title: "Система автоматической парковки"),
    MainOptionField(
        type: "checkbox", field: "backlight", title: "Подсветка зоны ног"),
    MainOptionField(
        type: "checkbox", field: "climate-control", title: "Климат-контроль"),
  ],
  "Обзор": [
    MainOptionField(
        type: "checkbox",
        field: "adjust-mirrors",
        title: "Электрорегулировка зеркал"),
    MainOptionField(
        type: "checkbox",
        field: "automatic-headlight",
        title: "Автоматическое включение фар"),
    MainOptionField(
        type: "checkbox",
        field: "glass-heating",
        title: "Подогрев лобового стекла"),
    MainOptionField(
        type: "checkbox", field: "headlight-washers", title: "Омыватели фар"),
    MainOptionField(
        type: "checkbox", field: "rain-sensor", title: "Датчик дождя"),
  ],
  "Безопасность": [
    MainOptionField(
        type: "checkbox",
        field: "abs",
        title: "Антиблокировочная система (ABS)"),
    MainOptionField(type: "checkbox", field: "alarm", title: "Сигнализация"),
    MainOptionField(
        type: "checkbox",
        field: "blind-spot-monitor",
        title: "Система мониторинга слепых зон"),
    MainOptionField(
        type: "checkbox",
        field: "distronic",
        title: "Система Distronic (адаптивный круиз-контроль)"),
    MainOptionField(
        type: "checkbox", field: "esp", title: "Система стабилизации (ESP)"),
    MainOptionField(
        type: "checkbox",
        field: "isofix",
        title: "Крепления для детских сидений ISOFIX"),
    MainOptionField(
        type: "checkbox",
        field: "lane-keeping-assist",
        title: "Система удержания в полосе"),
  ],
  "Мультимедиа": [
    MainOptionField(
        type: "checkbox",
        field: "android-auto",
        title: "Поддержка Android Auto"),
    MainOptionField(
        type: "checkbox",
        field: "apple-carplay",
        title: "Поддержка Apple CarPlay"),
    MainOptionField(type: "checkbox", field: "bluetooth", title: "Bluetooth"),
    MainOptionField(type: "checkbox", field: "usb", title: "USB-порты"),
    MainOptionField(
        type: "checkbox", field: "navigation", title: "Навигационная система"),
  ],
  "Элементы экстерьера": [
    MainOptionField(
        type: "checkbox", field: "alloy-wheels", title: "Легкосплавные диски"),
    MainOptionField(
        type: "checkbox",
        field: "electric-tailgate",
        title: "Электропривод багажника"),
    MainOptionField(
        type: "checkbox", field: "fog-lights", title: "Противотуманные фары"),
    MainOptionField(
        type: "checkbox", field: "panoramic-roof", title: "Панорамная крыша"),
    MainOptionField(type: "checkbox", field: "tow-bar", title: "Фаркоп"),
  ]
};
