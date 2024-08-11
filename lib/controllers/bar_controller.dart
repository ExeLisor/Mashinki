import 'package:autoverse/exports.dart';

class BarController extends GetxController {
  static BarController get to => Get.find();

  RxInt currentPageIndex = 0.obs;

  void changePage(index) => currentPageIndex.value = index;
}

class BarBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => BarController());
}
