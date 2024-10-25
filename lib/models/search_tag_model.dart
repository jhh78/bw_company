import 'package:flutter_application_1/utils/constants.dart';

class SearchTagModel {
  final String tagName;
  final bool isDelete;

  SearchTagModel({required this.tagName, this.isDelete = false});

  static List<SearchTagModel> fromStringToList(String tags) {
    if (tags.isEmpty) {
      return [];
    }

    return tags.split(SEARCH_TAG_SEPARATOR).map((tag) {
      return SearchTagModel(
        tagName: tag,
        isDelete: false,
      );
    }).toList();
  }
}
