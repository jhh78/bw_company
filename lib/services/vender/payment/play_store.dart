import 'dart:async';
import 'dart:developer';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/services/vender/payment/store_manager.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

const String location = "lib/services/vender/play_store.dart";

// 실제 제품 ID로 변경
const Set<String> kIds = {'100en'};

class PlayStoreManager extends StoreManager {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  late List<ProductDetails> _products;

  @override
  Future<void> loadProducts() async {
    try {
      final bool available = await _inAppPurchase.isAvailable();
      if (!available) {
        throw Exception("In-app purchases are not available");
      }

      final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(kIds);
      if (response.notFoundIDs.isNotEmpty) {
        throw Exception("Product not found: ${response.notFoundIDs.join(", ")}");
      }

      _products = response.productDetails;
    } catch (error) {
      writeLogs(location, error.toString());
      showSnackbar();
    }
  }

  @override
  void listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    try {
      for (var purchaseDetails in purchaseDetailsList) {
        if (purchaseDetails.status == PurchaseStatus.error) {
          log("Purchase error: ${purchaseDetails.error}");
          throw Exception("Purchase error: ${purchaseDetails.error}");
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          // 구매 완료 처리
          log("Purchase successful: ${purchaseDetails.productID}");
        }
      }
    } catch (error) {
      writeLogs(location, error.toString());
      showSnackbar();
    }
  }

  @override
  void initialize() async {
    final purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      writeLogs(location, error.toString());
      showSnackbar();
    });
    await loadProducts();
  }

  @override
  void dispose() {
    _subscription.cancel();
  }

  @override
  Future<void> buyProduct(int index) async {
    try {
      final ProductDetails productDetails = _products[index];
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
      _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
    } catch (error) {
      writeLogs(location, error.toString());
      showSnackbar();
    }
  }

  @override
  void showSnackbar() {
    CustomSnackbar(
      title: "errorText".tr,
      message: "unknownExcetipn".tr,
      status: ObserveSnackbarStatus.ERROR,
    ).showSnackbar();
  }
}
