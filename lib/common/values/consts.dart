import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tiktok/common/models/regional.dart';

final class Consts {
  static late final List<Regional> regional;

  static Future<void> ensureInitialized() async {
    final data = await rootBundle.loadString("assets/city.json");
    final items = jsonDecode(data) as List<dynamic>;
    regional = items.map((e) => Regional.fromJson(e)).toList();
  }
}
