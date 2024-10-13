import 'package:flutter/material.dart';
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
      appBar: AppBar(),
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
