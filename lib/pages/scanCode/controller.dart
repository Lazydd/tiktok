part of 'index.dart';

class ScanCodeController extends GetxController {
  ScanCodeController();

  /// 扫码控制器key
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QRKey');

  /// 扫码控制器
  QRViewController? qrViewController;

  /// 是否开启闪光灯
  bool isFlash = false;

  /// 打开闪光灯
  void openFlash() {
    isFlash = !isFlash;
    qrViewController?.toggleFlash();
    update(["scan_code_flash"]);
  }

  _initData() {
    update(["scan_code"]);
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

  @override
  void onClose() {
    super.onClose();
  }
}
