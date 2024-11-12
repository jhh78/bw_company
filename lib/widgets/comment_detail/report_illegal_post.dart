import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:flutter_application_1/screens/corporate_info.dart';
import 'package:flutter_application_1/services/company_comment.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

const String location = "lib/widgets/comment_detail/report_illegal_post.dart";

class ReportIllegalPost extends StatefulWidget {
  const ReportIllegalPost({
    super.key,
    required this.comment,
    required this.company,
  });

  final CompanyComment comment;
  final Company company;

  @override
  State<ReportIllegalPost> createState() => _ReportIllegalPostState();
}

class _ReportIllegalPostState extends State<ReportIllegalPost> {
  final TextEditingController _reportContentsController = TextEditingController();

  final SystemsProvider _systemsProvider = Get.put(SystemsProvider());

  void handleAddReport() async {
    try {
      if (_reportContentsController.text.isEmpty) {
        _systemsProvider.formValidate['contents'] = true;
        return;
      }

      Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
      Localdata? userData = box.get(LOCAL_DATA);

      if (userData == null) {
        throw Exception('User data is null');
      }

      userData.commentBlock.add(widget.comment.id);
      box.put(LOCAL_DATA, userData);

      _systemsProvider.isProcessing.value = true;
      await reportIllegalPost(widget.comment.id, _reportContentsController.text);
      _systemsProvider.initializeData();
      Get.back();
      await Future.delayed(const Duration(milliseconds: 500));

      Get.defaultDialog(
        title: 'info'.tr,
        middleText: 'reportIllegalPostSuccess'.tr,
        barrierDismissible: false,
        onConfirm: () {
          Get.offAll(() => CorporateInfoScreen(company: widget.company));
        },
      );
    } catch (e) {
      writeLogs(location, e.toString());
      CustomSnackbar(
        title: 'errorText'.tr,
        message: 'unknownExcetipn'.tr,
        status: ObserveSnackbarStatus.ERROR,
      ).showSnackbar();
    }
  }

  Widget rendereButtonArea() {
    if (_systemsProvider.isProcessing.value) {
      return const Expanded(
          child: Padding(
        padding: EdgeInsets.all(14.0),
        child: LinearProgressIndicator(
          minHeight: 20,
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ));
    }
    return Row(
      children: [
        IconButton(
          onPressed: () {
            _systemsProvider.initializeData();
            Get.back();
          },
          icon: const Icon(
            Icons.cancel_outlined,
            size: 32,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: handleAddReport,
          icon: const Icon(
            Icons.upload_rounded,
            size: 32,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 50, top: 20, left: 20, right: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "reportIllegalPost".tr,
                style: const TextStyle(fontSize: 24),
              ),
              Obx(() => rendereButtonArea()),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() => TextField(
                minLines: 7,
                maxLines: 10,
                controller: _reportContentsController,
                decoration: InputDecoration(
                  hintText: "needReportIllegalPost".tr,
                  errorText: _systemsProvider.formValidate['contents'] == true ? "needRequiredField".tr : null,
                  border: const OutlineInputBorder(),
                ),
              )),
        ],
      ),
    );
  }
}
