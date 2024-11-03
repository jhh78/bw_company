import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyViewScreen extends StatefulWidget {
  const PolicyViewScreen({super.key});

  @override
  State<PolicyViewScreen> createState() => PolicyViewScreenState();
}

class PolicyViewScreenState extends State<PolicyViewScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('policy'.tr),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: renderWebViewContents(),
          ),
        ],
      ),
    );
  }
}
