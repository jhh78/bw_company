import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextInputField extends StatelessWidget {
  const CustomTextInputField({super.key, required this.hintText, required this.controller, required this.isValidate, this.helperText});

  final String hintText;
  final TextEditingController controller;
  final bool isValidate;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: TextField(
        minLines: 1,
        maxLines: 10,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          helperText: helperText,
          errorText: isValidate ? "requiredField".tr : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
