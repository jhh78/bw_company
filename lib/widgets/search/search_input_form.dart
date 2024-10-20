import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/search_screen.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchInputForm extends StatelessWidget {
  SearchInputForm({
    super.key,
  });
  final SystemsProvider _systemsProvider = Get.put(SystemsProvider());
  final SearchScreenProvider _searchScreenProvider = Get.put(SearchScreenProvider());

  Widget renderTextField(BuildContext context) {
    if (_searchScreenProvider.isInitItemLoading.value) {
      return const SizedBox.shrink();
    }

    return TypeAheadField(
      controller: _searchScreenProvider.searchController.value,
      loadingBuilder: (context) => const CircularProgressIndicator(),
      animationDuration: const Duration(milliseconds: 100),
      emptyBuilder: (context) => Container(
        height: 0,
      ),
      suggestionsCallback: (search) async {
        final findItem = _searchScreenProvider.findCompanyList(search);
        _searchScreenProvider.isDisplayCompanyAddButton.value = findItem.isEmpty;
        return findItem;
      },
      onSelected: (item) async {
        final findSearchItem = _searchScreenProvider.findLoadedItemList(item.name);
        if (findSearchItem.isNotEmpty) {
          _searchScreenProvider.filterSearchItems(item.name);
          return;
        }

        _searchScreenProvider.searchKeywordItem(item.name);
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
          onChanged: handleTextFieldOnchange,
        );
      },
      itemBuilder: (context, item) {
        return ListTile(
          title: Text(item.name),
        );
      },
    );
  }

  void handleTextFieldOnchange(value) async {
    _systemsProvider.formValidate['keyword'] = true;

    if (value.isEmpty) {
      _searchScreenProvider.resetSearchItems();
      return;
    }

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
        Obx(() => renderTextField(context)),
      ],
    );
  }
}
