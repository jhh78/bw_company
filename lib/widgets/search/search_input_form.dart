import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/search_screen.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:get/get.dart';

class SearchInputForm extends StatelessWidget {
  SearchInputForm({
    super.key,
  });
  final SystemsProvider _systemsProvider = Get.put(SystemsProvider());
  final SearchScreenProvider _searchScreenProvider = Get.put(SearchScreenProvider());

  Widget _renderSearchButton() {
    log('renderSearchButton ${_searchScreenProvider.searchController.value.text} ${_searchScreenProvider.isSearchMode.value}');
    return IconButton(
      onPressed: () {
        _searchScreenProvider.searchKeywordItem(_searchScreenProvider.searchController.value.text);
      },
      icon: const Icon(
        Icons.search,
        size: 40,
        color: Colors.blue,
      ),
    );
  }

  void handleTextFieldOnchange(value) async {
    log('handleTextFieldOnchange $value');
    _systemsProvider.formValidate['keyword'] = true;

    if (value.isEmpty) {
      _searchScreenProvider.resetSearchItems();
      _searchScreenProvider.isSearchMode.value = false;
      return;
    }

    _searchScreenProvider.isSearchMode.value = true;

    final findItem = _searchScreenProvider.findCompanyList(value);
    if (findItem.isEmpty) {
      _systemsProvider.formValidate['keyword'] = false;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchScreenProvider.searchController.value,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'searchCompanyHintText'.tr,
                ),
                onChanged: handleTextFieldOnchange,
              ),
            ),
            _renderSearchButton(),
          ],
        ),
      ],
    );
  }
}
