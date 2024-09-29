import 'package:get/get.dart';

class SettingController extends GetxController {
  SettingController();

  _initData() {
    update(["setting"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
