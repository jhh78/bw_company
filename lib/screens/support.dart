import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/services/notice.dart';
import 'package:flutter_application_1/services/ad_manager.dart';
import 'package:flutter_application_1/services/purchase_manager.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
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
  final AdManager adManager = AdManager();
  final PurchaseManager _purchaseManager = PurchaseManager();

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
    _purchaseManager.initialize();
    _getNoticeData();
  }

  @override
  void dispose() {
    _purchaseManager.dispose();
    super.dispose();
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
                  onPressed: _purchaseManager.buyProduct,
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
