import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/screens/appinfo.dart';
import 'package:flutter_application_1/screens/policy.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pocketbase/pocketbase.dart';

const String location = "lib/screens/intro.dart";

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  void checkServerStatus() async {
    try {
      Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
      final Localdata? userData = box.get(LOCAL_DATA);

      final pb = PocketBase(API_URL);
      await pb.collection("connection").getFullList();

      if (userData == null) {
        Get.offAll(
          () => const PolicyScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(seconds: 1),
        );
      } else {
        Get.offAll(
          () => const AppInfoScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      writeLogs(location, e.toString());
      log('error: $e');
      CustomSnackbar(
        title: "maintenance".tr,
        message: "maintenanceText".tr,
        status: ObserveSnackbarStatus.ERROR,
      ).showSnackbar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: InkWell(
                onTap: checkServerStatus,
                child: SvgPicture.asset(
                  'assets/images/main.svg',
                  fit: BoxFit.fitWidth,
                  clipBehavior: Clip.antiAlias,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 20),
              child: FutureBuilder(
                future: getAppVersion(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Version ${snapshot.data}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
