import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String location = "lib/services/ad_manager.dart";

class AdManager {
  InterstitialAd? _interstitialAd;

  AdManager() {
    loadAd();
  }

  String getADUnitId() {
    if (Platform.isAndroid) {
      return kReleaseMode ? "ca-app-pub-9674517651101637/4032962043" : "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return kReleaseMode ? "ca-app-pub-9674517651101637/5809078146" : "ca-app-pub-3940256099942544/1712485313";
    }

    throw Exception("Unsupported platform");
  }

  void loadAd() async {
    InterstitialAd.load(
      adUnitId: getADUnitId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _setFullScreenContentCallback(ad);
          log('Ad loaded.');
        },
        onAdFailedToLoad: (error) {
          writeLogs(location, error.toString());
          _interstitialAd = null;
          throw Exception("Failed to load an ad: $error");
        },
      ),
    );
  }

  void _setFullScreenContentCallback(InterstitialAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        log('Ad showed fullscreen content: $ad');
      },
      onAdImpression: (ad) {
        log('Ad impression: $ad');
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        log('Ad failed to show fullscreen content: $err');
        writeLogs(location, err.toString());
        ad.dispose();
        _interstitialAd = null;
        loadAd(); // 광고 객체를 다시 생성합니다.
      },
      onAdDismissedFullScreenContent: (ad) {
        log('Ad dismissed fullscreen content: $ad');
        ad.dispose();
        _interstitialAd = null;
        loadAd(); // 광고 객체를 다시 생성합니다.
      },
      onAdClicked: (ad) {
        log('Ad clicked: $ad');
      },
    );
  }

  Future showAd() async {
    if (_interstitialAd == null) {
      loadAd();
      throw Exception("Ad not loaded");
    }

    _interstitialAd!.show();
  }
}
