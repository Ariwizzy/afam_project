import 'dart:math';

import 'package:afam_project/widget/ads_code.dart';
import 'package:applovin_max/applovin_max.dart';

var _rewardedAdRetryAttempt = 0;

class MaxAdSetup{
  void initializeRewardedAds() {

    AppLovinMAX.setRewardedAdListener(RewardedAdListener(onAdLoadedCallback: (ad) {

      // Rewarded ad is ready to be shown. AppLovinMAX.isRewardedAdReady(_rewarded_ad_unit_id) will now return 'true'
      print('Rewarded ad loaded from ' + ad.networkName);

      // Reset retry attempt
      _rewardedAdRetryAttempt = 0;
    }, onAdLoadFailedCallback: (adUnitId, error) {
      // Rewarded ad failed to load
      // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
      _rewardedAdRetryAttempt = _rewardedAdRetryAttempt + 1;

      int retryDelay = pow(2, min(6, _rewardedAdRetryAttempt)).toInt();
      print('Rewarded ad failed to load with code ' + error.code.toString() + ' - retrying in ' + retryDelay.toString() + 's');

      Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
        AppLovinMAX.loadRewardedAd(MaxCode().reward);
      });
    }, onAdDisplayedCallback: (ad) {
      print("onAdReceivedRewardCallback $ad");
    }, onAdDisplayFailedCallback: (ad, error) {
      print("onAdReceivedRewardCallback $ad");
    }, onAdClickedCallback: (ad) {
      print("onAdReceivedRewardCallback $ad");
    }, onAdHiddenCallback: (ad) {
      print("onAdReceivedRewardCallback $ad");
    }, onAdReceivedRewardCallback: (ad, reward) {
      print("onAdReceivedRewardCallback $ad");
    }));
  }
  void showAd(){
    if (AppLovinMAX.isRewardedAdReady(MaxCode().reward) != null) {
      AppLovinMAX.showRewardedAd(MaxCode().reward);
    }
  }
}