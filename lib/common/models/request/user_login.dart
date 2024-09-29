class UserLoginRequest {
  String? username;
  String? password;
  String? appCode;

  UserLoginRequest({
    this.username,
    this.password,
    this.appCode,
  });

  UserLoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    appCode = json['appCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['appCode'] = appCode;
    return data;
  }
}
