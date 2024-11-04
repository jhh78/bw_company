import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/screens/intro.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/services/notice.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

const String location = "lib/screens/help.dart";

class MemberExitScreen extends StatefulWidget {
  const MemberExitScreen({super.key});

  @override
  State<MemberExitScreen> createState() => _MemberExitScreenState();
}

class _MemberExitScreenState extends State<MemberExitScreen> {
  bool _isReady = false;
  String _text = "";

  void _getNoticeData() async {
    try {
      final record = await getNoticeData("exitMember");

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

    return Column(
      children: [
        Flexible(
          flex: 9,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Html(data: _text),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () async {
                      Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
                      await box.clear();

                      Get.offAll(() => const IntroScreen());
                    },
                    child: Text('exitMember'.tr)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('exitMember'.tr),
        centerTitle: true,
      ),
      body: renderContents(),
    );
  }
}
