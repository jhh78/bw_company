import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company.dart';
import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/models/collections/company_rating.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class CompanyInfoProvider extends GetxController {
  Rx<CompanyRating> companyRating = CompanyRating(
    careerRating: 0,
    corporateCultureRating: 0,
    managementRating: 0,
    salaryWelfareRating: 0,
    workingEnvironmentRating: 0,
  ).obs;

  RxList<CompanyComment> comments = <CompanyComment>[].obs;

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
          log('CompanyInfoProvider getAllItems');

          isInitItemLoading.value = true;
          comments.clear();

          // 로딩 화면을 보여주기 위한 함수, 릴리즈 모드에선 작동 안함
          await delayScreen();

          final pb = PocketBase(API_URL);

          final futures = <Future>[
            pb.collection('ratingAVG').getOne(companyID),
            getCompanyList(companyID),
          ];

          // 데이터가 존재하지 않을경우 에러가 발생하므로 try-catch에서 처리
          final [rating, comment] = await Future.wait(futures);

          companyRating.value = CompanyRating.fromMap(rating);
          // 반복문을 사용하여 resultList의 items를 searchList에 추가
          for (final item in comment.items) {
            comments.add(CompanyComment.fromMap(item));
          }
        } catch (e) {
          log(e.toString());
        } finally {
          isInitItemLoading.value = false;
        }
      });

  void moreCommentDataLoad() async {
    try {
      if (isAppendItemLoading.value || comments.length / perPage.value < page.value) return;
      log('CompanyInfoProvider moreCommentDataLoad');
      isAppendItemLoading.value = true;
      page.value += 1;

      // 로딩 화면을 보여주기 위한 함수, 릴리즈 모드에선 작동 안함
      await delayScreen();

      final Company company = Company.fromJson(jsonDecode(comments.first.refCompany));
      final comment = await getCompanyList(company.id);

      for (final item in comment.items) {
        comments.add(CompanyComment.fromMap(item));
      }

      log('CompanyInfoProvider moreCommentDataLoad ${comments.length}');
    } catch (e) {
      log(e.toString());
    } finally {
      isAppendItemLoading.value = false;
    }
  }
}
