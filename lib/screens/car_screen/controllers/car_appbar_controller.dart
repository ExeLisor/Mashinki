import 'package:autoverse/exports.dart';

class CarAppbarController extends GetxController {
  static CarAppbarController get to => Get.find();

  final RxDouble _currentOffset = 0.0.obs;
  double get currentOffset => _currentOffset.value;

  void startListen(ScrollController controller) {
    if (controller.hasClients) return;
    controller.addListener(() => _currentOffset.value = controller.offset);
  }
}

class CarAppBarBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CarAppbarController());
}
