import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/company_register_form_model.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:pocketbase/pocketbase.dart';

Future<void> registerComment(CompanyRegisterFormModel params) async {
  try {
    final pb = PocketBase(API_URL);

    // insert company rating
    params.companyRating.refCompany = params.company.id;
    await pb.collection('rating').create(body: params.companyRating.toMap());

    // insert company comment
    Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
    final userData = box.get(LOCAL_DATA);

    if (userData == null) {
      throw Exception('User data is null');
    }

    params.companyComment.refCompany = params.company.id;
    params.companyComment.refUser = userData.uuid;

    await pb.collection('comment').create(body: params.companyComment.toMap());
  } catch (e) {
    rethrow;
  }
}

Future<void> registerCompany(Company company) async {
  final pb = PocketBase(API_URL);
  final record = await pb.collection('company').create(body: company.toJson());
  company.id = record.id;
}
