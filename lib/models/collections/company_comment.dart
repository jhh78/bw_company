import 'package:pocketbase/pocketbase.dart';

class CompanyComment {
  String title;
  String career;
  String workingEnvironment;
  String salaryWelfare;
  String corporateCulture;
  String management;
  int thumbUp;
  int thumbDown;

  String refCompany;
  String refUser;
  String id;

  CompanyComment({
    this.title = '',
    this.career = '',
    this.workingEnvironment = '',
    this.salaryWelfare = '',
    this.corporateCulture = '',
    this.management = '',
    this.id = '',
    this.thumbUp = 0,
    this.thumbDown = 0,
    this.refCompany = '',
    this.refUser = '',
  });

  factory CompanyComment.fromMap(RecordModel record) {
    return CompanyComment(
      title: record.data['title'],
      career: record.data['career'],
      workingEnvironment: record.data['workingEnvironment'],
      salaryWelfare: record.data['salaryWelfare'],
      corporateCulture: record.data['corporateCulture'],
      management: record.data['management'],
      refCompany: record.expand['refCompany']!.first.toString(),
      refUser: record.expand['refUser']!.first.toString(),
      id: record.id,
      thumbUp: record.data['thumbUp'],
      thumbDown: record.data['thumbDown'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'career': career,
      'workingEnvironment': workingEnvironment,
      'salaryWelfare': salaryWelfare,
      'corporateCulture': corporateCulture,
      'management': management,
      'refCompany': refCompany,
      'refUser': refUser,
      'id': id,
      'thumbUp': thumbUp,
      'thumbDown': thumbDown,
    };
  }
}
