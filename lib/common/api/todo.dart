import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:icebery_flutter/common/index.dart';

abstract class TodoAPI {
  static Future<List<EventListItem>> getEventList(
      Map<String, dynamic> data) async {
    data.removeWhere((key, value) => value == null || value == "");
    var response = await HttpRequestService.to.get(
      "/aaa",
      params: data,
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

  static Future<Map<String, dynamic>> getEventListByPage(
      Map<String, dynamic> data) async {
    final jsonData = await rootBundle.loadString('assets/videos/videos.json');
    final List response = json.decode(jsonData);
    List temp = [];
    if (data['type'] == 1) {
      temp = response.sublist(0, 25);
    } else if (data['type'] == 2) {
      temp = response.sublist(25, 50);
    } else if (data['type'] == 3) {
      temp = response.sublist(50, 75);
    } else if (data['type'] == 4) {
      temp = response.sublist(75, 100);
    }
    return {
      "total": temp.length,
      "list": temp,
    };
  }

  static Future<Map<String, dynamic>> getMyVideosByPage(
      Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return {
      "total": 30,
      "list": List.generate(9, (index) => ({"name": index}))
    };
  }

  static Future<List> getComments({required String id}) async {
    final jsonData =
        await rootBundle.loadString('assets/comments/video_id_$id.json');
    final List response = json.decode(jsonData);
    return response;
  }
}
