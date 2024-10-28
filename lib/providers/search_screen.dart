import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/search_screen_model.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class SearchScreenProvider extends GetxController {
  RxList<SearchScreenModel> searchList = <SearchScreenModel>[].obs;
  List<SearchScreenModel> oriSearchList = <SearchScreenModel>[];
  RxList<Company> companyList = <Company>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;

  RxInt page = 1.obs;
  RxInt perPage = 15.obs;
  RxBool isAppendItemLoading = false.obs;
  RxBool isInitItemLoading = false.obs;
  RxBool isCompanySearchLoading = false.obs;
  RxBool isDisplayCompanyAddButton = false.obs;
  RxBool isSearchMode = false.obs;

  Future<void> getAutoCompleatFieldCompanyList() async {
    final pb = PocketBase(API_URL);
    final record = await pb.collection("companyNameAutoCompleat").getFullList();

    for (var item in record) {
      companyList.add(Company.fromRecordModel(item));
    }
  }

  Future<void> getFirstItems() async {
    searchList.clear();
    await getItems();
  }

  Future<void> initItems() async {
    isInitItemLoading.value = true;

    await delayScreen();

    searchList.clear();
    companyList.clear();

    final futures = <Future>[
      getAutoCompleatFieldCompanyList(),
      getFirstItems(),
    ];

    await Future.wait(futures);
    isInitItemLoading.value = false;
  }

  void moreDataLoad() async {
    if (isAppendItemLoading.value || searchList.length / perPage.value < page.value) return;

    isAppendItemLoading.value = true;
    page.value += 1;

    await delayScreen();
    await getItems();

    isAppendItemLoading.value = false;
  }

  Future<void> getItems() async {
    final pb = PocketBase(API_URL);
    final resultList = await pb.collection('searchScreenCompanyList').getList(
          page: page.value,
          perPage: perPage.value,
        );

    // 반복문을 사용하여 resultList의 items를 searchList에 추가
    for (final item in resultList.items) {
      searchList.add(SearchScreenModel.fromJson(item));
    }

    oriSearchList = List.from(searchList);
  }

  void resetSearchItems() async {
    await initItems();
  }

  void setSearchListValue(List<SearchScreenModel> list) {
    searchList.value = list;
  }

  void searchKeywordItem(String keyword) async {
    isInitItemLoading.value = true;
    await delayScreen();

    final pb = PocketBase(API_URL);
    final records = await pb.collection('company').getFullList(
          filter: "name~'$keyword' || tags~'$keyword'",
        );
    searchList.value = records.map((e) => SearchScreenModel.fromJson(e)).toList();
    isInitItemLoading.value = false;
  }

  List<Company> findCompanyList(String search) => companyList.where((item) => item.name.contains(search)).toList();

  List<SearchScreenModel> findLoadedItemList(String search) => oriSearchList.where((item) => item.company.name.contains(search)).toList();

  bool checkCompanyName(String search) => companyList.any((item) => item.name == search);
}
