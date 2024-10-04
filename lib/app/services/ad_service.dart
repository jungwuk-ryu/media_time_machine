import 'dart:developer';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:photo_timemachine/app/secrets/my_ad_unit_ids.dart';

class AdService extends GetxService {
  late AdUnitIds unitIds;
  bool _showRewardAd = false;
  MobileAds? _mobileAds;

  @override
  void onInit() {
    super.onInit();
    unitIds = MyAdUnitIds();
  }

  Future<TrackingStatus?> initMobileAds() async {
    TrackingStatus? status = await trackingTransparencyRequest();
    log(status.toString());
    if (status == TrackingStatus.notDetermined) {
      return status;
    }

    await MobileAds.instance.initialize();
    _mobileAds = MobileAds.instance;
    return status;
  }

  // From https://github.com/deniza/app_tracking_transparency/issues/47#issuecomment-1751719988
  Future<TrackingStatus?> trackingTransparencyRequest() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (Platform.isIOS &&
        int.parse(Platform.operatingSystemVersion.split(' ')[1].split('.')[0]) >=
            14) {

      TrackingStatus status =
      await AppTrackingTransparency.trackingAuthorizationStatus;

      if (status == TrackingStatus.notDetermined) {
        status = await AppTrackingTransparency.requestTrackingAuthorization();
      }

      return status;
    }

    return null;
  }

  Future<void> showLaunchAd() async {
    _mobileAds ?? await initMobileAds();
    if (_mobileAds == null) {
      return;
    }

    InterstitialAd? interstitialAd;
    String adUnitId = unitIds.getLaunchAdId();

    await InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            log('$ad loaded.');

            interstitialAd = ad;
            interstitialAd?.show();
          },

          onAdFailedToLoad: (LoadAdError error) {
            log('InterstitialAd failed to load: $error');
            FirebaseCrashlytics.instance.recordError(error, StackTrace.empty);
          },
        ));
  }

  Future<void> showRewarded(Function() callback) async {
    _showRewardAd = !_showRewardAd;
    if (!_showRewardAd) {
      callback.call();
      return;
    }

    _mobileAds ?? await initMobileAds();
    if (_mobileAds == null) {
      callback.call();
      return;
    }

    await RewardedAd.load(
        adUnitId: unitIds.getRewardedAdId(),
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            log('$ad loaded.');
            ad.show(onUserEarnedReward: (ad, reward) {
              callback.call();
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            log('RewardedAd failed to load: $error');
            callback.call();
          },
        ));
  }
}

abstract class AdUnitIds {
  String getLaunchAdId();
  String getRewardedAdId();
}