part of mine;

class MineController extends GetxController {
  MineController();

  bool isPasswordVisible = true;

  void changeVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update(["mine"]);
  }

  GlobalKey userformKey = GlobalKey<FormState>();

  onAccountValidator() {
    return Validdator.multiple([
      Validdator.required("请输入你的手机号"),
      Validdator.phone("请输入正确的手机号"),
    ]);
  }

  onPasswordValidator() {
    return Validdator.multiple([
      Validdator.required("请输入你的密码"),
      Validdator.min(6, "密码至少需要6位数字、字母或字符"),
      Validdator.max(20, "密码最多20位数字、字母或字符"),
    ]);
  }

  Future<void> onSignIn() async {
    if ((userformKey.currentState as FormState).validate()) {
      try {
        Loading.show(
          text: "登录中，请稍后...",
          indicatorColor: Colors.blue,
        );
        await Future.delayed(const Duration(milliseconds: 500));
        Loading.success(text: "登录成功！");
      } finally {
        await Loading.dismiss();
      }
    }
  }

  _initData() {
    update(["mine"]);
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
}
