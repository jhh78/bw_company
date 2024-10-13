import 'dart:developer';

import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

Future<RecordModel> getNoticeData(String type) async {
  try {
    log('getNoticeData ${Get.locale!.languageCode}');
    await delayScreen();

    String languageCode = Get.locale!.languageCode;
    if (languageCode != 'ko' && languageCode != 'ja') {
      languageCode = 'en';
    }

    final pb = PocketBase(API_URL);
    // or fetch only the first record that matches the specified filter
    return await pb.collection('notice').getFirstListItem(
          'type="$type" && lang="$languageCode"',
        );
  } catch (e) {
    rethrow;
  }
}
