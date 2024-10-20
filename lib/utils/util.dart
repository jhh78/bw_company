import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:intl/intl.dart';

// 릴리즈 모드일 경우 실제 광고 단위 ID를 반환하고, 디버그 모드일 경우 테스트 광고 단위 ID를 반환
String getRewardAdUnitId() {
  if (Platform.isAndroid) {
    return kReleaseMode ? 'ca-app-pub-9674517651101637/6682220543' : 'ca-app-pub-3940256099942544/5224354917';
  } else if (Platform.isIOS) {
    return kReleaseMode ? 'ca-app-pub-9674517651101637/7201861575' : 'ca-app-pub-3940256099942544/1712485313';
  }

  throw UnsupportedError('Unsupported platform for reward ad unit id ${Platform.operatingSystem}');
}

// 숫자를 3자리 단위로 콤마를 찍어주는 함수
String getNemberFormatString(int number) {
  final NumberFormat numberFormat = NumberFormat('#,###');
  return numberFormat.format(number);
}

// 로딩 화면을 보여주기 위한 함수, 릴리즈 모드에선 작동 안함
Future<void> delayScreen() async {
  if (kDebugMode) await Future.delayed(const Duration(seconds: 1));
}

// URL 유효성 검사 함수
bool isValidUrl(String url) => RegExp(URL_PATTERN).hasMatch(url);

// 구글 지도 URL 유효성 검사 함수
bool isValidGoogleMapUrl(String url) => RegExp(URL_PATTERN).hasMatch(url);
