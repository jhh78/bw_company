import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/search_screen_model.dart';
import 'package:flutter_application_1/providers/search_screen.dart';
import 'package:flutter_application_1/screens/corporate_info.dart';
import 'package:flutter_application_1/utils/util.dart';
import 'package:get/get.dart';

class ListContents extends StatelessWidget {
  ListContents({
    super.key,
  });

  final SearchScreenProvider _searchScreenProvider = Get.put(SearchScreenProvider());
  final ScrollController _scrollController = ScrollController();
  void initScreen() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels != _scrollController.position.maxScrollExtent) return;

      _searchScreenProvider.moreDataLoad();
    });
  }

  Widget _renderItems() {
    if (_searchScreenProvider.searchList.isEmpty) {
      return Center(
        child: Text("dataNotFound".tr, style: const TextStyle(fontSize: 20)),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _searchScreenProvider.searchList.length,
      itemBuilder: (BuildContext context, int index) {
        final SearchScreenModel item = _searchScreenProvider.searchList[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            trailing: const Icon(Icons.arrow_forward, color: Colors.blue), // 오른쪽에 아이콘 추가
            tileColor: Colors.white, // 타일 배경색
            selectedTileColor: Colors.blue[50], // 선택된 타일 배경색
            selected: false, // 타일 선택 여부
            title: Text(item.company.name),
            subtitle: Row(
              children: [
                const Icon(Icons.thumb_up, color: Colors.blue, size: 20),
                const SizedBox(width: 4),
                Text(getNemberFormatString(item.company.thumbUp)),
                const SizedBox(width: 16),
                const Icon(Icons.thumb_down, color: Colors.red, size: 20),
                const SizedBox(width: 4),
                Text(getNemberFormatString(item.company.thumbDown)),
              ],
            ),
            onTap: () {
              Get.to(
                () => CorporateInfoScreen(
                  company: item.company,
                ),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 500),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initScreen();
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        child: Obx(() => _renderItems()),
      ),
    );
  }
}
