import 'package:autoverse/exports.dart';

class BarController extends GetxController {
  static BarController get to => Get.find();

  RxInt currentPageIndex = 0.obs;

  final pages = <String>['/home', '/compare'];

  void changePage(int index) {
    currentPageIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/home') {
      return GetPageRoute(
        settings: settings,
        page: () => const HomeScreen(),
      );
    }

    if (settings.name == '/compare') {
      return GetPageRoute(
          page: () => const CompareScreen(),
          transition: Transition.cupertino,
          bindings: [CompareBinding()]);
    }

    return null;
  }
}

class BarBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => BarController());
}
