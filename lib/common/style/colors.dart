import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 应用颜色
class AppColors {
  /// *******************************************
  /// 自定义 颜色
  /// *******************************************

  static Color get text_1 => const Color(0xFFFFFFFF);
  static Color get text_2 => const Color(0xFF919191);
  static Color get text_3 => const Color(0xff615F5F);

  /// 强调
  static Color get highlight =>
      Get.isDarkMode ? const Color(0xFFFFB4A9) : const Color(0xFFF77866);

  /// Success
  static Color get success => const Color(0xFF23A757);

  /// Warning
  static Color get warning => const Color(0xFFE6A23C);

  /// Danger
  static Color get danger => const Color(0xFFF56C6C);

  /// Info
  static Color get info => const Color(0xFF909399);

  /// *******************************************
  /// Material System
  /// *******************************************

  static Color get background => Get.theme.colorScheme.surface;

  static Brightness get brightness => Get.theme.colorScheme.brightness;

  static Color get error => Get.theme.colorScheme.error;

  static Color get errorContainer => Get.theme.colorScheme.errorContainer;

  static Color get inversePrimary => Get.theme.colorScheme.inversePrimary;

  static Color get inverseSurface => Get.theme.colorScheme.inverseSurface;

  static Color get onBackground => Get.theme.colorScheme.onSurface;

  static Color get onError => Get.theme.colorScheme.onError;

  static Color get onErrorContainer => Get.theme.colorScheme.onErrorContainer;

  static Color get onInverseSurface => Get.theme.colorScheme.onInverseSurface;

  static Color get onPrimary => Get.theme.colorScheme.onPrimary;

  static Color get onPrimaryContainer =>
      Get.theme.colorScheme.onPrimaryContainer;

  static Color get onSecondary => Get.theme.colorScheme.onSecondary;

  static Color get onSecondaryContainer =>
      Get.theme.colorScheme.onSecondaryContainer;

  static Color get onSurface => Get.theme.colorScheme.onSurface;

  static Color get onSurfaceVariant => Get.theme.colorScheme.onSurfaceVariant;

  static Color get onTertiary => Get.theme.colorScheme.onTertiary;

  static Color get onTertiaryContainer =>
      Get.theme.colorScheme.onTertiaryContainer;

  static Color get outline => Get.theme.colorScheme.outline;

  static Color get primary => Get.theme.colorScheme.primary;

  static Color get primaryContainer => Get.theme.colorScheme.primaryContainer;

  static Color get secondary => Get.theme.colorScheme.secondary;

  static Color get secondaryContainer =>
      Get.theme.colorScheme.secondaryContainer;

  static Color get shadow => Get.theme.colorScheme.shadow;

  static Color get surface => Get.theme.colorScheme.surface;

  static Color get surfaceVariant =>
      Get.theme.colorScheme.surfaceContainerHighest;

  static Color get tertiary => Get.theme.colorScheme.tertiary;

  static Color get tertiaryContainer => Get.theme.colorScheme.tertiaryContainer;

  /// *******************************************
  /// Other color
  /// *******************************************

  static Color get lightFontColor => const Color.fromRGBO(80, 80, 80, 1);

  static Color get bgColor => const Color.fromRGBO(242, 242, 246, 1);

  static Color get randomColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
