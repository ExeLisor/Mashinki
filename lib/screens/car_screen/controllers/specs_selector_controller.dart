import 'package:autoverse/exports.dart';

class SpecsSelectorController extends GetxController {
  static SpecsSelectorController get to => Get.find();

  final RxBool _showOptions = false.obs;

  bool get showOptions => _showOptions.value;

  void changeCategory({bool? force}) =>
      _showOptions.value = force ?? !showOptions;

  Future<void> changeToOptions() async => _showOptions.value = true;

  void changeToSpecs() => _showOptions.value = false;
}

class SpecsSelectorBinding implements Bindings {
  @override
  void dependencies() => Get.lazyPut(() => SpecsSelectorController());
}
