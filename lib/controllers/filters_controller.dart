import 'package:autoverse/exports.dart';

class FiltersController extends GetxController {
  static FiltersController get to => Get.find();
}

class FiltersBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => FiltersController());
}
