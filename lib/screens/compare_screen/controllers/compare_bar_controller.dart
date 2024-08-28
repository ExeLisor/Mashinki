import 'package:autoverse/exports.dart';

class CompareAppbarController extends FloatingBarController {
  static CompareAppbarController get to => Get.find();

  final RxDouble _currentOffset = 0.0.obs;
  @override
  RxDouble get currentOffset => _currentOffset;

  void setOffsetToStart() =>
      WidgetsBinding.instance.addPostFrameCallback((_) => _currentOffset(0));

  void startListen(ScrollController controller) {
    setOffsetToStart();
    controller.addListener(() => _currentOffset.value = controller.offset);
  }
}

class CompareAppBarBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CompareAppbarController());
}
