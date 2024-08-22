import 'package:autoverse/exports.dart';

const int uiHeight = 892;
const int uiWidth = 412;

class ScreenSize {
  static ScreenSize? _instance;
  double width = 412;
  double height = 892;

  bool isInitializated = false;

  final List<Function> _observers = [];

  factory ScreenSize() => _instance ??= ScreenSize._privateConstructor();

  ScreenSize._privateConstructor();

  void init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    isInitializated = true;
    _notifyObservers();
  }

  void addObserver(Function observer) {
    _observers.add(observer);
  }

  void removeObserver(Function observer) {
    _observers.remove(observer);
  }

  void _notifyObservers() {
    for (var observer in _observers) {
      observer();
    }
  }
}

extension DobuleAdaptiveDesign on double {
  double get h {
    return this * ScreenSize().height / uiHeight;
  }

  double get w {
    return this * ScreenSize().width / uiWidth;
  }

  double get fs {
    if (ScreenSize().width < ScreenSize().height) {
      return this * ScreenSize().height / uiHeight;
    }
    return this * ScreenSize().width / uiWidth;
  }
}

extension IntAdaptiveDesign on int {
  double get h {
    return this * ScreenSize().height / uiHeight;
  }

  double get w {
    return this * ScreenSize().width / uiWidth;
  }

  double get fs {
    if (ScreenSize().width < ScreenSize().height) {
      return this * ScreenSize().height / uiHeight;
    }
    return this * ScreenSize().width / uiWidth;
  }
}
