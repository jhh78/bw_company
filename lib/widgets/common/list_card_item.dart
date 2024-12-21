import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/localdata.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:flutter_application_1/widgets/common/user_action_menu.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ListCardItem extends StatefulWidget {
  const ListCardItem({
    super.key,
    required this.id,
    required this.writerId,
    required this.title,
    required this.thumbUp,
    required this.thumbDown,
    required this.handleBlock,
    required this.handleReport,
    required this.nextPageRoute,
    required this.handleDelete,
    this.handleModify,
  });

  final String id;
  final String writerId;
  final String title;
  final int thumbUp;
  final int thumbDown;
  final Function handleBlock;
  final Function handleReport;
  final Function nextPageRoute;
  final Function handleDelete;
  final Function? handleModify;

  @override
  State<ListCardItem> createState() => _ListCardItemState();
}

class _ListCardItemState extends State<ListCardItem> {
  final Box<Localdata> box = Hive.box<Localdata>(SYSTEM_BOX);
  late Localdata? localdata;

  @override
  void initState() {
    super.initState();
    localdata = box.get(LOCAL_DATA);
    log('ListCardItem localdata: ${localdata?.toMap()}');
  }

  @override
  Widget build(BuildContext context) {
    if (localdata?.commentBlock.contains(widget.id) ?? false) {
      return Container(
        height: 74,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text("meseageBlocked".tr)),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    softWrap: true,
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.thumb_up, color: Colors.blue, size: 20),
                      const SizedBox(width: 4),
                      Text(getNemberFormatString(widget.thumbUp)),
                      const SizedBox(width: 16),
                      const Icon(Icons.thumb_down, color: Colors.red, size: 20),
                      const SizedBox(width: 4),
                      Text(getNemberFormatString(widget.thumbDown)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.blue,
                ),
                onPressed: () => widget.nextPageRoute(),
              ),
              UserActionMenu(
                id: widget.id,
                writerId: widget.writerId,
                handleBlock: widget.handleBlock,
                handleReport: widget.handleReport,
                handleDelete: widget.handleDelete,
                handleModify: widget.handleModify,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
