part of 'index.dart';

class EditUserInfoController extends GetxController {
  EditUserInfoController(this.type, this.value);

  String type;
  String value;

  TextEditingController eventNameController = TextEditingController();

  _initData() {
    update(["edit_user_info"]);
    eventNameController.text = value;
  }

  void submit() {
    Get.back();
  }

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
