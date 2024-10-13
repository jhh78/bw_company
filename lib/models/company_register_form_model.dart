import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/collections/company_rating.dart';

class CompanyRegisterFormModel {
  Company company = Company();
  CompanyRating companyRating = CompanyRating();
  CompanyComment companyComment = CompanyComment();

  Map<String, dynamic> toMapOfCompanyRating() {
    return {
      'refCompany': companyRating.refCompany,
      'careerRating': companyRating.careerRating,
      'corporateCultureRating': companyRating.corporateCultureRating,
      'managementRating': companyRating.managementRating,
      'salaryWelfareRating': companyRating.salaryWelfareRating,
      'workingEnvironmentRating': companyRating.workingEnvironmentRating,
    };
  }

  Map<String, dynamic> toMapOfCompany() {
    return {
      'name': company.name,
    };
  }

  Map<String, dynamic> toMapOfCompanyComment() {
    return {
      'career': companyComment.career,
      'corporateCulture': companyComment.corporateCulture,
      'management': companyComment.management,
      'refCompany': companyComment.refCompany,
      'refUser': companyComment.refUser,
      'salaryWelfare': companyComment.salaryWelfare,
      'title': companyComment.title,
      'workingEnvironment': companyComment.workingEnvironment,
    };
  }
}
