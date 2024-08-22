import 'package:autoverse/exports.dart';

class CompareAppbarController extends FloatingBarController {
  static CompareAppbarController get to => Get.find();

  final RxDouble _currentOffset = 0.0.obs;
  @override
  RxDouble get currentOffset => _currentOffset;

  void startListen(ScrollController controller) {
    log(controller.positions.length);
    if (controller.hasClients) return;

    controller.addListener(() => _currentOffset.value = controller.offset);
  }
}

class CompareAppBarBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CompareAppbarController());
}
