import 'package:autoverse/exports.dart';

enum HomeState { done, loading, error }

class HomeScreenController extends GetxController {
  static HomeScreenController get to => Get.find();

  Rx<HomeState> state = HomeState.loading.obs;

  @override
  Future<void> onInit() async {
    isDataLoaded();
    super.onInit();
  }

  void isDataLoaded() {
    bool marksLoaded = MarksController.to.isMarksLoaded();
    if (!marksLoaded) return;
    loadingDone();
  }

  void startLoading() => state.value = HomeState.loading;

  void loadingDone() => state.value = HomeState.done;

  void loadingError() => state.value = HomeState.error;
}
