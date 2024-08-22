import 'package:autoverse/exports.dart';

class CompareAppbarController extends FloatingBarController {
  static CompareAppbarController get to => Get.find();

  final RxDouble _currentOffset = 0.0.obs;
  @override
  RxDouble get currentOffset => _currentOffset;

  late ScrollController controller;

  void startListen(ScrollController controller) {
    if (controller.hasClients) return;
    this.controller = controller;

    controller.addListener(() => _currentOffset.value = this.controller.offset);
  }
}

class CompareAppBarBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CompareAppbarController());
}
