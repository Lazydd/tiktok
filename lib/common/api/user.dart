import 'package:icebery_flutter/common/index.dart';

abstract class UserAPI {
  /// 登录获取token
  static Future<String> login(UserLoginRequest? params) async {
    var response = await HttpRequestService.to.post(
      '/login',
      data: params,
    );
    return response.data["body"];
  }

  /// 退出登录
  static Future<void> logout() async {
    await HttpRequestService.to.post(
      '/quit',
      contentType: 'form',
    );
  }

  /// 获取用户信息
  static Future<UserProfileModel> profile() async {
    var response = await HttpRequestService.to.get(
      '/user',
    );
    return UserProfileModel.fromJson(response.data["body"]);
  }

  /// 修改用户信息
  static Future<void> updateProfile(UserProfileModel profile) async {
    await HttpRequestService.to.post(
      '/updateUser',
      contentType: 'form',
      data: profile.toJson(),
    );
  }

  /// 修改密码
  static Future<Map> updatePwd(Map params) async {
    var response = await HttpRequestService.to.post(
      '/setpasswdNew',
      data: params,
      contentType: 'form',
    );
    return response.data;
  }

  /// 获取某个用户的功能权限 限制查询条件即可【access,app_code】
  static Future<List<String>> getAccessMapByUserId() async {
    var response =
        await HttpRequestService.to.get("/getAccessMapByUserId", params: {
      "applicationCode": "access,app_code",
    });
    Map<String, dynamic> map = response.data['body'];
    List<String> keys = map.keys.toList();
    return keys;
  }
}
