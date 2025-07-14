part of 'index.dart';

abstract class _ThemeData<T extends ThemeExtension<T>>
    extends ThemeExtension<T> {
  Color get themeColor => _define('themeColor');
  Color get textColor => _define('textColor');
  Color get textColor2 => _define('textColor2');
  Color get textColor70 => _define('textColor70');
  Color get iconColor => _define('iconColor');
  Color get appBarIconColor => _define('appBarIconColor');
  Color get bottomNavigationBarColor => _define('bottomNavigationBarColor');
  Color get bottomNavigationBarColor70 => _define('bottomNavigationBarColor70');
  Color get tagBackgroundColor => _define('tagBackgroundColor');
  Color get tagTextColor => _define('tagTextColor');
  Color get buttonBackgroundColor => _define('buttonBackgroundColor');
  Color get fillColor => _define('fillColor');
  Color get drawerBackgroundColor => _define('drawerBackgroundColor');
  Color get cardBackgroundColor => _define('cardBackgroundColor');
  Color get shareFontColor => _define('shareFontColor');
  Color get shareIconColor => _define('shareIconColor');

  static dynamic mapOf(Map<String, dynamic> map, String key) {
    var value = map[key];
    if (value != null && value is String && value.startsWith('ref:')) {
      return mapOf(map, value.substring(4));
    }
    return value;
  }

  final Map<String, dynamic> _defines;

  dynamic _define(String key) => mapOf(_defines, key);

  _ThemeData(this._defines);
}
