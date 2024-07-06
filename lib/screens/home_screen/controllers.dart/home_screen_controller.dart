import 'package:mashinki/exports.dart';

enum HomeState { done, loading, error }

class HomeScreenController extends GetxController {
  HomeState state = HomeState.done;

  void startLoading() {
    state = HomeState.loading;
    update();
  }
}
