import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../index.dart';

class ConfigService extends GetxService {
  // 这是一种单例写法 后面我们会用到的onReady 的时候初始数据。【使用的时候例如：ConfigService.to.version即可】
  static ConfigService get to => Get.find();

  // 项目版本号
  PackageInfo? _platform;
  String get version => _platform?.version ?? '0.0.0';

  // 主题
  final RxBool _isDarkMode = Get.isDarkMode.obs;
  bool get isDarkMode => _isDarkMode.value;

  // 是否开启版本检测
  bool get isVersionDetect => Storage().getBool(Constants.isVersionDetect);

  @override
  void onReady() {
    super.onReady();
    getPlatform();
  }

  // ==================== 平台信息 ====================
  /// 获取pubspec.yaml配置中的版本号(version)
  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  // 标记开启版本检测
  void setVersionDetect({bool boolValue = true}) {
    Storage().setBool(Constants.isVersionDetect, boolValue);
  }
}
