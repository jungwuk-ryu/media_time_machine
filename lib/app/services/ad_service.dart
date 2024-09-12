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

  @override
  void onInit() {
    super.onInit();
    unitIds = MyAdUnitIds();
  }

  // From https://github.com/deniza/app_tracking_transparency/issues/47#issuecomment-1751719988
  Future<String?> trackingTransparencyRequest() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (Platform.isIOS &&
        int.parse(Platform.operatingSystemVersion.split(' ')[1].split('.')[0]) >=
            14) {
      final TrackingStatus status =
      await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.authorized) {
        final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
        return uuid;
      } else if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
        final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
        return uuid;
      }
    }

    return null;
  }

  Future<void> showLaunchAd() async {
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