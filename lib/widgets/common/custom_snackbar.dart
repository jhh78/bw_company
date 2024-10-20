import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  final String title;
  final String message;
  final Enum status;

  CustomSnackbar({
    required this.title,
    required this.message,
    required this.status,
  });

  void showSnackbar() {
    Color backgroundColor;

    switch (status) {
      case ObserveSnackbarStatus.INFO:
        backgroundColor = Colors.blue[400]!;
        break;
      case ObserveSnackbarStatus.SUCCESS:
        backgroundColor = Colors.green[400]!;
        break;
      case ObserveSnackbarStatus.WARNING:
        backgroundColor = Colors.orange[400]!;
        break;
      case ObserveSnackbarStatus.ERROR:
        backgroundColor = Colors.red[400]!;
        break;
      default:
        backgroundColor = Colors.grey[400]!;
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      snackbarStatus: (status) {
        log('Snackbar status: $status');
      },
    );
  }
}
