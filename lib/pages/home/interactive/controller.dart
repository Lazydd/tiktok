part of interactive;

class InteractiveController extends GetxController {
  InteractiveController();

  bool favorite = false;
  bool collect = false;

  void favoriteChange() {
    favorite = !favorite;
    update(['interactive']);
  }

  void collectChange() {
    collect = !collect;
    update(['interactive']);
  }

  _initData() {
    update(["interactive"]);
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
