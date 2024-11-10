import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:flutter_application_1/widgets/comment_detail/report_illegal_post.dart';
import 'package:flutter_application_1/widgets/common/orverlap_loading.dart';
import 'package:flutter_application_1/widgets/register/custom_text_input_field.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/widgets/comment_detail/comment_contents_area.dart';
import 'package:flutter_application_1/widgets/comment_detail/comment_thumb_area.dart';

class CommentDetailScreen extends StatefulWidget {
  final CompanyComment comment;

  const CommentDetailScreen({super.key, required this.comment});

  @override
  CommentDetailScreenState createState() => CommentDetailScreenState();
}

class CommentDetailScreenState extends State<CommentDetailScreen> {
  CompanyComment get comment => widget.comment;
  SystemsProvider systemsProvider = Get.put(SystemsProvider());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Hive 에서 추천 비추천 데이터 땡겨오기캐ㅐ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
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
                ReportIllegalPost(comment: comment),
                isScrollControlled: true,
                isDismissible: false,
                enableDrag: false,
              );
            },
          ),
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
}
