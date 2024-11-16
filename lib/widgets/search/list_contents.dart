import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/search_screen_model.dart';
import 'package:flutter_application_1/providers/search_screen.dart';
import 'package:flutter_application_1/screens/corporate_info.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/widgets/comment_detail/report_illegal_post.dart';
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
            Get.bottomSheet(
              ReportIllegalPost(screen: "searchScreen", company: item.company),
              isScrollControlled: true,
              isDismissible: false,
              enableDrag: false,
            );
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
