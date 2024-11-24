import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

const String _block = 'block';
const String _report = 'report';
const String _delete = 'delete';
const String _modify = 'modify';

class UserActionMenu extends StatelessWidget {
  const UserActionMenu({
    super.key,
    required this.id,
    required this.writerId,
    required this.handleBlock,
    required this.handleReport,
    required this.handleDelete,
    this.handleModify,
  });

  final String id;
  final String writerId;
  final Function handleBlock;
  final Function handleReport;
  final Function handleDelete;
  final Function? handleModify;

  bool isOwner() {
    Box box = Hive.box<Localdata>(SYSTEM_BOX);
    Localdata? localdata = box.get(LOCAL_DATA);

    log('UserActionMenu $writerId ${localdata?.uuid}');
    return writerId == localdata?.uuid;
  }

  void handleOnselected(String result) {
    if (result == _block) {
      handleBlock(id);
    } else if (result == _report) {
      handleReport(id);
    } else if (result == _delete) {
      handleDelete(id);
    } else if (result == _modify) {
      if (handleModify != null) {
        handleModify!(id);
      }
    }
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
      onSelected: handleOnselected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        if (!isOwner())
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
        if (handleModify != null)
          PopupMenuItem<String>(
            value: _modify,
            child: Row(
              children: [
                const Icon(
                  Icons.edit_note,
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                Text('modifyRequest'.tr),
              ],
            ),
          ),
        if (!isOwner())
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
        if (isOwner())
          PopupMenuItem<String>(
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
          ),
      ],
    );
  }
}
