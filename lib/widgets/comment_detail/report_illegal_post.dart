import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/collections/company_comment.dart';
import 'package:flutter_application_1/providers/systems.dart';
import 'package:get/get.dart';

class ReportIllegalPost extends StatelessWidget {
  ReportIllegalPost({
    super.key,
    required this.comment,
  });

  final CompanyComment comment;
  final TextEditingController _reportContentsController = TextEditingController();
  final SystemsProvider _systemsProvider = Get.put(SystemsProvider());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "reportIllegalPost".tr,
                style: TextStyle(fontSize: 24),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                      size: 32,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      log("reportContents: ${_reportContentsController.text}");
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.upload_rounded,
                      size: 32,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            minLines: 7,
            maxLines: 10,
            controller: _reportContentsController,
            decoration: InputDecoration(
              hintText: comment.id,
              // errorText: "errorText",
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
