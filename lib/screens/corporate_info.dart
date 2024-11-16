import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/providers/company_info.dart';
import 'package:flutter_application_1/screens/comment_register.dart';
import 'package:flutter_application_1/screens/search.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/bottom_loading.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:flutter_application_1/widgets/corporate_info/corporate_comments.dart';
import 'package:flutter_application_1/widgets/corporate_info/corporate_bar_chart.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

const String location = "lib/screens/corporate_info.dart";

class CorporateInfoScreen extends StatelessWidget {
  CorporateInfoScreen({super.key, required this.company});

  final CompanyInfoProvider companyInfoProvider = Get.put(CompanyInfoProvider());
  final Company company;

  void initScreen() {
    companyInfoProvider.getInitItems(company.id);
  }

  void openBrowser(String address) async {
    try {
      final url = Uri.parse(address);
      await launchUrl(url);
    } catch (e) {
      writeLogs(location, e.toString());
      CustomSnackbar(
        title: "errorText".tr,
        message: "wrongLocationInformation".tr,
        status: ObserveSnackbarStatus.ERROR,
      ).showSnackbar();
    }
  }

  Widget renderContents(BuildContext context) {
    if (companyInfoProvider.isInitItemLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (companyInfoProvider.comments.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "dataNotFound".tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(
                () => CommentRegister(company: company),
                transition: Transition.downToUp,
              );
            },
            child: Text("registerButton".tr),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          company.name,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "serif",
              ),
        ),
        CorporateBarChart(),
        // Wrap(
        //   spacing: 8.0,
        //   runSpacing: 4.0,
        //   children: companyInfoProvider.tags
        //       .map(
        //         (tags) => Chip(
        //           label: Text(tags.tagName),
        //         ),
        //       )
        //       .toList(),
        // ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: companyInfoProvider.tags
                .map(
                  (tags) => Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Colors.blueAccent,
                          width: 1,
                        ),
                      ),
                      label: Text(
                        tags.tagName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        CorporateComments(company: company),
        Obx(
          () => Center(
            child: BottomLoading(
              check: companyInfoProvider.isAppendItemLoading.value,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    initScreen();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ),
          onPressed: () {
            Get.offAll(
              () => const SearchScreen(),
              transition: Transition.fade,
            );
          },
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 30),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => openBrowser(company.homepage.toString()),
                  icon: const Icon(
                    Icons.home_outlined,
                    size: 32,
                    color: Colors.blueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () => openBrowser(company.location.toString()),
                  icon: const Icon(
                    Icons.location_on_outlined,
                    size: 32,
                    color: Colors.blueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.to(
                      () => CommentRegister(company: company),
                      transition: Transition.downToUp,
                    );
                  },
                  icon: const Icon(
                    Icons.add_comment_outlined,
                    size: 32,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Obx(() => renderContents(context)),
        ),
      ),
    );
  }
}
