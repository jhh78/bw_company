import 'dart:developer';

import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

Future<CompanyComment> companyCommentThumbUpDown(CompanyComment params, ThumbStatus type) async {
  final pb = PocketBase(API_URL);

  final oriData = await pb.collection('comment').getOne(params.id, expand: 'refCompany,refUser');
  final CompanyComment comment = CompanyComment.fromMap(oriData);

  if (type == ThumbStatus.DOWN) {
    comment.thumbDown += 1;
  } else if (type == ThumbStatus.UP) {
    comment.thumbUp += 1;
  }

  comment.refCompany = oriData.data['refCompany'];
  comment.refUser = oriData.data['refUser'];

  final body = {
    ...comment.toMap(),
    'refCompany': oriData.data['refCompany'],
    'refUser': oriData.data['refUser'],
  };

  final record = await pb.collection('comment').update(params.id, body: body, expand: 'refCompany,refUser');
  return CompanyComment.fromMap(record);
}

Future reportIllegalPost(String commentId, String contents) async {
  final pb = PocketBase(API_URL);

  final body = <String, dynamic>{"comment_id": commentId, "contents": contents};

  await pb.collection('report').create(body: body);
}
