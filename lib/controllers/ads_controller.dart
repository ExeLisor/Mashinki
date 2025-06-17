import 'package:autoverse/exports.dart';


class AdsController extends GetxController {
  BannerAd? anchoredAdaptiveAd;
  InterstitialAd? interstitialAd;
  RewardedInterstitialAd? rewardedInterstitialAd;

  RxBool isBannerAdLoaded = false.obs;
  RxBool isAdEnabled = true.obs; 

  DateTime? lastComplexActionAdShown;
  Duration complexActionAdInterval = const Duration(seconds: 30); 

  @override
  void onInit() {
    super.onInit();
    loadBannerAd();
    loadInterstitialAd();
    loadRewardedInterstitialAd();
  }

  
  Future<void> loadBannerAd() async {
    if (!isAdEnabled.value) return;

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            Get.size.width.truncate());

    if (size == null) {
      log('Unable to get height of anchored banner.');
      return;
    }

    anchoredAdaptiveAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111' 
          : 'ca-app-pub-3940256099942544/2934735716',
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


  Future<void> loadInterstitialAd() async {
    if (!isAdEnabled.value) return;
    await InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          log('Interstitial ad loaded');
          interstitialAd = ad;
          interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  /// Загрузка Rewarded Interstitial рекламы
  Future<void> loadRewardedInterstitialAd() async {
    if (!isAdEnabled.value) return;

    await RewardedInterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/5354046379'
          : 'ca-app-pub-3940256099942544/6978759866',
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          log('Rewarded Interstitial ad loaded');
          rewardedInterstitialAd = ad;
          setupRewardedInterstitialCallbacks();
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('RewardedInterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void setupRewardedInterstitialCallbacks() {
    rewardedInterstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (Ad ad) {
        ad.dispose();
        rewardedInterstitialAd = null;
        loadRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (Ad ad, AdError error) {
        log('Failed to show rewarded interstitial ad: $error');
        ad.dispose();
        rewardedInterstitialAd = null;
        loadRewardedInterstitialAd();
      },
    );
  }

  /// Показать Interstitial для простых действий
  void showInterstitialAd() {
    if (!isAdEnabled.value) return;

    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (Ad ad) {
          ad.dispose();
          loadInterstitialAd(); // Перезагрузка для последующего показа
        },
        onAdFailedToShowFullScreenContent: (Ad ad, AdError error) {
          log('Failed to show interstitial ad: $error');
          ad.dispose();
          loadInterstitialAd();
        },
      );
      interstitialAd!.show();
      interstitialAd = null;
    } else {
      log('InterstitialAd is not ready yet.');
      loadInterstitialAd();
    }
  }

  /// Показать Rewarded Interstitial после сложного действия по таймеру
  void handleComplexAction() {
    if (!isAdEnabled.value) return;

    // Проверяем, не показывали ли недавно
    if (lastComplexActionAdShown != null) {
      final timeSinceLastAd = DateTime.now().difference(lastComplexActionAdShown!);
      if (timeSinceLastAd < complexActionAdInterval) {
        // Ещё рано показывать
        return;
      }
    }

    if (rewardedInterstitialAd == null) {
      log('RewardedInterstitialAd is not ready yet, try loading again.');
      loadRewardedInterstitialAd();
      return;
    }

    Timer(const Duration(seconds: 5), () {
      showRewardedInterstitialAd();
      lastComplexActionAdShown = DateTime.now();
    });
  }

  /// Показать Rewarded Interstitial Ads
  void showRewardedInterstitialAd() {
    if (!isAdEnabled.value || rewardedInterstitialAd == null) return;

    rewardedInterstitialAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        log('User earned reward: ${reward.type}, amount: ${reward.amount}');
      },
    );
    rewardedInterstitialAd = null;
  }

  /// Отключить рекламу
  void disableAds() {
    isAdEnabled.value = false;
    anchoredAdaptiveAd?.dispose();
    anchoredAdaptiveAd = null;
    interstitialAd?.dispose();
    interstitialAd = null;
    rewardedInterstitialAd?.dispose();
    rewardedInterstitialAd = null;
  }

  /// Включить рекламу
  void enableAds() {
    isAdEnabled.value = true;
    loadBannerAd();
    loadInterstitialAd();
    loadRewardedInterstitialAd();
  }

  @override
  void onClose() {
    anchoredAdaptiveAd?.dispose();
    interstitialAd?.dispose();
    rewardedInterstitialAd?.dispose();
    super.onClose();
  }
}
