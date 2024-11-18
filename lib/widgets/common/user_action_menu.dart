import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

const String _block = 'block';
const String _report = 'report';
const String _delete = 'delete';

class UserActionMenu extends StatelessWidget {
  const UserActionMenu({
    super.key,
    required this.id,
    required this.writerId,
    required this.handleBlock,
    required this.handleReport,
    required this.handleDelete,
  });

  final String id;
  final String writerId;
  final Function handleBlock;
  final Function handleReport;
  final Function handleDelete;

  PopupMenuItem<String>? renderDeleteButton() {
    Box box = Hive.box<Localdata>(SYSTEM_BOX);
    Localdata? localdata = box.get(LOCAL_DATA);

    log('UserActionMenu $writerId ${localdata?.uuid}');
    if (writerId == localdata?.uuid) {
      return PopupMenuItem<String>(
        value: _delete,
        child: Row(
          children: [
            const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            const SizedBox(width: 8),
            Text('delete'.tr),
          ],
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
        size: 28,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.grey[50],
      onSelected: (String result) {
        switch (result) {
          case _block:
            handleBlock(id);
            break;
          case _report:
            handleReport(id);
            break;
          case _delete:
            handleDelete(id);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: _block,
          child: Row(
            children: [
              const Icon(
                Icons.disabled_visible_outlined,
                color: Colors.red,
              ),
              const SizedBox(width: 8),
              Text('contentsBlock'.tr),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: _report,
          child: Row(
            children: [
              const Icon(
                Icons.report_problem_outlined,
                color: Colors.red,
              ),
              const SizedBox(width: 8),
              Text('reportIllegalPost'.tr),
            ],
          ),
        ),
        if (renderDeleteButton() != null) renderDeleteButton()!,
      ],
    );
  }
}
