import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/notice.dart';
import 'package:flutter_application_1/services/ad_manager.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  bool _isReady = false;
  String _text = "";
  final AdManager adManager = AdManager();
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  void _initializeInAppPurchase() {
    final purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // Handle error here.
      CustomSnackbar(
        title: "errorText".tr,
        message: error.toString(),
        status: ObserveSnackbarStatus.ERROR,
      ).showSnackbar();
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Handle pending state
      } else if (purchaseDetails.status == PurchaseStatus.purchased) {
        // Handle purchased state
        if (purchaseDetails.pendingCompletePurchase) {
          InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Handle error state
        CustomSnackbar(
          title: "errorText".tr,
          message: purchaseDetails.error!.message,
          status: ObserveSnackbarStatus.ERROR,
        ).showSnackbar();
      }
    }
  }

  void _buyProduct() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      throw Exception("In-app purchases are not available");
    }

    const Set<String> kIds = {'100en'}; // 실제 제품 ID로 변경하세요.
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(kIds);
    if (response.notFoundIDs.isNotEmpty) {
      throw Exception("Product not found: ${response.notFoundIDs.join(", ")}");
    }

    final ProductDetails productDetails = response.productDetails.first;
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }

  void _getNoticeData() async {
    try {
      final record = await getNoticeData("support");

      _text = record.data['contents'];
      setState(() {
        _isReady = true;
      });
    } catch (e) {
      log(e.toString());
      CustomSnackbar(
        title: "errorText".tr,
        message: "unknownExcetipn".tr,
        status: ObserveSnackbarStatus.ERROR,
      ).showSnackbar();
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeInAppPurchase();
    _getNoticeData();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  Widget renderContents() {
    if (!_isReady) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Expanded(
          flex: 9,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey[400]!,
                ),
              ),
            ),
            child: SingleChildScrollView(
              child: Html(data: _text),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: adManager.showAd,
                  child: Text('viewAD'.tr),
                ),
                ElevatedButton(
                  onPressed: _buyProduct,
                  child: Text('donate'.tr),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('supportScreenTitle'.tr),
        centerTitle: true,
      ),
      body: renderContents(),
    );
  }
}
