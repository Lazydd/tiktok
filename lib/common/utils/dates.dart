import 'package:intl/intl.dart';

class Dates {
  Dates._();

  static int timestamp() => DateTime.now().millisecondsSinceEpoch;

  static String? format(String pattern, DateTime? time) {
    if (time == null) return null;
    return DateFormat(pattern, Intl.getCurrentLocale()).format(time);
  }
}
