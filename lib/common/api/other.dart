import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tiktok/common/index.dart';

abstract class OtherAPI {
  static Future<List<EventListItem>> getPlatformInfo() async {
    var response = await HttpRequestService.to.get(
      "/aaa",
    );

    if (response.data['body'] != null) {
      List<EventListItem> list = [];
      for (var item in response.data["body"]) {
        EventListItem model = EventListItem.fromJson(item);
        list.add(model);
      }
      return list;
    }

    return [];
  }

  static Future<dynamic> getVersionInfo(Map<String, dynamic> data) async {
    data.removeWhere((key, value) => value == null || value == "");
    var response = await HttpRequestService.to.get(
      "/aaa",
      params: data,
    );

    if (response.data['body'] != null) {
      return {};
    }

    return {};
  }
}
