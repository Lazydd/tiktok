part of 'index.dart';

final class AppTheme extends _ThemeData<AppTheme> {
  late final ThemeData data;
  late final ColorScheme scheme;
  final Brightness _brightness;

  static final Map<Brightness, AppTheme> _cache = {};

  static StrutStyle structStyle = const StrutStyle();
  static ScrollPhysics physics = const BouncingScrollPhysics();

  AppTheme._({
    required Brightness brightness,
    required Map<String, dynamic> defines,
  }) : _brightness = brightness,
       super(defines) {
    data = _createThemeOf();
    scheme = data.colorScheme;
  }

  factory AppTheme.dark() {
    return _cache.putIfAbsent(
      Brightness.dark,
      () => AppTheme._(brightness: Brightness.dark, defines: _darkThemes_),
    );
  }
  factory AppTheme.light() {
    return _cache.putIfAbsent(
      Brightness.light,
      () => AppTheme._(brightness: Brightness.light, defines: _lightThemes_),
    );
  }

  @override
  AppTheme copyWith() {
    return AppTheme._(brightness: _brightness, defines: _defines);
  }

  @override
  ThemeExtension<AppTheme> lerp(covariant AppTheme other, double t) {
    return AppTheme._(brightness: other._brightness, defines: other._defines);
  }

  static AppTheme of(BuildContext context) {
    try {
      final theme = Theme.of(context).extension<AppTheme>();
      return theme ?? context.read<ThemeProvider>().currentOf(context);
    } catch (e) {
      return AppTheme.dark();
    }
  }

  ThemeData _createThemeOf() {
    final isDark = _brightness == Brightness.dark;
    final schema = isDark
        ? const ColorScheme.dark()
        : const ColorScheme.light();
    return ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      colorScheme: schema.copyWith(surface: themeColor),
      useMaterial3: true,
      appBarTheme: const AppBarTheme().copyWith(
        color: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(color: appBarIconColor, fontSize: 24),
        iconTheme: IconThemeData(color: appBarIconColor),
      ),
      tabBarTheme: TabBarThemeData(
        dividerColor: Colors.transparent,
        labelColor: textColor,
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: textColor70,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
        unselectedItemColor: bottomNavigationBarColor70,
        selectedItemColor: bottomNavigationBarColor,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
