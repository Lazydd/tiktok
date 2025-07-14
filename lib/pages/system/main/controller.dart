part of 'index.dart';

class MainController extends GetxController {
  MainController();

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

  final LocalAuthentication auth = LocalAuthentication();

  bool didAuthenticate = false;

  Future<bool> _checkBiometric() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    bool isAuthorized = false;

    if (availableBiometrics.isEmpty) {
      Loading.error('当前设备不支持生物识别');
    }
    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      try {
        isAuthorized = await auth.authenticate(
          localizedReason: "Please authenticate to complete your transaction",
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
      } on PlatformException catch (e) {
        Loading.error(e.message);
      }
    }
    didAuthenticate = isAuthorized;
    return isAuthorized;
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
