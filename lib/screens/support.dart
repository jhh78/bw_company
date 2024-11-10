import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/services/notice.dart';
import 'package:flutter_application_1/providers/vender/ad.dart';
import 'package:flutter_application_1/providers/vender/purchase.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:flutter_application_1/widgets/common/orverlap_loading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

const String location = "lib/screens/support.dart";

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  bool _isReady = false;
  String _text = "";
  final PurchaseManager _purchaseManager = Get.put(PurchaseManager());
  final ADManager adManager = Get.put(ADManager());

  void _getNoticeData() async {
    try {
      final record = await getNoticeData("support");

      _text = record.data['contents'];
      setState(() {
        _isReady = true;
      });
    } catch (e) {
      writeLogs(location, e.toString());
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
    _getNoticeData();
  }

  @override
  void dispose() {
    _purchaseManager.dispose();
    super.dispose();
  }

  _buyProduct(int productIndex) async {
    try {
      await _purchaseManager.buyProduct(productIndex);
    } catch (e) {
      CustomSnackbar(
        title: "errorText".tr,
        message: "productLoadFailed".tr,
        status: ObserveSnackbarStatus.ERROR,
      ).showSnackbar();
    }
  }

  void loadAd() async {
    try {
      await adManager.loadAd();
    } catch (e) {
      CustomSnackbar(
        title: "errorText".tr,
        message: "adLoadFailed".tr,
        status: ObserveSnackbarStatus.ERROR,
      ).showSnackbar();
    }
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
              children: renderButtonArea(),
            ),
          ),
        ),
      ],
    );
  }

  // TODO ::: 앱스토어 결제문제 해결되면 조건 해제
  List<Widget> renderButtonArea() {
    if (Platform.isIOS) {
      return [
        ElevatedButton(
          onPressed: loadAd,
          child: Text('viewAD'.tr),
        ),
      ];
    }

    return [
      ElevatedButton(
        onPressed: loadAd,
        child: Text('viewAD'.tr),
      ),
      ElevatedButton(
        onPressed: () => _buyProduct(0),
        child: Text('donate'.tr),
      ),
    ];
  }

  Widget _renderLoadingOverlap() {
    if (!adManager.isAdReady.value) return const SizedBox.shrink();
    return const OrverlapLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('supportScreenTitle'.tr),
            centerTitle: true,
          ),
          body: renderContents(),
        ),
        Obx(() => _renderLoadingOverlap()),
      ],
    );
  }
}
