import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/help.dart';
import 'package:flutter_application_1/screens/notice.dart';
import 'package:flutter_application_1/screens/search.dart';
import 'package:flutter_application_1/screens/support.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'naviMenu'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: Text('naviSearch'.tr),
            onTap: () {
              Get.offAll(
                () => const SearchScreen(),
                transition: Transition.fade,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text('naviNotification'.tr),
            onTap: () {
              Get.to(
                () => const NoticeScreen(),
                transition: Transition.fade,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text('naviHelp'.tr),
            onTap: () {
              Get.to(
                () => const HelpScreen(),
                transition: Transition.fade,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: Text('naviSupport'.tr),
            onTap: () {
              Get.to(
                () => const SupportScreen(),
                transition: Transition.fade,
              );
            },
          ),
        ],
      ),
    );
  }
}
