import 'dart:convert';

import 'package:tiktok/common/utils/storage.dart';

class Constants {
  // 服务 api
  static const baseUrl = 'https://api.instantwebtools.net';

  static get mainBaseUrl {
    if (Storage().getString(Constants.storageIPConfig).isNotEmpty) {
      var ipMap = jsonDecode(Storage().getString(Constants.storageIPConfig));
      return ipMap["protocol"] + "://" + ipMap["ipAddress"];
    } else {
      return baseUrl;
    }
  }

  // 查看是否开启debug模式
  static get jwStorageDebug {
    return Storage().getBool(Constants.storageDebug);
  }

  static const storageDebug = "debug"; // 是否开启debug模式
  static const onlineVersion = 'online_version'; // 线上版本号
  static const isVersionDetect = 'is_version_detect'; // 是否检查版本更新
  static const storageToken = 'token'; // token
  static const storageProfile = 'profile'; // 用户信息
  static const storageAccount = 'account'; // 登录账号保存
  static const storagePassword = 'password'; // 登录密码保存
  static const storageIPConfig = 'ip_config'; // 存储 IP 配置
  static const externalLink = 'external_link'; // 外部链接

  static const imagesUrl = 'https://lazydd.github.io/douyin';

  static const iOSAppId = ""; // Apple Store 应用ID
  static const androidKeySeries = "";
  static const mapKey = ""; // 高德地图key

  static const androidDefaultDownloadURL = ""; // 安卓下载地址(http://xxx.apk)

  static get androidDownloadURL {
    if (Storage().getString(Constants.externalLink).isNotEmpty) {
      String url = jsonDecode(Storage().getString(Constants.externalLink));
      RegExp regex = RegExp(r'^(?:https?://)?([^:/]+)(?::\d+)?');
      Match match = regex.firstMatch(url) as Match;
      String? domainWithPort = "";
      domainWithPort = match.group(0);
      return "${domainWithPort!}/download/digital.apk";
    } else {
      return androidDefaultDownloadURL;
    }
  }
}
