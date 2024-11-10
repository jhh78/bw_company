import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/screens/appinfo.dart';
import 'package:flutter_application_1/screens/policy.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pocketbase/pocketbase.dart';

const String location = "lib/screens/intro.dart";

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  void movePolicyScreen() {
    Get.offAll(
      () => const PolicyScreen(),
      transition: Transition.fadeIn,
      duration: const Duration(seconds: 1),
    );
  }

  void moveAppInfoScreen() {
    Get.offAll(
      () => const AppInfoScreen(),
      transition: Transition.fadeIn,
      duration: const Duration(seconds: 1),
    );
  }

  void checkServerStatus() async {
    try {
      Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
      final Localdata? userData = box.get(LOCAL_DATA);

      final pb = PocketBase(API_URL);
      await pb.collection("connection").getFullList();

      if (userData == null) {
        movePolicyScreen();
        return;
      }

      try {
        // 해당 유저 정보가 있는지 확인
        await pb.collection('users').getOne(userData.uuid);
      } catch (e) {
        log('error: $e');
        // 존재하지 않으면 policy로 이동
        movePolicyScreen();
        return;
      }

      moveAppInfoScreen();
    } catch (e) {
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
              padding: const EdgeInsets.only(bottom: 50),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation.value,
                    child: Text(
                      'pleaseTouchScreenAndStart'.tr,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                },
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
