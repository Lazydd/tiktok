part of home;

class HomeController extends GetxController {
  HomeController();

  PageController pageController = PageController();

  _initData() {}

  void pageChange(int page) {
    update(['video']);
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
