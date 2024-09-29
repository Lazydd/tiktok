class UserProfileModel {
  bool? admin;
  String? appCode;
  String? appVersion;
  String? clientIp;
  String? email;
  bool? hasLower;
  String? id;
  String? idCardNo;
  String? lastLoginIp;
  List<LowerGroups>? lowerGroups;
  String? mobile;
  String? nickname;
  String? profilePicture;
  bool? resetPassword;
  String? sex;
  List<SystemAuthInfos>? systemAuthInfos;
  String? trueName;
  List<UserGroupAreas>? userGroupAreas;
  List<UserGroupChannels>? userGroupChannels;
  List<UserGroupDeviceTreeNodes>? userGroupDeviceTreeNodes;
  List<UserGroupResources>? userGroupResources;
  List<UserGroups>? userGroups;
  String? userName;
  List<UserRoles>? userRoles;
  int? userType;

  UserProfileModel(
      {this.admin,
      this.appCode,
      this.appVersion,
      this.clientIp,
      this.email,
      this.hasLower,
      this.id,
      this.idCardNo,
      this.lastLoginIp,
      this.lowerGroups,
      this.mobile,
      this.nickname,
      this.profilePicture,
      this.resetPassword,
      this.sex,
      this.systemAuthInfos,
      this.trueName,
      this.userGroupAreas,
      this.userGroupChannels,
      this.userGroupDeviceTreeNodes,
      this.userGroupResources,
      this.userGroups,
      this.userName,
      this.userRoles,
      this.userType});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    appCode = json['appCode'];
    appVersion = json['appVersion'];
    clientIp = json['clientIp'];
    email = json['email'];
    hasLower = json['hasLower'];
    id = json['id'];
    idCardNo = json['idCardNo'];
    lastLoginIp = json['lastLoginIp'];
    if (json['lowerGroups'] != null) {
      lowerGroups = <LowerGroups>[];
      json['lowerGroups'].forEach((v) {
        lowerGroups!.add(LowerGroups.fromJson(v));
      });
    }
    mobile = json['mobile'];
    nickname = json['nickname'];
    profilePicture = json['profilePicture'];
    resetPassword = json['resetPassword'];
    sex = json['sex'];
    if (json['systemAuthInfos'] != null) {
      systemAuthInfos = <SystemAuthInfos>[];
      json['systemAuthInfos'].forEach((v) {
        systemAuthInfos!.add(SystemAuthInfos.fromJson(v));
      });
    }
    trueName = json['trueName'];
    if (json['userGroupAreas'] != null) {
      userGroupAreas = <UserGroupAreas>[];
      json['userGroupAreas'].forEach((v) {
        userGroupAreas!.add(UserGroupAreas.fromJson(v));
      });
    }
    if (json['userGroupChannels'] != null) {
      userGroupChannels = <UserGroupChannels>[];
      json['userGroupChannels'].forEach((v) {
        userGroupChannels!.add(UserGroupChannels.fromJson(v));
      });
    }
    if (json['userGroupDeviceTreeNodes'] != null) {
      userGroupDeviceTreeNodes = <UserGroupDeviceTreeNodes>[];
      json['userGroupDeviceTreeNodes'].forEach((v) {
        userGroupDeviceTreeNodes!.add(UserGroupDeviceTreeNodes.fromJson(v));
      });
    }
    if (json['userGroupResources'] != null) {
      userGroupResources = <UserGroupResources>[];
      json['userGroupResources'].forEach((v) {
        userGroupResources!.add(UserGroupResources.fromJson(v));
      });
    }
    if (json['userGroups'] != null) {
      userGroups = <UserGroups>[];
      json['userGroups'].forEach((v) {
        userGroups!.add(UserGroups.fromJson(v));
      });
    }
    userName = json['userName'];
    if (json['userRoles'] != null) {
      userRoles = <UserRoles>[];
      json['userRoles'].forEach((v) {
        userRoles!.add(UserRoles.fromJson(v));
      });
    }
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admin'] = admin;
    data['appCode'] = appCode;
    data['appVersion'] = appVersion;
    data['clientIp'] = clientIp;
    data['email'] = email;
    data['hasLower'] = hasLower;
    data['id'] = id;
    data['idCardNo'] = idCardNo;
    data['lastLoginIp'] = lastLoginIp;
    if (lowerGroups != null) {
      data['lowerGroups'] = lowerGroups!.map((v) => v.toJson()).toList();
    }
    data['mobile'] = mobile;
    data['nickname'] = nickname;
    data['profilePicture'] = profilePicture;
    data['resetPassword'] = resetPassword;
    data['sex'] = sex;
    if (systemAuthInfos != null) {
      data['systemAuthInfos'] =
          systemAuthInfos!.map((v) => v.toJson()).toList();
    }
    data['trueName'] = trueName;
    if (userGroupAreas != null) {
      data['userGroupAreas'] = userGroupAreas!.map((v) => v.toJson()).toList();
    }
    if (userGroupChannels != null) {
      data['userGroupChannels'] =
          userGroupChannels!.map((v) => v.toJson()).toList();
    }
    if (userGroupDeviceTreeNodes != null) {
      data['userGroupDeviceTreeNodes'] =
          userGroupDeviceTreeNodes!.map((v) => v.toJson()).toList();
    }
    if (userGroupResources != null) {
      data['userGroupResources'] =
          userGroupResources!.map((v) => v.toJson()).toList();
    }
    if (userGroups != null) {
      data['userGroups'] = userGroups!.map((v) => v.toJson()).toList();
    }
    data['userName'] = userName;
    if (userRoles != null) {
      data['userRoles'] = userRoles!.map((v) => v.toJson()).toList();
    }
    data['userType'] = userType;
    return data;
  }

  UserProfileModel copyWith({
    bool? admin,
    String? appCode,
    String? appVersion,
    String? clientIp,
    String? email,
    String? id,
    String? idCardNo,
    String? lastLoginIp,
    String? mobile,
    String? nickname,
    String? profilePicture,
    bool? resetPassword,
    String? sex,
    String? trueName,
    String? userName,
    int? userType,
    bool? hasLower,
    List<SystemAuthInfos>? systemAuthInfos,
    List<UserGroupAreas>? userGroupAreas,
    List<UserGroupChannels>? userGroupChannels,
    List<UserGroupDeviceTreeNodes>? userGroupDeviceTreeNodes,
    List<UserGroupResources>? userGroupResources,
    List<UserGroups>? userGroups,
    List<UserRoles>? userRoles,
    List<LowerGroups>? lowerGroups,
  }) =>
      UserProfileModel(
        admin: admin ?? this.admin,
        appCode: appCode ?? this.appCode,
        appVersion: appVersion ?? this.appVersion,
        clientIp: clientIp ?? this.clientIp,
        email: email ?? this.email,
        id: id ?? this.id,
        idCardNo: idCardNo ?? this.idCardNo,
        lastLoginIp: lastLoginIp ?? this.lastLoginIp,
        mobile: mobile ?? this.mobile,
        nickname: nickname ?? this.nickname,
        profilePicture: profilePicture ?? this.profilePicture,
        resetPassword: resetPassword ?? this.resetPassword,
        sex: sex ?? this.sex,
        trueName: trueName ?? this.trueName,
        userName: userName ?? this.userName,
        userType: userType ?? this.userType,
        hasLower: hasLower ?? this.hasLower,
        systemAuthInfos: systemAuthInfos ?? this.systemAuthInfos,
        userGroupAreas: userGroupAreas ?? this.userGroupAreas,
        userGroupChannels: userGroupChannels ?? this.userGroupChannels,
        userGroupDeviceTreeNodes:
            userGroupDeviceTreeNodes ?? this.userGroupDeviceTreeNodes,
        userGroupResources: userGroupResources ?? this.userGroupResources,
        userGroups: userGroups ?? this.userGroups,
        userRoles: userRoles ?? this.userRoles,
        lowerGroups: lowerGroups ?? this.lowerGroups,
      );
}

class LowerGroups {
  String? groupDesc;
  String? groupName;
  String? id;
  bool? isSupervisionGroup;
  String? parentId;

  LowerGroups(
      {this.groupDesc,
      this.groupName,
      this.id,
      this.isSupervisionGroup,
      this.parentId});

  LowerGroups.fromJson(Map<String, dynamic> json) {
    groupDesc = json['groupDesc'];
    groupName = json['groupName'];
    id = json['id'];
    isSupervisionGroup = json['isSupervisionGroup'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupDesc'] = groupDesc;
    data['groupName'] = groupName;
    data['id'] = id;
    data['isSupervisionGroup'] = isSupervisionGroup;
    data['parentId'] = parentId;
    return data;
  }
}

class SystemAuthInfos {
  String? expired;
  String? licenseType;
  int? maxAccess;
  String? product;
  String? version;

  SystemAuthInfos(
      {this.expired,
      this.licenseType,
      this.maxAccess,
      this.product,
      this.version});

  SystemAuthInfos.fromJson(Map<String, dynamic> json) {
    expired = json['expired'];
    licenseType = json['licenseType'];
    maxAccess = json['maxAccess'];
    product = json['product'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expired'] = expired;
    data['licenseType'] = licenseType;
    data['maxAccess'] = maxAccess;
    data['product'] = product;
    data['version'] = version;
    return data;
  }
}

class UserGroupAreas {
  String? areaId;
  String? userGroupId;

  UserGroupAreas({this.areaId, this.userGroupId});

  UserGroupAreas.fromJson(Map<String, dynamic> json) {
    areaId = json['areaId'];
    userGroupId = json['userGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['areaId'] = areaId;
    data['userGroupId'] = userGroupId;
    return data;
  }
}

class UserGroupChannels {
  String? channelCode;
  String? userGroupId;

  UserGroupChannels({this.channelCode, this.userGroupId});

  UserGroupChannels.fromJson(Map<String, dynamic> json) {
    channelCode = json['channelCode'];
    userGroupId = json['userGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channelCode'] = channelCode;
    data['userGroupId'] = userGroupId;
    return data;
  }
}

class UserGroupDeviceTreeNodes {
  String? deviceTreeNodeId;
  String? userGroupId;

  UserGroupDeviceTreeNodes({this.deviceTreeNodeId, this.userGroupId});

  UserGroupDeviceTreeNodes.fromJson(Map<String, dynamic> json) {
    deviceTreeNodeId = json['deviceTreeNodeId'];
    userGroupId = json['userGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceTreeNodeId'] = deviceTreeNodeId;
    data['userGroupId'] = userGroupId;
    return data;
  }
}

class UserGroupResources {
  String? nodeId;
  String? userGroupId;

  UserGroupResources({this.nodeId, this.userGroupId});

  UserGroupResources.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    userGroupId = json['userGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nodeId'] = nodeId;
    data['userGroupId'] = userGroupId;
    return data;
  }
}

class UserGroups {
  String? groupDesc;
  String? groupName;
  String? id;
  String? parentId;
  bool? isSupervisionGroup;

  UserGroups(
      {this.groupDesc,
      this.groupName,
      this.id,
      this.parentId,
      this.isSupervisionGroup});

  UserGroups.fromJson(Map<String, dynamic> json) {
    groupDesc = json['groupDesc'];
    groupName = json['groupName'];
    id = json['id'];
    parentId = json['parentId'];
    isSupervisionGroup = json['isSupervisionGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupDesc'] = groupDesc;
    data['groupName'] = groupName;
    data['id'] = id;
    data['parentId'] = parentId;
    return data;
  }
}

class UserRoles {
  String? id;
  String? parentId;
  String? roleDesc;
  String? roleName;
  String? roleSign;

  UserRoles(
      {this.id, this.parentId, this.roleDesc, this.roleName, this.roleSign});

  UserRoles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parentId'];
    roleDesc = json['roleDesc'];
    roleName = json['roleName'];
    roleSign = json['roleSign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parentId'] = parentId;
    data['roleDesc'] = roleDesc;
    data['roleName'] = roleName;
    data['roleSign'] = roleSign;
    return data;
  }
}
