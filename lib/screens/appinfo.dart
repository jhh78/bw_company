import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/search.dart';
import 'package:get/get.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // 애니메이션을 시작하기 위해 상태를 변경
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: GestureDetector(
          onTap: () => Get.offAll(
            () => const SearchScreen(),
            transition: Transition.fade,
            duration: const Duration(seconds: 1),
          ),
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 1),
                curve: Curves.easeIn,
                child: Text(
                  "appInfoTitle".tr,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
