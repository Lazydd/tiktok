import 'dart:convert';
import 'dart:io';
import 'package:tiktok/common/index.dart';

class VersionFunc {
  /// 接口获取线上版本并保存到本地
  static Future<void> init() async {
    if (UserService.to.isLogin) {
      List list = await OtherAPI.getPlatformInfo();
      for (dynamic el in list) {
        if (el.configKey == "externalLink") {
          if (UtilsFunc.isUrl(el.configValue ?? "")) {
            Storage()
                .setString(Constants.externalLink, jsonEncode(el.configValue));
            VersionInfoModel version =
                await OtherAPI.getVersionInfo(el.configValue!);
            Storage().setString(Constants.onlineVersion, jsonEncode(version));
          }
        }
      }
    }
  }

  static void delloc() {
    Storage().remove(Constants.onlineVersion);
  }

  /// 本地获取版本信息model
  static VersionInfoModel get versionModel {
    var versionStr = Storage().getString(Constants.onlineVersion);
    if (versionStr.isNotEmpty) {
      return VersionInfoModel.fromJson(jsonDecode(versionStr));
    }
    return VersionInfoModel();
  }

  /// 比较版本号
  static bool isSameVersion() {
    if (onlineVersion.isNotEmpty) {
      int onlineVersionInt = int.parse(onlineVersion.replaceAll('.', ''));
      int versionInt = int.parse(ConfigService.to.version.replaceAll('.', ''));
      return versionInt >= onlineVersionInt;
    } else {
      return true;
    }
  }

  /// 获取线上的版本号
  static String get onlineVersion {
    if (Platform.isIOS) {
      return versionModel.iOS?.version ?? "";
    }
    if (Platform.isAndroid) {
      return versionModel.android?.version ?? "";
    }
    return "";
  }

  /// 获取安卓证书key序列号
  static String get androidKeySeries {
    return versionModel.android?.keyseries ?? "";
  }

  /// 版本提醒
  static bool get isVersionReminder {
    if (ConfigService.to.isVersionDetect && !isSameVersion()) {
      return true;
    } else {
      return false;
    }
  }
}
