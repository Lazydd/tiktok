import 'package:intl/intl.dart';

class DateFunc {
  ///距离当前的时间——时间格式化
  static String timeLineFormat(DateTime time) {
    var now = DateTime.now();
    var difference = now.difference(time);
    // 1小时内
    if (difference.inMinutes < 60) {
      if (difference.inMinutes < 0) {
        return datetimetoFormatDate(time);
      }
      return "${difference.inMinutes.toString()} 分钟前";
    }
    // 1天内
    if (difference.inHours < 24) {
      return "${difference.inHours.toString()} 小时前";
    }

    // 7天内
    else if (difference.inDays < 7) {
      return "${difference.inDays.toString()} 天前";
    }

    // MM-dd
    else if (difference.inDays < 365) {
      final dayFormat = DateFormat('MM-dd');
      return dayFormat.format(time);
    }

    // yyyy-MM-dd
    else {
      final dayFormat = DateFormat('yyyy-MM-dd');
      var str = dayFormat.format(time);
      return str;
    }
  }

  /// 时间(DateTime)转成格式化【date => format】
  static String datetimetoFormatDate(DateTime time,
      {format = "yyyy-MM-dd HH:mm:ss"}) {
    final dayFormat = DateFormat(format);
    var str = dayFormat.format(time);
    return str;
  }

  ///格式化的日期转时间戳【format => timestamp】
  static int dateToTimestamp(String date, {isMicroseconds = false}) {
    DateTime dateTime = DateTime.parse(date);
    int timestamp = dateTime.millisecondsSinceEpoch;
    if (isMicroseconds) {
      timestamp = dateTime.microsecondsSinceEpoch;
    }
    return timestamp;
  }

  /// 时间戳转时间格式(DateTime)【timestamp => date】
  static DateTime timestampToDate(int timestamp) {
    DateTime dateTime = DateTime.now();

    ///如果是十三位时间戳返回这个
    if (timestamp.toString().length == 13) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    } else if (timestamp.toString().length == 16) {
      ///如果是十六位时间戳
      dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    }
    return dateTime;
  }

  ///时间戳转日期(DateTime) 【timestamp => format】
  ///[timestamp] 时间戳
  ///[onlyNeedDate ] 是否只显示日期 舍去时间
  static String timestampToDateStr(int timestamp, {onlyNeedDate = false}) {
    DateTime dataTime = timestampToDate(timestamp);
    String dateTime = dataTime.toString();

    ///去掉时间后面的.000
    dateTime = dateTime.substring(0, dateTime.length - 4);
    if (onlyNeedDate) {
      List<String> dataList = dateTime.split(" ");
      dateTime = dataList[0];
    }
    return dateTime;
  }

  /// 时间戳/日期格式 转成 DateTime 格式 【timestamp/format => date】
  static DateTime changeTimeDate(time) {
    ///如果传进来的是字符串 13/16位 而且不包含-
    DateTime dateTime = DateTime.now();
    if (time is String) {
      if ((time.length == 13 || time.length == 16) && !time.contains("-")) {
        dateTime = timestampToDate(int.parse(time));
      } else {
        dateTime = DateTime.parse(time);
      }
    } else if (time is int) {
      dateTime = timestampToDate(time);
    }
    return dateTime;
  }

  /// 将时间重置成当天的 00:00:00 的时间
  static DateTime resetZeroTime(DateTime time) {
    //datetime 转成时间戳，然后剔除后缀的时分秒重置成00:00:00
    int timestamp = time.microsecondsSinceEpoch; //1663516800000
    int zeroTimestamp = resetZeroTimestamp(timestamp);
    return DateTime.fromMillisecondsSinceEpoch(zeroTimestamp);
  }

  /// 将当前的时间戳转成00:00:00的时间戳
  static int resetZeroTimestamp(int timestamp) {
    String zeroTimeStr = timestampToDateStr(timestamp, onlyNeedDate: true);
    int zeroTimestamp = dateToTimestamp("$zeroTimeStr 00:00:00");
    return zeroTimestamp;
  }

  /// 将时间重置成当天的 23:59:59 的时间
  static DateTime resetEndTime(DateTime time) {
    //datetime 转成时间戳，然后剔除后缀的时分秒重置成23:59:59
    int timestamp = time.microsecondsSinceEpoch + 86400 - 1; //1663516800000
    int zeroTimestamp = resetEndTimestamp(timestamp);
    return DateTime.fromMillisecondsSinceEpoch(zeroTimestamp);
  }

  /// 将当前的时间戳转成00:00:00的时间戳
  static int resetEndTimestamp(int timestamp) {
    String zeroTimeStr = timestampToDateStr(timestamp, onlyNeedDate: true);
    int zeroTimestamp = dateToTimestamp("$zeroTimeStr 23:59:59");
    return zeroTimestamp;
  }

  /// 判断是否是今天
  static bool isToday(int timestamp) {
    int todayTimestamp =
        resetZeroTimestamp(DateTime.now().microsecondsSinceEpoch);
    if (timestamp == todayTimestamp) {
      return true;
    } else {
      return false;
    }
  }

  /// 一天86400000毫秒
  static int get oneDayTimestamp => 24 * 3600 * 1000;

  /// 将时间戳格式化成时分秒
  static String formatTimestampToClock(int timeStamp) {
    int hour = 0;
    int minute = 0;
    int second = 0;
    hour = (timeStamp ~/ 3600);
    minute = (timeStamp - 3600 * hour) ~/ 60;
    second = timeStamp - 3600 * hour - 60 * minute;
    return "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}";
  }

  /// 日期转成 时 + 分 + 秒，一天内的时间 组成的数组
  static List<int> dateFormateToClockArray(String dateFormat) {
    List clockStrArr = dateFormat.split(":");
    int hours = int.parse(clockStrArr[0]);
    int minutes = int.parse(clockStrArr[1]);
    int seconds = int.parse(clockStrArr[2]);
    int clockTimestamp = hours * 3600 + minutes * 60 + seconds;
    return [hours, minutes, seconds, clockTimestamp];
  }

  /// 将 年月日时分秒 yyyy-MM-dd HH:mm:ss => MM-dd 格式
  static String simplifyDateFormat(String dateFormat) {
    dateFormat = dateFormat.substring(0, dateFormat.length - 9);
    List splitArr = dateFormat.split('-');
    return '${splitArr[1]}-${splitArr[2]}';
  }

  /// 获取今天的格式化时间 yyyy-MM-dd HH:mm:ss
  static String getTodayFormat() {
    DateTime now = DateTime.now();
    String todayFormatStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    return todayFormatStr;
  }
}
