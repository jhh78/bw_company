import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/search_screen.dart';
import 'package:flutter_application_1/screens/help.dart';
import 'package:flutter_application_1/screens/notice.dart';
import 'package:flutter_application_1/screens/support.dart';
import 'package:flutter_application_1/widgets/common/bottom_loading.dart';
import 'package:flutter_application_1/widgets/search/list_contents.dart';
import 'package:flutter_application_1/widgets/search/search_input_form.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final SearchScreenProvider _searchScreenProvider = Get.put(SearchScreenProvider());
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _searchScreenProvider.readyForSearchScreen().then((_) {
      setState(() {
        _isInit = true;
      });
    });
  }

  Widget renderSearchScreen() {
    if (!_isInit) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: <Widget>[
        SearchInputForm(),
        ListContents(),
        Obx(
          () => BottomLoading(
            check: _searchScreenProvider.isAppendItemLoading.value,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("searchListTitle".tr),
          centerTitle: true,
        ),
        drawer: Drawer(
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
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: renderSearchScreen(),
        ),
      ),
    );
  }
}
