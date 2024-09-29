import 'package:intl/intl.dart';

class Unit {
  static String formatNumber(int num) {
    if (num > 100000000) {
      return '${(num / 100000000).toStringAsFixed(1)}亿';
    } else if (num > 10000) {
      return '${(num / 10000).toStringAsFixed(1)}万';
    } else {
      return '$num';
    }
  }

  static String formatTime(int time) {
    int now = DateTime.now().toUtc().millisecondsSinceEpoch;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    int d = now - time * 1000;
    String str = '';
    if (d < 1000 * 60) {
      str = '刚刚';
    } else if (d < 1000 * 60 * 60) {
      str = str = '${(d / (1000 * 60)).toStringAsFixed(0)}分钟前';
    } else if (d < 1000 * 60 * 60 * 24) {
      str = '${(d / (1000 * 60 * 60)).toStringAsFixed(0)}小时前';
    } else if (d < 1000 * 60 * 60 * 24 * 2) {
      str = '1天前';
    } else if (d < 1000 * 60 * 60 * 24 * 3) {
      str = '2天前';
    } else if (d < 1000 * 60 * 60 * 24 * 4) {
      str = '3天前';
    } else if (DateTime.fromMillisecondsSinceEpoch(now).year == date.year) {
      str = DateFormat('MM-dd').format(date);
    } else {
      str = DateFormat('yyyy-MM-dd').format(date);
    }
    return str;
  }
}
