import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/providers/company_info.dart';
import 'package:flutter_application_1/services/company_comment.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CommentThumbArea extends StatefulWidget {
  final CompanyComment comment;
  const CommentThumbArea({super.key, required this.comment});

  @override
  CommentThumbAreaState createState() => CommentThumbAreaState();
}

class CommentThumbAreaState extends State<CommentThumbArea> {
  CompanyComment get comment => widget.comment;
  final CompanyInfoProvider companyInfoProvider = Get.put(CompanyInfoProvider());
  late int thumbUp;
  late int thumbDown;

  @override
  void initState() {
    super.initState();
    thumbUp = comment.thumbUp;
    thumbDown = comment.thumbDown;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void doThumbUp() async {
    // Hive에서 데이터 가져오기
    final Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
    final Localdata? userData = box.get(LOCAL_DATA);

    if (userData == null) {
      throw Exception('User data is null');
    }

    if (userData.thumbUp.contains(comment.id)) {
      CustomSnackbar(
        title: "info".tr,
        message: 'recommendationMessage'.tr,
        status: ObserveSnackbarStatus.INFO,
      ).showSnackbar();
      return;
    }

    CompanyComment newComment = await companyCommentThumbUpDown(comment, ThumbStatus.UP);
    companyInfoProvider.comments[companyInfoProvider.comments.indexWhere((element) => element.id == newComment.id)] = newComment;
    setState(() {
      thumbUp = newComment.thumbUp;
    });

    // Hive에 데이터 저장
    userData.thumbUp.add(newComment.id);
    box.put(LOCAL_DATA, userData);
  }

  void doThumbDown() async {
    // Hive에서 데이터 가져오기
    final Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
    final Localdata? userData = box.get(LOCAL_DATA);

    if (userData == null) {
      throw Exception('User data is null');
    }

    if (userData.thumbDown.contains(comment.id)) {
      CustomSnackbar(
        title: "info".tr,
        message: 'notRecommendedMessage'.tr,
        status: ObserveSnackbarStatus.INFO,
      ).showSnackbar();
      return;
    }

    CompanyComment newComment = await companyCommentThumbUpDown(comment, ThumbStatus.DOWN);
    companyInfoProvider.comments[companyInfoProvider.comments.indexWhere((element) => element.id == newComment.id)] = newComment;
    setState(() {
      thumbDown = newComment.thumbDown;
    });

    // Hive에 데이터 저장
    userData.thumbDown.add(newComment.id);
    box.put(LOCAL_DATA, userData);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.thumb_up,
                color: Colors.blueAccent,
              ),
              onPressed: doThumbUp,
            ),
            Text(
              getNemberFormatString(thumbUp),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.thumb_down,
                color: Colors.redAccent,
              ),
              onPressed: doThumbDown,
            ),
            Text(
              getNemberFormatString(thumbDown),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
