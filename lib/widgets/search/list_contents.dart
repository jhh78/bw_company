import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/search_screen_model.dart';
import 'package:flutter_application_1/providers/search_screen.dart';
import 'package:flutter_application_1/screens/corporate_info.dart';
import 'package:flutter_application_1/screens/search.dart';
import 'package:flutter_application_1/services/company.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/widgets/comment_detail/modify_request.dart';
import 'package:flutter_application_1/widgets/comment_detail/report_illegal_post.dart';
import 'package:flutter_application_1/widgets/common/custom_bottom_sheet.dart';
import 'package:flutter_application_1/widgets/common/custom_confirm_dialog.dart';
import 'package:flutter_application_1/widgets/common/list_card_item.dart';
import 'package:get/get.dart';

class ListContents extends StatefulWidget {
  const ListContents({super.key});

  @override
  State<ListContents> createState() => _ListContentsState();
}

class _ListContentsState extends State<ListContents> {
  final SearchScreenProvider _searchScreenProvider = Get.put(SearchScreenProvider());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels != _scrollController.position.maxScrollExtent) return;
      _searchScreenProvider.moreDataLoad();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _renderItems() {
    if (_searchScreenProvider.isInitItemLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_searchScreenProvider.searchList.isEmpty) {
      return Center(
        child: Text("dataNotFound".tr, style: const TextStyle(fontSize: 20)),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _searchScreenProvider.searchList.length,
      itemBuilder: (BuildContext context, int index) {
        final SearchScreenModel item = _searchScreenProvider.searchList[index];

        return ListCardItem(
          id: item.company.id,
          writerId: item.company.extendsData.isEmpty ? '' : item.company.extendsData['refUser'][0].id,
          title: item.company.name,
          thumbUp: item.company.thumbUp,
          thumbDown: item.company.thumbDown,
          handleBlock: (String id) async {
            for (var element in _searchScreenProvider.searchList) {
              if (element.company.id == id) {
                await blockContents(id.toString());

                element.company.isBlocked = true;
                _searchScreenProvider.searchList.refresh();
              }
            }
          },
          handleReport: (String id) {
            CustomBottomSheet(
              widget: ReportIllegalPost(screen: "searchScreen", company: item.company),
            ).show();
          },
          handleDelete: (String id) async {
            CustomConfirmDialog(
              title: 'deleteConfirmTitleMessage'.tr,
              subtitle: 'deleteConfirmSubtitleMessage'.tr,
              onConfirm: () async {
                await deleteCompany(id);
                Get.offAll(() => const SearchScreen());
              },
            ).show();
          },
          nextPageRoute: () {
            Get.to(
              () => CorporateInfoScreen(
                company: item.company,
              ),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 500),
            );
          },
          handleModify: (String id) {
            CustomBottomSheet(
              widget: ModifyRequest(company: item.company),
            ).show();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        child: Obx(() => _renderItems()),
      ),
    );
  }
}
