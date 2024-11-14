import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/providers/company_info.dart';
import 'package:flutter_application_1/screens/comment_detail.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/comment_detail/report_illegal_post.dart';
import 'package:flutter_application_1/widgets/common/list_card_item.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CorporateComments extends StatefulWidget {
  const CorporateComments({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  State<CorporateComments> createState() => _CorporateCommentsState();
}

class _CorporateCommentsState extends State<CorporateComments> {
  final CompanyInfoProvider companyInfoProvider = Get.put(CompanyInfoProvider());

  final ScrollController _scrollController = ScrollController();
  late Localdata? localdata;

  @override
  void initState() {
    super.initState();
    final Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
    localdata = box.get(LOCAL_DATA);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels != _scrollController.position.maxScrollExtent) return;

      companyInfoProvider.moreCommentDataLoad();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        child: Obx(() => renderListItems()),
      ),
    );
  }

  Widget renderListItems() {
    if (companyInfoProvider.isInitItemLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      controller: _scrollController,
      itemCount: companyInfoProvider.comments.length,
      itemBuilder: (BuildContext context, int index) {
        final comment = companyInfoProvider.comments[index];
        return renderListTIleItems(comment);
      },
    );
  }

  Widget renderListTIleItems(CompanyComment comment) {
    return ListCardItem(
      id: comment.id,
      title: comment.title,
      thumbUp: comment.thumbUp,
      thumbDown: comment.thumbDown,
      handleBlock: (String id) {
        log('blockItem: $id');

        for (var element in companyInfoProvider.comments) {
          if (element.id == id) {
            Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
            Localdata? userData = box.get(LOCAL_DATA);
            if (userData != null) {
              userData.commentBlock.add(id);
              box.put(LOCAL_DATA, userData);
            }

            element.isBlocked = true;
            companyInfoProvider.comments.refresh();
          }
        }
      },
      handleReport: (String id) {
        Get.bottomSheet(
          ReportIllegalPost(
            screen: "corporateInfoScreen",
            comment: comment,
          ),
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: false,
        );
      },
      nextPageRoute: () {
        Get.to(() => CommentDetailScreen(comment: comment, company: widget.company));
      },
    );
  }

  // Widget renderListTileItems(CompanyComment comment) {
  // return ListTile(
  //   trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
  //   subtitle: Row(
  //     children: [
  //       const Icon(Icons.thumb_up, color: Colors.blue, size: 20),
  //       const SizedBox(width: 4),
  //       Text(getNemberFormatString(comment.thumbUp)),
  //       const SizedBox(width: 16),
  //       const Icon(Icons.thumb_down, color: Colors.red, size: 20),
  //       const SizedBox(width: 4),
  //       Text(getNemberFormatString(comment.thumbDown)),
  //     ],
  //   ),
  //   onTap: () {
  //     Get.to(() => CommentDetailScreen(comment: comment, company: widget.company));
  //   },
  //   title: Hero(
  //     tag: 'comment_${comment.id}',
  //     child: Material(
  //       child: Text(comment.title),
  //     ),
  //   ),
  // );
  // }
}
