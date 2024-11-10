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

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 애니메이션을 시작하기 위해 상태를 변경
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          child: Stack(
            children: [
              Container(
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
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 50),
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _animation.value,
                      child: Text(
                        'pleaseTouchScreenAndStart'.tr,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
