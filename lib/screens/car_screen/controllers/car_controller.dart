import 'package:autoverse/exports.dart';

class CarController extends GetxController {}

class CarBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => ModelsController());
}
