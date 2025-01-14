import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/models/collections/users.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/providers/company_info.dart';
import 'package:flutter_application_1/screens/comment_detail.dart';
import 'package:flutter_application_1/screens/comment_register.dart';
import 'package:flutter_application_1/services/company.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/comment_detail/report_illegal_post.dart';
import 'package:flutter_application_1/widgets/common/custom_bottom_sheet.dart';
import 'package:flutter_application_1/widgets/common/custom_confirm_dialog.dart';
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

    if (companyInfoProvider.comments.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "dataNotFound".tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(
                () => CommentRegister(company: widget.company),
                transition: Transition.downToUp,
              );
            },
            child: Text("registerButton".tr),
          ),
        ],
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
    final refUser = Users.fromString(comment.refUser);

    return ListCardItem(
      id: comment.id,
      writerId: refUser.id,
      title: comment.title,
      thumbUp: comment.thumbUp,
      thumbDown: comment.thumbDown,
      handleBlock: (String id) async {
        for (var element in companyInfoProvider.comments) {
          if (element.id == id) {
            await blockContents(id.toString());

            element.isBlocked = true;
            companyInfoProvider.comments.refresh();
          }
        }
      },
      handleReport: (String id) {
        CustomBottomSheet(
          widget: ReportIllegalPost(
            screen: "corporateInfoScreen",
            comment: comment,
          ),
        ).show();
      },
      handleDelete: (String id) async {
        CustomConfirmDialog(
          title: 'deleteConfirmTitleMessage'.tr,
          subtitle: 'deleteConfirmSubtitleMessage'.tr,
          onConfirm: () async {
            await deleteComment(id);
            companyInfoProvider.getInitItems(widget.company.id);
            Get.back();
          },
        ).show();
      },
      nextPageRoute: () {
        Get.to(() => CommentDetailScreen(comment: comment, company: widget.company));
      },
    );
  }
}
