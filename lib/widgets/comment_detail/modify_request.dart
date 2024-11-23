import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/providers/company_info.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:get/get.dart';

const String location = "lib/widgets/comment_detail/report_illegal_post.dart";

class ModifyRequest extends StatefulWidget {
  const ModifyRequest({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  State<ModifyRequest> createState() => _ModifyRequestState();
}

class _ModifyRequestState extends State<ModifyRequest> {
  final TextEditingController _reportContentsController = TextEditingController();

  final SystemsProvider _systemsProvider = Get.put(SystemsProvider());
  final CompanyInfoProvider _companyInfoProvider = Get.put(CompanyInfoProvider());

  void handleAddReport() async {
    try {
      if (_reportContentsController.text.isEmpty) {
        _systemsProvider.formValidate['contents'] = true;
        return;
      }

      _systemsProvider.isProcessing.value = true;

      await _companyInfoProvider.requestCompanyInfoModify(
        widget.company.id,
        _reportContentsController.text,
      );
      _systemsProvider.isProcessing.value = false;

      Get.back();
      await Future.delayed(const Duration(milliseconds: 500));

      Get.defaultDialog(
        title: 'info'.tr,
        middleText: 'modifyRequestSuccess'.tr,
        barrierDismissible: false,
        onConfirm: () {
          Get.back();
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
                "modifyRequest".tr,
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
