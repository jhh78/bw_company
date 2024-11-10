import 'package:flutter/material.dart';

class OrverlapLoading extends StatelessWidget {
  const OrverlapLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black54,
        child: const Center(
          child: RefreshProgressIndicator(),
        ),
      ),
    );
  }
}
