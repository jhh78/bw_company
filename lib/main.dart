import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/providers/language.dart';
import 'package:flutter_application_1/screens/intro.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upgrader/upgrader.dart';

/**
 * 가이드라인 1.2 - 안전 - 사용자 생성 콘텐츠

우리는 귀하의 앱에서 사용자가 익명으로 콘텐츠를 게시할 수 있도록 허용하지만 적절한 예방 조치가 마련되어 있지 않다는 것을 발견했습니다.


다음 단계


이 문제를 해결하려면 다음 예방 조치를 모두 구현하도록 앱을 수정하세요.


- 불쾌한 콘텐츠를 필터링하는 방법
- 사용자가 학대적인 사용자를 차단할 수 있는 메커니즘


신고기능으로 어필
- 개발자는 앱 자체에 연락처 정보를 제공하여 사용자가 부적절한 활동을 보고할 수 있도록 해야 합니다.
- 개발자는 문제가 있는 콘텐츠 신고에 대해 24시간 이내에 해당 콘텐츠를 제거하고 문제가 있는 콘텐츠를 제공한 사용자를 추방하여 조치를 취해야 합니다.


가이드라인 1.5 - 안전
문제 설명


App Store Connect에서 제공하는 지원 URL https://jhh78.github.io/support/kr.html 과 https://jhh78.github.io/ 는 여전히 사용자가 질문을 하거나 지원을 요청할 수 있는 정보가 있는 웹사이트로 연결되지 않습니다.


다음 단계


사용자를 지원 정보가 있는 웹페이지로 안내하려면 지정된 지원 URL을 업데이트하세요.
 * 
 */

// TODO ::: 디자인 약간 손봐야됨

// ph2
//  TODO ::: 애플 결제 부분 추가

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");
  MobileAds.instance.initialize();

  final appDocumentDir = await getApplicationDocumentsDirectory();

  // Hive 초기화 및 박스 열기
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(LocaldataAdapter());
  await Hive.openBox<Localdata>(SYSTEM_BOX);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: !kReleaseMode,
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.blue),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            shadowColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.blue.shade900;
              }
              return Colors.blue.shade500;
            }),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ),
      home: UpgradeAlert(
        child: const IntroScreen(),
      ),
    );
  }
}
