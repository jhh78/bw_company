import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/company_info.dart';
import 'package:get/get.dart';

class CorporateBarChart extends StatelessWidget {
  final CompanyInfoProvider companyInfoProvider = Get.put(CompanyInfoProvider());

  CorporateBarChart({
    super.key,
  });

  final double maxValue = 5;

  final List<String> labels = [
    "descriptionCareer".tr,
    "descriptionWorkEnvironment".tr,
    "descriptionSalaryWelfare".tr,
    "descriptionCompanyCulture".tr,
    "descriptionManagement".tr,
  ];

  Color? getColorForValue(double value) {
    if (value / maxValue > 0.8) {
      return Colors.blue[300];
    } else if (value / maxValue > 0.6) {
      return Colors.green[300];
    } else if (value / maxValue > 0.4) {
      return Colors.indigoAccent[100];
    } else if (value / maxValue > 0.2) {
      return Colors.orange[400];
    } else {
      return Colors.red;
    }
  }

  // TOSO ::: 배경색에 따라 텍스트 색상을 변경하도록 수정
  Color getTextColorForValue(double value) {
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Obx(() {
          return renderItems();
        }),
      ),
    );
  }

  Widget renderItems() {
    final List<double> values = [
      companyInfoProvider.companyRating.value.careerRating,
      companyInfoProvider.companyRating.value.workingEnvironmentRating,
      companyInfoProvider.companyRating.value.salaryWelfareRating,
      companyInfoProvider.companyRating.value.corporateCultureRating,
      companyInfoProvider.companyRating.value.managementRating,
    ];
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (context, index) {
        log('${values[index] == 0} ${values[index] / maxValue} ${values[index]} maxValue: $maxValue');
        return Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  LinearProgressIndicator(
                    value: values[index] == 0 ? 1 : values[index] / maxValue,
                    backgroundColor: Colors.grey[300],
                    color: getColorForValue(values[index]),
                    minHeight: 22,
                  ),
                  Center(
                    child: Text(
                      labels[index],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: getTextColorForValue(values[index]),
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              values[index].toStringAsFixed(1),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: getColorForValue(values[index]),
                  ),
            ),
          ],
        );
      },
    );
  }
}
