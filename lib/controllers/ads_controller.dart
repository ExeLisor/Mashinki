import 'package:autoverse/exports.dart';

class AdsController extends GetxController {
  BannerAd? anchoredAdaptiveAd;
  RxBool isBannerAdLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAd();
  }

  Future<void> loadAd() async {
    // Получаем размер адаптивного баннера.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            Get.size.width.truncate());

    if (size == null) {
      log('Unable to get height of anchored banner.');
      return;
    }

    anchoredAdaptiveAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-9690417339805409/6489502325'
          : 'ca-app-pub-9690417339805409/3233427488',
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          log('$ad loaded: ${ad.responseInfo}');
          isBannerAdLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
          isBannerAdLoaded.value = false;
        },
      ),
    );

    anchoredAdaptiveAd!.load();
  }

  @override
  void onClose() {
    anchoredAdaptiveAd?.dispose();
    super.onClose();
  }
}
