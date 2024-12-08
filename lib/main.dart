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

// TODO ::: 해야될것들
// TODO ::: 명예의 전당 추가
// TODO ::: 디자인 개선
// TODO ::: 안드로이드 심사 통과하면 애드몹 실광고 아이디 넣기

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    await Upgrader.clearSavedSettings();
  }

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
        // fontFamily: 'Roboto', // 기본 폰트 설정
        // textTheme: const TextTheme(
        //   bodyMedium: TextStyle(fontSize: 16.0, fontFamily: 'Subak'),
        //   bodyLarge: TextStyle(fontSize: 14.0, fontFamily: 'Subak'),
        //   headlineLarge: TextStyle(fontSize: 24.0, fontFamily: 'Subak'),
        //   headlineMedium: TextStyle(fontSize: 22.0, fontFamily: 'Subak'),
        // ),
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
        upgrader: Upgrader(debugLogging: kDebugMode),
        barrierDismissible: false,
        showIgnore: false,
        showLater: false,
        child: const IntroScreen(),
      ),
    );
  }
}
