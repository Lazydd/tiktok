part of theme;

const String _DATA_KEY = "system.theme";

final class ThemeProvider with ChangeNotifier {
  bool _initialized = false;
  late ThemeMode _mode;

  late AppTheme? _light;
  late AppTheme? _dark;

  ThemeMode get mode => _mode;
  AppTheme? get light => _light;
  AppTheme? get dark => _dark;

  bool get isFollowSystem => _mode == ThemeMode.system;

  ThemeProvider ensureInitialized() {
    if (!_initialized) {
      final enumIndex = Storage().getInt(_DATA_KEY);
      _mode = ThemeMode.values[enumIndex];
      _initThem();
      _initialized = true;
    }
    return this;
  }

  AppTheme currentOf(BuildContext context) {
    if (isFollowSystem) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark
          ? _dark!
          : _light!;
    }
    return (_dark ?? _light)!;
  }

  void refresh() => notifyListeners();

  void saveMode(ThemeMode mode) {
    _mode = mode;
    Storage().setInt(_DATA_KEY, mode.index);
    _initThem();
    notifyListeners();
  }

  void _initThem() {
    switch (_mode) {
      case ThemeMode.light:
        _light = AppTheme.light();
        _dark = null;
        break;
      case ThemeMode.dark:
        _light = null;
        _dark = AppTheme.dark();
        break;
      case ThemeMode.system:
        _light = AppTheme.light();
        _dark = AppTheme.dark();
        break;
    }
  }
}
