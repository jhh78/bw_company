import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String location = "lib/services/ad_manager.dart";

class ADManager extends GetxService {
  RxBool isAdReady = false.obs;

  String _getADUnitId() {
    if (Platform.isAndroid) {
      return kReleaseMode ? "ca-app-pub-9674517651101637/4032962043" : "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return kReleaseMode ? "ca-app-pub-9674517651101637/5809078146" : "ca-app-pub-3940256099942544/1712485313";
    }

    throw Exception("Unsupported platform");
  }

  Future<void> loadAd() async {
    try {
      isAdReady.value = true;
      await InterstitialAd.load(
        adUnitId: _getADUnitId(),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) async {
            log('Ad loaded. $ad');
            await ad.show();

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {
                log('Ad showed fullscreen content: $ad');
              },
              onAdImpression: (ad) {
                log('Ad impression: $ad');
                ad.dispose();
                isAdReady.value = false;
              },
              onAdFailedToShowFullScreenContent: (ad, err) async {
                log('Ad failed to show fullscreen content: $err');
                writeLogs(location, err.toString());
                ad.dispose();
                loadAd(); // 광고 객체를 다시 생성합니다.
              },
              onAdDismissedFullScreenContent: (ad) async {
                log('Ad dismissed fullscreen content: $ad');
                ad.dispose();
                loadAd(); // 광고 객체를 다시 생성합니다.
              },
              onAdClicked: (ad) {
                log('Ad clicked: $ad');
              },
            );
          },
          onAdFailedToLoad: (error) {
            writeLogs(location, error.toString());
            throw Exception("Failed to load an ad: $error");
          },
        ),
      );
    } catch (e) {
      writeLogs(location, e.toString());
      log(e.toString());
    }
  }
}
