import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/search_screen.dart';
import 'package:flutter_application_1/screens/corporate_register.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/bottom_loading.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:flutter_application_1/widgets/common/side_menu.dart';
import 'package:flutter_application_1/widgets/search/list_contents.dart';
import 'package:flutter_application_1/widgets/search/search_input_form.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
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
        const ListContents(),
        Obx(
          () => BottomLoading(
            check: _searchScreenProvider.isAppendItemLoading.value,
          ),
        ),
      ],
    );
  }

  void handleMoveRegisterScreen() {
    final hasItem = _searchScreenProvider.checkCompanyName(_searchScreenProvider.searchController.value.text);
    if (hasItem) {
      CustomSnackbar(
        title: 'info'.tr,
        message: "registeredItems".tr,
        status: ObserveSnackbarStatus.INFO,
      ).showSnackbar();

      return;
    }

    Get.to(
      () => CorporateRegister(),
      arguments: {
        'keyword': _searchScreenProvider.searchController.value.text,
      },
      transition: Transition.rightToLeft,
    );
  }

  Widget renderCompanyAddButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        icon: const Icon(
          Icons.add_home_work_outlined,
          color: Colors.blue,
          size: 35,
        ),
        onPressed: handleMoveRegisterScreen,
      ),
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
          actions: [
            renderCompanyAddButton(),
          ],
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
