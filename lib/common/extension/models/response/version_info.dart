class VersionInfoModel {
  Version? iOS;
  Version? android;
  Version? client;

  VersionInfoModel({this.iOS, this.android, this.client});

  VersionInfoModel.fromJson(Map<String, dynamic> json) {
    iOS = json['iOS'] != null ? Version.fromJson(json['iOS']) : null;
    android =
        json['android'] != null ? Version.fromJson(json['android']) : null;
    client = json['client'] != null ? Version.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (iOS != null) {
      data['iOS'] = iOS!.toJson();
    }
    if (android != null) {
      data['android'] = android!.toJson();
    }
    if (client != null) {
      data['client'] = client!.toJson();
    }
    return data;
  }
}

class Version {
  String? version;
  String? path;
  String? keyseries;

  Version({
    this.version,
    this.path,
    this.keyseries,
  });

  Version.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    path = json['path'];
    keyseries = json['keyseries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['path'] = path;
    data['keyseries'] = keyseries;
    return data;
  }
}
