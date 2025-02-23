import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/company_register_form_model.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:pocketbase/pocketbase.dart';

const String location = 'services/company.dart';

Future<void> registerComment(CompanyRegisterFormModel params) async {
  try {
    // insert company comment
    Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
    final userData = box.get(LOCAL_DATA);

    if (userData == null) {
      throw Exception('User data is null');
    }

    final pb = PocketBase(API_URL);

    // 입력 데이터 정리
    params.companyRating.refCompany = params.company.id;
    params.companyComment.refCompany = params.company.id;
    params.companyComment.refUser = userData.uuid;

    await Future.wait([
      pb.collection('rating').create(body: params.companyRating.toMap()),
      pb.collection('comment').create(body: params.companyComment.toMap())
    ]);

    // 새로운 태그의 추가
    if (params.company.tags != null) {
      final newTags = params.company.tags.toString().split(SEARCH_TAG_SEPARATOR);

      final record = await pb.collection('company').getOne(params.company.id);

      if (record.data['tags'].toString().isNotEmpty) {
        newTags.addAll(record.data['tags'].toString().split(SEARCH_TAG_SEPARATOR));
      }

      params.company.tags = newTags.toSet().toList().join(SEARCH_TAG_SEPARATOR);
      params.company.refUser = userData.uuid;
      await pb.collection('company').update(record.id, body: params.company.toJson());
    }
  } catch (e) {
    writeLogs(location, e.toString());
    rethrow;
  }
}

Future<void> deleteComment(String id) async {
  try {
    final pb = PocketBase(API_URL);
    await pb.collection('comment').delete(id);
  } catch (e) {
    writeLogs(location, e.toString());
    rethrow;
  }
}

Future<void> registerCompany(Company company) async {
  try {
    Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
    final userData = box.get(LOCAL_DATA);

    if (userData == null) {
      throw Exception('User data is null');
    }

    final pb = PocketBase(API_URL);
    company.refUser = userData.uuid;
    final record = await pb.collection('company').create(body: company.toJson());
    company.id = record.id;
  } catch (e) {
    writeLogs(location, e.toString());
    rethrow;
  }
}

Future<bool> checkDuplicateCompany(String companyName) async {
  try {
    final pb = PocketBase(API_URL);
    final record = await pb.collection('company').getList(
          filter: "name='$companyName'",
        );

    return record.items.isNotEmpty;
  } catch (e) {
    writeLogs(location, e.toString());
    return false;
  }
}

Future<void> deleteCompany(String id) async {
  try {
    final pb = PocketBase(API_URL);
    await pb.collection('company').delete(id);
  } catch (e) {
    writeLogs(location, e.toString());
    rethrow;
  }
}
