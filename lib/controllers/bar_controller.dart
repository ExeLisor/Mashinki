import 'package:autoverse/exports.dart';

class BarController extends GetxController {
  RxInt currentPageIndex = 0.obs;

  void changePage(index) => currentPageIndex.value = index;
}
