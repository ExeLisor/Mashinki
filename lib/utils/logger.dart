import 'package:mashinki/exports.dart';

void log(dynamic info, {Level level = Level.info}) {
  Logger().log(level, info);
}

void logW(dynamic info, {Level level = Level.warning}) {
  Logger().log(level, info);
}
