import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/appinfo.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => PolicyScreenState();
}

class PolicyScreenState extends State<PolicyScreen> {
  late WebViewController _controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            log("Progress: $progress");
          },
          onPageStarted: (String url) {
            // Show loading bar.
            log("Page Started: $url");
          },
          onPageFinished: (String url) {
            // Hide loading bar.
            log("Page Finished: $url");
            setState(() {
              isLoading = false;
            });
          },
          onHttpError: (HttpResponseError error) {
            log("HTTP Error: ${error.toString()}");
          },
          onWebResourceError: (WebResourceError error) {
            log("Web Resource Error: ${error.toString()}");
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('policyUrl'.tr));
  }

  void handlePolicyAgree() async {
    try {
      await createUser();
      Get.offAll(
        () => const AppInfoScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(seconds: 1),
      );
    } catch (e) {
      CustomSnackbar(
        title: "errorText".tr,
        message: "unknownExcetipn".tr,
        status: ObserveSnackbarStatus.ERROR,
      ).showSnackbar();
    }
  }

  Widget renderWebViewContents() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return WebViewWidget(controller: _controller);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                flex: 9,
                child: renderWebViewContents(),
              ),
              renderAgreeArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderAgreeArea() {
    if (isLoading) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: handlePolicyAgree,
            child: Text("policyAgree".tr),
          ),
        ],
      ),
    );
  }
}
