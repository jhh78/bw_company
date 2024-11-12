import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/providers/company_info.dart';
import 'package:flutter_application_1/screens/comment_detail.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/util.dart';
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: renderListTileItems(comment),
    );
  }

  Widget renderListTileItems(CompanyComment comment) {
    if (localdata?.commentBlock.contains(comment.id) ?? false) {
      return Container(
        height: 74,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text("meseageBlocked".tr)),
      );
    }

    return ListTile(
      trailing: const Icon(Icons.arrow_forward, color: Colors.blue),
      subtitle: Row(
        children: [
          const Icon(Icons.thumb_up, color: Colors.blue, size: 20),
          const SizedBox(width: 4),
          Text(getNemberFormatString(comment.thumbUp)),
          const SizedBox(width: 16),
          const Icon(Icons.thumb_down, color: Colors.red, size: 20),
          const SizedBox(width: 4),
          Text(getNemberFormatString(comment.thumbDown)),
        ],
      ),
      onTap: () {
        Get.to(() => CommentDetailScreen(comment: comment, company: widget.company));
      },
      title: Hero(
        tag: 'comment_${comment.id}',
        child: Material(
          child: Text(comment.title),
        ),
      ),
    );
  }
}
