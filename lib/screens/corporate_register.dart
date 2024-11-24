import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:flutter_application_1/screens/search.dart';
import 'package:flutter_application_1/services/company.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:flutter_application_1/widgets/register/search_tag_input_field.dart';
import 'package:get/get.dart';

const String location = "lib/screens/corporate_register.dart";

class CorporateRegister extends StatefulWidget {
  const CorporateRegister({super.key});

  @override
  State<CorporateRegister> createState() => _CorporateRegisterState();
}

class _CorporateRegisterState extends State<CorporateRegister> {
  final SystemsProvider systemsProvider = Get.put(SystemsProvider());

  final TextEditingController _companyNameController = TextEditingController(text: Get.arguments['keyword']);
  final TextEditingController _companyHomepageController = TextEditingController();
  final TextEditingController _companyLocationController = TextEditingController();

  final Company company = Company();

  @override
  void initState() {
    super.initState();
    systemsProvider.formValidate.clear();
  }

  Widget renderTextField(
    BuildContext context,
    String label,
    String? errorText,
    TextEditingController controller, {
    String? helperText,
    bool readOnly = false,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          errorText: errorText,
          helperText: helperText,
        ),
      ),
    );
  }

  void _registerCompany() async {
    try {
      systemsProvider.formValidate.clear();

      if (_companyNameController.text.isEmpty) {
        systemsProvider.formValidate['companyName'] = true;
      }

      // 해당회사가 존재하는지 확인
      if (await checkDuplicateCompany(_companyNameController.text)) {
        systemsProvider.formValidate['duplicate'] = true;
      }

      if (_companyHomepageController.text.isEmpty || !isValidUrl(_companyHomepageController.text)) {
        systemsProvider.formValidate['companyHomepage'] = true;
      }

      if (_companyLocationController.text.isEmpty || !isValidGoogleMapUrl(_companyLocationController.text)) {
        systemsProvider.formValidate['companyLocation'] = true;
      }

      if (systemsProvider.formValidate.isNotEmpty) {
        CustomSnackbar(
          title: 'errorText'.tr,
          message: "checkInputData".tr,
          status: ObserveSnackbarStatus.ERROR,
          duration: 2,
        ).showSnackbar();
        return;
      }

      company.name = _companyNameController.text;
      company.homepage = _companyHomepageController.text;
      company.location = _companyLocationController.text;
      await registerCompany(company);
      Get.offAll(() => const SearchScreen());
    } catch (e) {
      writeLogs(location, e.toString());
      log("error : ${e.toString()}");
      CustomSnackbar(
        title: "errorText".tr,
        message: "unknownExcetipn".tr,
        status: ObserveSnackbarStatus.ERROR,
      ).showSnackbar();
    }
  }

  void _changeTagList(List<String> tagList) {
    company.tags = tagList.join(SEARCH_TAG_SEPARATOR);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("registerCompanyScreenTitle".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Obx(() => renderTextField(
                    context,
                    "registerCompanyScreenNeedCompanyName".tr,
                    () {
                      if (systemsProvider.formValidate["companyName"] == true) {
                        return "requiredField".tr;
                      } else if (systemsProvider.formValidate["duplicate"] == true) {
                        return "duplicateCompany".tr;
                      }
                      return null;
                    }(),
                    _companyNameController,
                    helperText: "registerCompanyScreenNeedCompanyName".tr,
                  )),
              Obx(() => renderTextField(
                    context,
                    "registerCompanyScreenNeedCompanyHomePage".tr,
                    systemsProvider.formValidate["companyHomepage"] == true ? "requiredField".tr : null,
                    _companyHomepageController,
                    helperText: "registerCompanyScreenNeedCompanyHomePageHelpText".tr,
                  )),
              Obx(
                () => renderTextField(
                  context,
                  "registerCompanyScreenNeedCompanyLocation".tr,
                  systemsProvider.formValidate["companyLocation"] == true ? "requiredField".tr : null,
                  _companyLocationController,
                  helperText: "registerCompanyScreenNeedCompanyLocationHelpText".tr,
                ),
              ),
              SearchTagInputField(tags: "", onTagChange: _changeTagList),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerCompany,
                child: Text("registerButton".tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
