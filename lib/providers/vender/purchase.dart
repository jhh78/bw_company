import 'dart:async';
import 'dart:developer';
import 'package:flutter_application_1/services/exception.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

const String location = "lib/services/vender/payment.dart";

// 실제 제품 ID로 변경
const Set<String> kIds = {'100en'};

class PurchaseManager extends GetxService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  late List<ProductDetails> _products;
  RxBool isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

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
      rethrow;
    }
  }

  void listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    try {
      for (var purchaseDetails in purchaseDetailsList) {
        if (purchaseDetails.status == PurchaseStatus.error) {
          log("Purchase error: ${purchaseDetails.error}");
          throw Exception("Purchase error: ${purchaseDetails.error}");
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          // 구매 완료 처리
          log("Purchase successful: ${purchaseDetails.productID}");
          _inAppPurchase.completePurchase(purchaseDetails);
          isProcessing.value = false;
        }
      }
    } catch (error) {
      writeLogs(location, error.toString());
      rethrow;
    }
  }

  Future<void> initialize() async {
    try {
      final purchaseUpdated = _inAppPurchase.purchaseStream;
      _subscription = purchaseUpdated.listen((purchaseDetailsList) {
        listenToPurchaseUpdated(purchaseDetailsList);
      }, onDone: () {
        _subscription.cancel();
      }, onError: (error) {
        throw Exception("Purchase error: $error");
      });

      await loadProducts();
    } catch (error) {
      writeLogs(location, error.toString());
    }
  }

  void dispose() {
    try {
      _subscription.cancel();
    } catch (error) {
      writeLogs(location, error.toString());
    }
  }

  Future<void> buyProduct(int index) async {
    try {
      isProcessing.value = true;
      ProductDetails productDetails = _products[index];
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
      await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
    } catch (error) {
      writeLogs(location, error.toString());
      rethrow;
    }
  }

  // TODO ::: 구글, 애플 영수증 검증 로직작성 필요
  // Future<void> verifyPurchase(PurchaseDetails purchaseDetails) async {
  // final String receipt = purchaseDetails.verificationData.serverVerificationData;
  // final String sharedSecret = '1958edc819604a10ae411e3b20128625'; // 앱의 공유 비밀

  // // 프로덕션 환경에서 영수증 검증
  // final response = await http.post(
  //   Uri.parse('https://buy.itunes.apple.com/verifyReceipt'),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, String>{
  //     'receipt-data': receipt,
  //     'password': sharedSecret,
  //   }),
  // );

  // if (response.statusCode == 200) {
  //   final Map<String, dynamic> responseBody = jsonDecode(response.body);
  //   if (responseBody['status'] == 21007) {
  //     // 프로덕션 환경에서 검증 실패 시 테스트 환경에서 다시 검증
  //     final sandboxResponse = await http.post(
  //       Uri.parse('https://sandbox.itunes.apple.com/verifyReceipt'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'receipt-data': receipt,
  //         'password': sharedSecret,
  //       }),
  //     );

  //     if (sandboxResponse.statusCode == 200) {
  //       final Map<String, dynamic> sandboxResponseBody = jsonDecode(sandboxResponse.body);
  //       if (sandboxResponseBody['status'] == 0) {
  //         // 영수증 검증 성공
  //         log("Receipt verification successful (Sandbox)");
  //       } else {
  //         // 영수증 검증 실패
  //         log("Receipt verification failed (Sandbox): ${sandboxResponseBody['status']}");
  //       }
  //     } else {
  //       log("Error verifying receipt (Sandbox): ${sandboxResponse.statusCode}");
  //     }
  //   } else if (responseBody['status'] == 0) {
  //     // 영수증 검증 성공
  //     log("Receipt verification successful (Production)");
  //   } else {
  //     // 영수증 검증 실패
  //     log("Receipt verification failed (Production): ${responseBody['status']}");
  //   }
  // } else {
  //   log("Error verifying receipt (Production): ${response.statusCode}");
  // }
  // }
}
