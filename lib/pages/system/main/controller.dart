part of main;

class MainController extends GetxController {
  MainController();

  final LocalAuthentication auth = LocalAuthentication();

  final PageController pageController = PageController();

  int currentIndex = 0;

  // 导航栏切换
  void onIndexChanged(int index) {
    currentIndex = index;
    // if ((((UserFunc.isSupervisionGroup() == false) ||
    //         (UserFunc.isSupervisionGroup() == true &&
    //             (UserFunc.isRole(RoleType.leadership) ||
    //                 UserFunc.isRole(RoleType.groupLeader)))) &&
    //     currentIndex == 1)) {
    //   getErrorEventListByPage();
    // }
    update(['navigation']);
  }

  _initData() {
    update(["main"]);
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

  void onJumpToPage(int page) {
    pageController.jumpToPage(page);
  }
}
