import 'package:autoverse/exports.dart';

export 'logger.dart';
export 'theme_data.dart';
export 'adaptive.dart';
export 'shared_preferences.dart';
export 'car_bodies.dart';

final RegExp nicknameRegExp = RegExp(
  r'^[a-zA-Z0-9_]+$',
);

String? validateNickname(String nickname) {
  if (nickname.isEmpty) {
    return 'Имя пользователя не может быть пустым';
  } else if (nickname.length < 6) {
    return 'Имя пользователя должно содержать не менее 6 символов';
  } else if (nickname.length > 20) {
    return 'Имя пользователя не должно превышать 20 символов';
  } else if (!nicknameRegExp.hasMatch(nickname)) {
    return 'В именах пользлвателей можно использовать только буквы латинского алфавита (a-z, A-Z), цифры, символы, подчеркивания и точки';
  }
  return null;
}

final RegExp emailRegExp = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
);
String? validateEmail(String email) {
  if (email.isEmpty) {
    return 'Email не может быть пустым';
  } else if (!emailRegExp.hasMatch(email)) {
    return 'Введите корректный email';
  }
  return null;
}

final RegExp passwordRegExp = RegExp(
  r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
);

String? validatePassword(String password) {
  if (password.isEmpty) {
    return 'Пароль не может быть пустым';
  } else if (!passwordRegExp.hasMatch(password)) {
    return 'Пароль должен содержать не менее 8 символов, включать одну цифру, одну заглавную букву и один специальный символ';
  }
  return null;
}

String getValue(String value) {
  if (value.isEmpty) return "-";
  if (RegExp(r'\d').hasMatch(value)) {
    try {
      String newValue = "${double.parse(value)}";
      return newValue;
    } catch (e) {
      return value;
    }
  }
  return value;
}

String declineComparison(int count) {
  if (count % 10 == 1 && count % 100 != 11) {
    return '$count сравнение';
  } else if ([2, 3, 4].contains(count % 10) &&
      !(count % 100 >= 11 && count % 100 <= 14)) {
    return '$count сравнения';
  } else {
    return '$count сравнений';
  }
}

String declineCharacteristic(int count) {
  if (count % 10 == 1 && count % 100 != 11) {
    return '$count характеристика';
  } else if ([2, 3, 4].contains(count % 10) &&
      !(count % 100 >= 11 && count % 100 <= 14)) {
    return '$count характеристики';
  } else {
    return '$count характеристик';
  }
}

String declineOption(int count) {
  if (count % 10 == 1 && count % 100 != 11) {
    return '$count опция';
  } else if ([2, 3, 4].contains(count % 10) &&
      !(count % 100 >= 11 && count % 100 <= 14)) {
    return '$count опции';
  } else {
    return '$count опций';
  }
}

dynamic getMaxValue(List specifications) {
  // Фильтрация числовых значений и получение списка значений
  List values = specifications
      .where((spec) => spec['compareType'] == CompareType.higher)
      .map((spec) => spec['value'])
      .toList();

  // Если список значений пуст, вернуть 0 или любое другое значение по умолчанию
  if (values.isEmpty) return -1;

  if (values.length == 1) return -1;

  var value = values.reduce((a, b) => a > b ? a : b);

  if (value == 0) return -1;

  // Использовать метод max для нахождения максимального значения
  return value;
}

double getMinValue(List<Map<String, dynamic>> specifications) {
  // Фильтрация числовых значений и получение списка значений
  List<double> values = specifications
      .where((spec) => spec['compareType'] == CompareType.lower)
      .map((spec) => spec['value'] as double)
      .toList();

  // Если список значений пуст, вернуть 0 или любое другое значение по умолчанию
  if (values.isEmpty) {
    return 0;
  }

  // Использовать метод min для нахождения минимального значения
  return values.reduce((a, b) => a < b ? a : b);
}

extension StringExtensions on String {
  String capitalizeFirstLetter() {
    if (isEmpty) return this;

    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

Future<void> openResource(ResourceType type) async {
  final String brandName = CarController.to.car.mark.name ?? "";
  final String modelName = CarController.to.car.model.name ?? "";
  final String generationName = CarController.to.car.generation.name ?? "";

  final String searchText = "$brandName $modelName $generationName";

  String url = "";

  switch (type) {
    case ResourceType.google:
      url = "$googleSearchUrl=$searchText";
      break;
    case ResourceType.pinterest:
      url = "$pinSearchUrl=$searchText";
      break;
    case ResourceType.youtube:
      url = "$youTubeSearchUrl=$searchText";
      break;
    case ResourceType.tiktok:
      url = "$tikTokSearchUrl=$searchText";
      break;
    default:
  }

  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

extension NullOrEmptyExtension on String? {
  bool get nullOrEmpty => this == null || this!.isEmpty;
}

Future<T> tryCatch<T>(Future<T> Function() func) async {
  try {
    return await func();
  } on DioError catch (error) {
    logW(error.response?.data['error'] ?? error.message);
    rethrow;
  } catch (error) {
    logW(error);
    rethrow;
  }
}

extension NullCheckExtension<T> on T? {
  bool get isNull {
    return this == null;
  }

  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }
    if (this is String) {
      return (this as String).isEmpty;
    }
    if (this is List) {
      return (this as List).isEmpty;
    }
    return false;
  }
}

extension ListExtensions on List {
  bool isSubsetOf(List otherList) => every(otherList.contains);
}
