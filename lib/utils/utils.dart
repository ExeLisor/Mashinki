import 'package:mashinki/exports.dart';

export './cache.dart';
export './logger.dart';
export './theme_data.dart';
export './adaptive.dart';

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

String? validateEmail(String email) {
  if (email.isEmpty) {
    return 'Email не может быть пустым';
  } else if (emailRegExp.hasMatch(email)) {
    return 'Введите корректный email';
  }
  return null;
}
