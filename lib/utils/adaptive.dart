import 'package:autoverse/exports.dart';

const int uiHeight = 892;
const int uiWidth = 412;

class ScreenSize {
  static double width = 0;
  static double height = 0;

  static void init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
}

extension DobuleAdaptiveDesign on double {
  double get h {
    return this * ScreenSize.height / uiHeight;
  }

  double get w {
    return this * ScreenSize.width / uiWidth;
  }

  double get fs {
    if (ScreenSize.width < ScreenSize.height) {
      return this * ScreenSize.height / uiHeight;
    }
    return this * ScreenSize.width / uiWidth;
  }
}

extension IntAdaptiveDesign on int {
  double get h {
    return this * ScreenSize.height / uiHeight;
  }

  double get w {
    return this * ScreenSize.width / uiWidth;
  }

  double get fs {
    if (ScreenSize.width < ScreenSize.height) {
      return this * ScreenSize.height / uiHeight;
    }
    return this * ScreenSize.width / uiWidth;
  }
}
