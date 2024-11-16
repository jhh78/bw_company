import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String _block = 'block';
const String _report = 'report';
const String _delete = 'delete';

class UserActionMenu extends StatelessWidget {
  const UserActionMenu({
    super.key,
    required this.id,
    required this.handleBlock,
    required this.handleReport,
    required this.handleDelete,
  });

  final Function handleBlock;
  final String id;
  final Function handleReport;
  final Function handleDelete;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.black,
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
        PopupMenuItem<String>(
          value: _delete,
          child: Row(
            children: [
              const Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
              ),
              const SizedBox(width: 8),
              Text('deleteButton'.tr),
            ],
          ),
        ),
      ],
    );
  }
}
