import 'package:flutter_application_1/models/collections/company.dart';
import 'package:pocketbase/pocketbase.dart';

class SearchScreenModel {
  final Company company;

  SearchScreenModel({
    required this.company,
  });

  factory SearchScreenModel.fromJson(RecordModel record) {
    return SearchScreenModel(
      company: Company.fromRecordModel(record),
    );
  }
}
