import 'package:get/get.dart';

class SystemsProvider extends GetxController {
  RxMap<String, bool?> formValidate = <String, bool?>{}.obs;
  RxMap<String, dynamic> formData = <String, dynamic>{}.obs;
  RxBool isModalOpen = false.obs;
  RxBool isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  void initializeData() {
    formValidate.value = {};
    formData.value = {};
    isModalOpen.value = false;
    isProcessing.value = false;
    // 추가적인 초기화 작업을 여기에 추가할 수 있습니다.
  }
}
