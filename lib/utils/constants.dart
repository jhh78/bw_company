import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String SYSTEM_BOX = 'systemBox';
const String LOCAL_DATA = 'localData';

enum ObserveSnackbarStatus {
  INFO,
  SUCCESS,
  WARNING,
  ERROR,
}

enum ThumbStatus {
  UP,
  DOWN,
}

// .env 파일에 저장된 API_URL을 가져옵니다.
final String API_URL = kReleaseMode ? dotenv.env['REAL_API_URL'].toString() : dotenv.env['TEST_API_URL'].toString();
