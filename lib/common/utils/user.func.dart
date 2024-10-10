import 'package:icebery_flutter/common/index.dart';

class UserFunc {
  static String jumpRouteName() {
    /**
     * 处理业务：
     * .主页面 （是否有用户信息）
     * （1）登录页
     * （2）首页
     */
    if (UserService.to.checkIsLogin()) {
      return RouteNames.mainRoute;
    } else {
      return RouteNames.loginRoute;
    }
  }
}
