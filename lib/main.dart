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

// TODO ::: 디자인 약간 손봐야됨
/**
가이드라인 1.2 - 안전 - 사용자 생성 콘텐츠

귀하의 앱은 사용자가 익명으로 콘텐츠를 게시할 수 있도록 하지만 적절한 예방 조치가 마련되어 있지 않습니다.


다음 단계


이 문제를 해결하려면 다음 예방 조치를 모두 구현하도록 앱을 수정하세요.

TODO :: 코멘트 삭제 기능 추가 , 자기가 작성한 코멘트만 삭제된다
- 사용자가 피드에서 게시물을 즉시 제거할 수 있는 메커니즘


가이드라인 2.3.3 - 성능 - 정확한 메타데이터
문제 설명


제공된 스크린샷 중 일부 또는 전부가 사용 중인 앱을 충분히 보여주지 않습니다. 스크린샷은 사용자가 앱의 기능과 가치를 이해하는 데 도움이 되도록 앱의 핵심 개념을 강조해야 합니다.


스크린샷을 추가하거나 업데이트할 때 다음 요구 사항을 따르세요.


- 앱의 UI를 반영하지 않는 마케팅이나 홍보 자료는 스크린샷에 적합하지 않습니다.

- 대부분의 스크린샷은 앱의 주요 기능과 기능을 강조해야 합니다.

- 앱이 모든 언어와 모든 지원 기기에서 동일하게 보이고 작동하는지 확인하세요.

- 스크린샷은 앱을 여러 Apple 플랫폼에서 사용할 수 있음을 보여주기 위해 포함된 경우가 아니면 올바른 기기에서 사용 중인 앱을 보여야 합니다. 예를 들어, iPhone 스크린샷은 iPad가 아닌 iPhone에서 찍어야 합니다.


다음 단계


13인치 iPad 스크린샷은 iPad 이미지처럼 보이도록 수정되거나 늘어난 iPhone 이미지를 보여줍니다. 지원되는 각 기기에서 사용 중인 앱을 정확하게 반영하는 새로운 스크린샷을 업로드하세요.


자원


- App Store에 멋진 스크린샷을 만드는 방법에 대해 자세히 알아보려면 제품 페이지 만들기를 참조하세요 .

- 스크린샷 업로드에 대한 자세한 내용은 App Store Connect 도움말을 참조하세요 .


가이드라인 2.5.10 - 성능 - 소프트웨어 요구 사항

귀하의 앱 또는 스크린샷에 테스트 광고가 포함되어 있는 것을 확인했습니다. 테스트 또는 데모 목적의 기능이 포함된 앱 또는 메타데이터 항목은 App Store에 적합하지 않습니다.


다음 단계


이 문제를 해결하려면 앱을 수정하여 부분적으로 구현된 기능을 완료, 제거 또는 완전히 구성하세요. 스크린샷에 데모, 테스트 또는 기타 불완전한 콘텐츠 이미지가 포함되지 않도록 하세요.
 */

// ph2
//  TODO ::: 애플 결제 부분 추가

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");
  MobileAds.instance.initialize();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(LocaldataAdapter());

  // Hive 초기화 및 박스 열기
  await Hive.initFlutter(appDocumentDir.path);
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
