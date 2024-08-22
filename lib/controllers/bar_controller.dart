import 'package:autoverse/exports.dart';

class BarController extends GetxController {
  static BarController get to => Get.find();

  RxInt currentPageIndex = 0.obs;

  final pages = <String>['/home', '/compare'];

  void changePage(int index) => Get.toNamed(pages[index]);
}

class BarBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => BarController());
}
