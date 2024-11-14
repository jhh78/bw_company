import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String _block = 'block';
const String _report = 'report';

class ExstraMenu extends StatelessWidget {
  const ExstraMenu({
    super.key,
    required this.handleBlock,
    required this.id,
    required this.handleReport,
  });

  final Function handleBlock;
  final String id;
  final Function handleReport;

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
                Icons.report_gmailerrorred,
                color: Colors.red,
              ),
              const SizedBox(width: 8),
              Text('reportIllegalPost'.tr),
            ],
          ),
        ),
      ],
    );
  }
}
