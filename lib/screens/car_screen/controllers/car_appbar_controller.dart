import 'package:autoverse/exports.dart';

class CarAppbarController extends FloatingBarController {
  static CarAppbarController get to => Get.find();

  final RxDouble _currentOffset = 0.0.obs;
  @override
  RxDouble get currentOffset => _currentOffset;

  void setOffsetToStart() =>
      WidgetsBinding.instance.addPostFrameCallback((_) => _currentOffset(0));

  void startListen(ScrollController controller) {
    try {
      setOffsetToStart();
      controller.addListener(() => _currentOffset.value = controller.offset);
    } catch (e) {
      logW(e);
    }
  }
}

class CarAppBarBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CarAppbarController());
}
