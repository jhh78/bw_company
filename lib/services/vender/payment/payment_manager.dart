import 'dart:io';

import 'package:flutter_application_1/services/vender/payment/app_store.dart';
import 'package:flutter_application_1/services/vender/payment/play_store.dart';

const String location = "lib/services/vender/payment_manager.dart";

class PaymentManager {
  late PlayStoreManager _playStoreManager;
  late AppStoreManager _appStoreManager;

  PaymentManager() {
    initialize();
  }

  void initialize() {
    if (Platform.isIOS) {
      _appStoreManager = AppStoreManager();
      _appStoreManager.initialize();
    } else if (Platform.isAndroid) {
      _playStoreManager = PlayStoreManager();
      _playStoreManager.initialize();
    }
  }

  void purchase(int index) {
    if (Platform.isIOS) {
      _appStoreManager.buyProduct(index);
    } else if (Platform.isAndroid) {
      _playStoreManager.buyProduct(index);
    }
  }

  void dispose() {
    if (Platform.isIOS) {
      _appStoreManager.dispose();
    } else if (Platform.isAndroid) {
      _playStoreManager.dispose();
    }
  }
}
