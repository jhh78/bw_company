import 'package:flutter/material.dart';

class BottomLoading extends StatelessWidget {
  final bool check;

  const BottomLoading({
    super.key,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    if (check) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0), // 위아래 여백 추가
        child: const CircularProgressIndicator(
          backgroundColor: Colors.transparent, // 배경색
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // 진행 색상
          strokeWidth: 3,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
