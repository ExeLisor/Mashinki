import 'package:autoverse/exports.dart';

class LinkController extends GetxController {
  final AppLinks _appLinks = AppLinks();
  Rxn<Uri> initialUri = Rxn<Uri>();
  Rxn<Uri> latestUri = Rxn<Uri>();
  StreamSubscription<Uri?>? _linkSubscription;

  @override
  void onInit() {
    super.onInit();
    initDeepLinks();
  }

  void initDeepLinks() async {
    try {
      Uri? uri = await _appLinks.getInitialLink();
      if (uri != null) {
        initialUri.value = uri;
        log('Initial URI: $uri');
      }
    } catch (e) {
      log('Failed to get initial link: $e');
    }

    _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        latestUri.value = uri;
        log('Received URI: $uri');
      }
    }, onError: (err) {
      log('Error occurred: $err');
    });
  }

  @override
  void onClose() {
    _linkSubscription?.cancel();
    super.onClose();
  }
}
