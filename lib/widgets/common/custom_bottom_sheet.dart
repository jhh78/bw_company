import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet {
  const CustomBottomSheet({
    required this.widget,
  });

  final Widget widget;

  void show() {
    Get.bottomSheet(
      widget,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
    );
  }
}
