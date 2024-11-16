import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomConfirmDialog {
  const CustomConfirmDialog({
    required this.title,
    required this.subtitle,
    required this.onConfirm,
  });

  final String title;
  final String subtitle;
  final Function onConfirm;

  void show() {
    Get.defaultDialog(
      title: title,
      middleText: subtitle,
      textConfirm: 'confirm'.tr,
      textCancel: 'cancel'.tr,
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: Colors.red,
      onConfirm: () => onConfirm(),
      barrierDismissible: false,
      radius: 10,
      contentPadding: const EdgeInsets.all(20),
    );
  }
}
