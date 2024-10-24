import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/search_tag_model.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_application_1/widgets/common/custom_snackbar.dart';
import 'package:get/get.dart';

class SearchTagInputField extends StatefulWidget {
  const SearchTagInputField({super.key, required this.tags, required this.onTagChange});
  final String tags;
  final Function(List<String>) onTagChange;

  @override
  State<SearchTagInputField> createState() => _SearchTagInputFieldState();
}

class _SearchTagInputFieldState extends State<SearchTagInputField> {
  late List<SearchTagModel> _tagList = [];
  final TextEditingController _tagController = TextEditingController();
  bool _isTagFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _tagList = SearchTagModel.fromStringToList(widget.tags);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleDeleteChip(int index) {
    setState(() {
      _tagList.removeAt(index);
    });
  }

  List<Chip> _renderChipWidget() {
    return _tagList.map((tag) {
      return Chip(
        label: Text(tag.tagName),
        onDeleted: tag.isDelete
            ? () {
                _handleDeleteChip(_tagList.indexOf(tag));
              }
            : null,
      );
    }).toList();
  }

  void _handleTagFieldChange(String value) {
    log("SearchTagInputField _handleTagFieldChange $value ${value.isEmpty}");
    setState(() {
      _isTagFieldEmpty = value.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("SearchTagInputField build $_tagList");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: _tagController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "addSearchTag".tr,
                  helperText: "addSearchTagHintText".tr,
                ),
                onChanged: _handleTagFieldChange,
              ),
            ),
            _renderTagAddButton()
          ],
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _renderChipWidget(),
        ),
      ],
    );
  }

  Widget _renderTagAddButton() {
    if (_isTagFieldEmpty) return const SizedBox.shrink();

    return IconButton(
      onPressed: () {
        if (_tagList.any((e) => e.tagName == _tagController.text)) {
          CustomSnackbar(
            title: "errorText".tr,
            message: "alreadyExistTag".tr,
            status: ObserveSnackbarStatus.ERROR,
          ).showSnackbar();
          return;
        }

        setState(() {
          _tagList.add(SearchTagModel(tagName: _tagController.text, isDelete: true));
          _tagController.clear();
          _isTagFieldEmpty = true;
          widget.onTagChange(_tagList.map((e) => e.tagName).toList());
        });
      },
      icon: const Icon(
        Icons.add_circle_outline_rounded,
        size: 32,
        color: Colors.blue,
      ),
    );
  }

  List<SearchTagModel> get renderChipWidget => _tagList;
}
