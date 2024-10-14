import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/search_screen.dart';
import 'package:flutter_application_1/widgets/common/bottom_loading.dart';
import 'package:flutter_application_1/widgets/common/side_menu.dart';
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
        drawer: const SideMenu(),
        body: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: renderSearchScreen(),
        ),
      ),
    );
  }
}
