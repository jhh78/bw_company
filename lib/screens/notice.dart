import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/services/notice.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

const String location = "lib/screens/notice.dart";

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  bool _isReady = false;
  String _text = "";

  void _getNoticeData() async {
    try {
      final record = await getNoticeData("notice");

      _text = record.data['contents'];
      setState(() {
        _isReady = true;
      });
    } catch (e) {
      writeLogs(location, e.toString());
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
    _getNoticeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget renderContents() {
    if (!_isReady) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Html(data: _text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('noticeScreenTitle'.tr),
        centerTitle: true,
      ),
      body: renderContents(),
    );
  }
}
