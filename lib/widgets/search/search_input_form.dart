import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/search_screen.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:flutter_application_1/screens/corporate_register.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchInputForm extends StatelessWidget {
  SearchInputForm({
    super.key,
  });
  final SystemsProvider _systemsProvider = Get.put(SystemsProvider());
  final SearchScreenProvider _searchScreenProvider = Get.put(SearchScreenProvider());
  final TextEditingController _searchController = TextEditingController();

  void initScreen() {
    _systemsProvider.formValidate['keyword'] = true;
  }

  Widget renderCompanyAddButton() {
    if (_systemsProvider.formValidate['keyword'] == true) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue, // 텍스트 색상
        ),
        onPressed: () {
          Get.to(
            () => CorporateRegister(),
            arguments: {
              'keyword': _searchController.text,
            },
            transition: Transition.rightToLeft,
          );
        },
        child: Text('registerCompanyButton'.tr),
      ),
    );
  }

  Widget renderTextField(BuildContext context) {
    if (_searchScreenProvider.isInitItemLoading.value) {
      return const SizedBox.shrink();
    }

    return TypeAheadField(
      controller: _searchController,
      loadingBuilder: (context) => const CircularProgressIndicator(),
      animationDuration: const Duration(milliseconds: 100),
      emptyBuilder: (context) => Container(
        height: 0,
      ),
      suggestionsCallback: (search) async {
        return _searchScreenProvider.companyList.where((item) => item.name.contains(search)).toList();
      },
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
        minHeight: 0,
      ),
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'searchCompanyHintText'.tr,
          ),
          onChanged: (value) {
            if (value.isEmpty) {
              _searchScreenProvider.resetSearchItems();
              _systemsProvider.formValidate['keyword'] = true;
            } else {
              _searchScreenProvider.filterSearchItems(value);
              _systemsProvider.formValidate['keyword'] = false;
            }
          },
        );
      },
      itemBuilder: (context, item) {
        return ListTile(
          title: Text(item.name),
        );
      },
      onSelected: (item) {
        _searchController.text = item.name;
        _searchScreenProvider.filterSearchItems(item.name);
        _systemsProvider.formValidate['keyword'] = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initScreen();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() => renderTextField(context)),
        Obx(() => renderCompanyAddButton()),
      ],
    );
  }
}
