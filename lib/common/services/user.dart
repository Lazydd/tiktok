import 'dart:convert';

import 'package:get/get.dart';

import '../index.dart';

/// 用户服务
class UserService extends GetxController {
  static UserService get to => Get.find();

  final _isLogin = false.obs;
  String token = "";
  final _profile = UserProfileModel().obs;

  /// 判断是否登录
  bool get isLogin => _isLogin.value;
  set isLogin(bool value) => _isLogin.value = value;

  /// 用户profile
  UserProfileModel get profile => _profile.value;

  /// 是否有token令牌
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    // 读取token
    token = Storage().getString(Constants.storageToken);
    // 读profile
    var profileStr = Storage().getString(Constants.storageProfile);
    if (token.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserProfileModel.fromJson(jsonDecode(profileStr)));
    } else {
      _isLogin.value = false;
      _profile(UserProfileModel());
    }
  }

  /// 设置令牌
  Future<void> setToken(String value) async {
    await Storage().setString(Constants.storageToken, value);
    token = value;
  }

  /// 获取用户 profile
  Future<void> getProfile() async {
    if (token.isEmpty) return;
    UserProfileModel profile = await UserAPI.profile();
    _profile(profile);
    _isLogin.value = true;
    Storage().setString(Constants.storageProfile, jsonEncode(profile));

    update();
  }

  /// 设置用户 profile
  Future<void> setProfile(UserProfileModel profile) async {
    _isLogin.value = true;
    _profile(profile);
    Storage().setString(Constants.storageProfile, jsonEncode(profile));
    update();
  }

  /// 更新用户porfile 的某个信息
  Future<void> updateProfileInfo(UserProfileModel profile) async {
    profile = _profile.value.copyWith(
      trueName: profile.trueName,
      mobile: profile.mobile,
      sex: profile.sex,
      profilePicture: profile.profilePicture,
    );
    await UserAPI.updateProfile(profile);
    setProfile(profile);
  }

  /// 注销
  Future<void> logout() async {
    // if (_isLogin.value) await UserAPI.logout(); // 退出登录的接口
    await Storage().remove(Constants.storageToken);
    _profile(UserProfileModel());
    _isLogin.value = false;
    token = '';
  }

  /// 检查是否登录
  // Future<bool> checkIsLogin() async {
  //   if (_isLogin.value == false) {
  //     await Get.offAllNamed(RouteNames.loginRoute);
  //     //跳转到登录界面
  //     return false;
  //   }
  //   return true;
  // }
  bool checkIsLogin() {
    if (_isLogin.value == false) {
      //跳转到登录界面
      return false;
    }
    return true;
  }
}
