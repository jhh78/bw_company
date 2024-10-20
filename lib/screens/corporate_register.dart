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
import 'package:get/get.dart';

const String location = "lib/screens/corporate_register.dart";

class CorporateRegister extends StatelessWidget {
  CorporateRegister({super.key});

  final SystemsProvider systemsProvider = Get.put(SystemsProvider());

  final TextEditingController _companyNameController = TextEditingController(text: Get.arguments['keyword']);
  final TextEditingController _companyHomepageController = TextEditingController();
  final TextEditingController _companyLocationController = TextEditingController();

  final Company company = Company();

  Widget renderTextField(BuildContext context, String label, String validateKey,
      {String? helperText, bool readOnly = false, TextEditingController? controller}) {
    return Obx(() => Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                readOnly: readOnly,
                controller: controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: label,
                  errorText: systemsProvider.formValidate[validateKey] == true ? "requiredField".tr : null,
                  helperText: helperText,
                ),
              ),
            ],
          ),
        ));
  }

  void _registerCompany() async {
    try {
      systemsProvider.formValidate.clear();

      if (_companyHomepageController.text.isEmpty || !isValidUrl(_companyHomepageController.text)) {
        systemsProvider.formValidate['companyHomepage'] = true;
      }

      if (_companyLocationController.text.isEmpty || !isValidGoogleMapUrl(_companyLocationController.text)) {
        systemsProvider.formValidate['companyLocation'] = true;
      }

      if (systemsProvider.formValidate.isNotEmpty) {
        CustomSnackbar(
          title: 'errorText'.tr,
          message: "needRequiredField".tr,
          status: ObserveSnackbarStatus.ERROR,
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
              renderTextField(
                context,
                "registerCompanyScreenNeedCompanyName".tr,
                'companyName',
                controller: _companyNameController,
                readOnly: true,
              ),
              renderTextField(
                context,
                "registerCompanyScreenNeedCompanyHomePage".tr,
                'companyHomepage',
                helperText: "registerCompanyScreenNeedCompanyHomePageHelpText".tr,
                controller: _companyHomepageController,
              ),
              renderTextField(
                context,
                "registerCompanyScreenNeedCompanyLocation".tr,
                'companyLocation',
                helperText: "registerCompanyScreenNeedCompanyLocationHelpText".tr,
                controller: _companyLocationController,
              ),
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
