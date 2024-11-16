import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/collections/users.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/providers/company_info.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:flutter_application_1/screens/corporate_info.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/comment_detail/report_illegal_post.dart';
import 'package:flutter_application_1/widgets/common/extra_menu.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/widgets/comment_detail/comment_contents_area.dart';
import 'package:flutter_application_1/widgets/comment_detail/comment_thumb_area.dart';
import 'package:hive/hive.dart';
import 'package:pocketbase/pocketbase.dart';

class CommentDetailScreen extends StatefulWidget {
  final CompanyComment comment;
  final Company company;

  const CommentDetailScreen({super.key, required this.comment, required this.company});

  @override
  CommentDetailScreenState createState() => CommentDetailScreenState();
}

class CommentDetailScreenState extends State<CommentDetailScreen> {
  CompanyComment get comment => widget.comment;
  Company get company => widget.company;

  SystemsProvider systemsProvider = Get.put(SystemsProvider());
  final CompanyInfoProvider companyInfoProvider = Get.put(CompanyInfoProvider());
  late bool isDisplayDeleteButton;

  @override
  void initState() {
    super.initState();
    Users user = Users.fromString(comment.refUser);
    Box box = Hive.box<Localdata>(SYSTEM_BOX);
    Localdata? localdata = box.get(LOCAL_DATA);
    isDisplayDeleteButton = user.id == localdata?.uuid;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleBlock(String id) async {
    await blockContents(id);
    Get.offAll(() => CorporateInfoScreen(company: widget.company));
  }

  void handleReport(String id) {
    log('handleReport id: $id');
    Get.bottomSheet(
      ReportIllegalPost(
        screen: "commentDetail",
        comment: comment,
        company: company,
      ),
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
    );
  }

  // Hive 에서 추천 비추천 데이터 땡겨오기캐ㅐ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ExstraMenu(
            id: comment.id,
            handleBlock: handleBlock,
            handleReport: handleReport,
          )
        ],
      ),
      body: Hero(
        tag: 'comment_${comment.id}',
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Divider(),
                  CommentThumbArea(comment: comment),
                  CommentContentsArea(title: "descriptionCareer".tr, contents: comment.career),
                  CommentContentsArea(title: "descriptionWorkEnvironment".tr, contents: comment.workingEnvironment),
                  CommentContentsArea(title: "descriptionSalaryWelfare".tr, contents: comment.salaryWelfare),
                  CommentContentsArea(title: "descriptionCompanyCulture".tr, contents: comment.corporateCulture),
                  CommentContentsArea(title: "descriptionManagement".tr, contents: comment.management),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> renderAppbarActions() {
    return [
      renderReportButton(),
      renderDeleteButton(),
    ];
  }

  Widget renderReportButton() {
    if (isDisplayDeleteButton) {
      return const SizedBox.shrink();
    }

    return TextButton.icon(
      label: Text(
        "reportIllegalPost".tr,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      ),
      icon: const Icon(
        Icons.report_gmailerrorred,
        color: Colors.red,
        size: 20,
      ),
      onPressed: () {
        Get.bottomSheet(
          ReportIllegalPost(
            screen: "commentDetail",
            comment: comment,
            company: company,
          ),
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: false,
        );
      },
    );
  }

  Widget renderDeleteButton() {
    if (!isDisplayDeleteButton) {
      return const SizedBox.shrink();
    }

    void moveScreen() {
      Get.offAll(
        () => CorporateInfoScreen(company: company),
        transition: Transition.rightToLeft,
      );
    }

    return TextButton.icon(
      label: Text(
        "deleteButton".tr,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      ),
      icon: const Icon(
        Icons.delete_outline,
        color: Colors.red,
        size: 20,
      ),
      onPressed: () async {
        final pb = PocketBase(API_URL);
        await pb.collection('comment').delete(comment.id);
        companyInfoProvider.comments.removeWhere((element) => element.id == comment.id);
        Get.defaultDialog(
          title: "",
          middleText: "processCompleted".tr,
          barrierDismissible: true,
          onWillPop: () async {
            moveScreen();
            return true; // 다이얼로그를 닫음
          },
          actions: [
            ElevatedButton(
              onPressed: moveScreen,
              child: Text(
                "ok".tr,
              ),
            )
          ],
        );
      },
    );
  }
}
