import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/models/collections/company_rating.dart';
import 'package:flutter_application_1/models/search_tag_model.dart';
import 'package:flutter_application_1/services/exception.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

const String location = "lib/providers/company_info.dart";

class CompanyInfoProvider extends GetxController {
  Rx<CompanyRating> companyRating = CompanyRating(
    careerRating: 0,
    corporateCultureRating: 0,
    managementRating: 0,
    salaryWelfareRating: 0,
    workingEnvironmentRating: 0,
  ).obs;

  RxList<CompanyComment> comments = <CompanyComment>[].obs;
  RxList<SearchTagModel> tags = <SearchTagModel>[].obs;

  RxInt page = 1.obs;
  RxInt perPage = 15.obs;
  RxBool isAppendItemLoading = false.obs;
  RxBool isInitItemLoading = false.obs;

  Future<ResultList<RecordModel>> getCompanyList(String companyID) async {
    final pb = PocketBase(API_URL);
    return pb.collection('comment').getList(
          filter: 'refCompany = "$companyID"',
          expand: 'refCompany, refUser',
          sort: '-created',
          page: page.value,
          perPage: perPage.value,
        );
  }

  void getInitItems(String companyID) => WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          isInitItemLoading.value = true;
          comments.clear();

          await delayScreen();

          final pb = PocketBase(API_URL);

          final futures = <Future>[
            pb.collection('ratingAVG').getOne(companyID),
            getCompanyList(companyID),
            pb.collection('company').getOne(companyID),
          ];

          // 데이터가 존재하지 않을경우 에러가 발생하므로 try-catch에서 처리
          final [rating, comment, company] = await Future.wait(futures);

          companyRating.value = CompanyRating.fromMap(rating);
          // 반복문을 사용하여 resultList의 items를 searchList에 추가
          for (final item in comment.items) {
            comments.add(CompanyComment.fromMap(item));
          }

          if (company.data['tags'].toString().isNotEmpty) {
            final List<String> tagList = company.data['tags'].split(SEARCH_TAG_SEPARATOR);
            for (final tag in tagList) {
              tags.add(SearchTagModel(tagName: tag));
            }
          }
        } catch (e) {
          writeLogs(location, e.toString());
        } finally {
          isInitItemLoading.value = false;
        }
      });

  void moreCommentDataLoad() async {
    try {
      if (isAppendItemLoading.value || comments.length / perPage.value < page.value) return;
      isAppendItemLoading.value = true;
      page.value += 1;

      // 로딩 화면을 보여주기 위한 함수, 릴리즈 모드에선 작동 안함
      await delayScreen();

      final Company company = Company.fromJson(jsonDecode(comments.first.refCompany));
      final comment = await getCompanyList(company.id);

      for (final item in comment.items) {
        comments.add(CompanyComment.fromMap(item));
      }
    } catch (e) {
      writeLogs(location, e.toString());
    } finally {
      isAppendItemLoading.value = false;
    }
  }
}
