import 'package:pocketbase/pocketbase.dart';

class CompanyRating {
  String id;
  String refCompany;
  double careerRating;
  double workingEnvironmentRating;
  double salaryWelfareRating;
  double corporateCultureRating;
  double managementRating;

  CompanyRating({
    this.id = '',
    this.refCompany = '',
    this.careerRating = 3.0,
    this.workingEnvironmentRating = 3.0,
    this.salaryWelfareRating = 3.0,
    this.corporateCultureRating = 3.0,
    this.managementRating = 3.0,
  });

  factory CompanyRating.fromMap(RecordModel record) {
    return CompanyRating(
      id: record.id,
      refCompany: record.expand['refCompany']?[0].toString() ?? '-1',
      careerRating: record.data['careerRating'].toDouble(),
      workingEnvironmentRating: record.data['workingEnvironmentRating'].toDouble(),
      salaryWelfareRating: record.data['salaryWelfareRating'].toDouble(),
      corporateCultureRating: record.data['corporateCultureRating'].toDouble(),
      managementRating: record.data['managementRating'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'refCompany': refCompany,
      'careerRating': careerRating,
      'workingEnvironmentRating': workingEnvironmentRating,
      'salaryWelfareRating': salaryWelfareRating,
      'corporateCultureRating': corporateCultureRating,
      'managementRating': managementRating,
    };
  }
}
