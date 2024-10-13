import 'package:get/get.dart';

class SystemsProvider extends GetxController {
  RxMap<String, bool?> formValidate = <String, bool?>{}.obs;
  RxMap<String, dynamic> formData = <String, dynamic>{}.obs;
}
