import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

const String location = 'services/company_comment.dart';

Future<CompanyComment> companyCommentThumbUpDown(CompanyComment params, ThumbStatus type) async {
  try {
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
  } catch (e) {
    writeLogs(location, e.toString());
    rethrow;
  }
}

Future reportCompanyIllegalPost(String blockId, String contents) async {
  try {
    final pb = PocketBase(API_URL);

    final body = <String, dynamic>{
      "company_id": blockId,
      "contents": contents,
    };

    await pb.collection('report').create(body: body);
  } catch (e) {
    writeLogs(location, e.toString());
    rethrow;
  }
}

Future reportCommentIllegalPost(String blockId, String contents) async {
  try {
    final pb = PocketBase(API_URL);

    final body = <String, dynamic>{
      "comment_id": blockId,
      "contents": contents,
    };

    await pb.collection('report').create(body: body);
  } catch (e) {
    writeLogs(location, e.toString());
    rethrow;
  }
}
