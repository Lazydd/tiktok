part of main;

/// 主界面依赖
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<FriendController>(() => FriendController());
    Get.lazyPut<MessageController>(() => MessageController());
    Get.lazyPut<MineController>(() => MineController());
  }
}
