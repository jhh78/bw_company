import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/company_info.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:flutter_application_1/widgets/corporate_info/comment_detail_screen.dart';
import 'package:get/get.dart';

class CorporateComments extends StatelessWidget {
  CorporateComments({
    super.key,
  });

  final CompanyInfoProvider companyInfoProvider = Get.put(CompanyInfoProvider());
  final ScrollController _scrollController = ScrollController();

  void initScreen() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels != _scrollController.position.maxScrollExtent) return;

      companyInfoProvider.moreCommentDataLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    initScreen();
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
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
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
              Get.to(() => CommentDetailScreen(comment: comment));
            },
            title: Hero(
              tag: 'comment_${comment.id}',
              child: Material(
                child: Text(comment.title),
              ),
            ),
          ),
        );
      },
    );
  }
}
