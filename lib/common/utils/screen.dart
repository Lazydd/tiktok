import 'dart:ui';

import 'package:flutter/material.dart';

class ScreenFunc {
  static MediaQueryData get mediaQuery => MediaQueryData.fromView(
        PlatformDispatcher.instance.views.first,
      );

  /// 获取屏幕宽度 physicalSize.width / devicePixelRatio
  static double get screenWidth => mediaQuery.size.width;

  /// 获取屏幕高度 physicalSize.height / devicePixelRatio
  static double get screenHeight => mediaQuery.size.height;

  /// 设备物理尺寸
  static Size get physicalSize => mediaQuery.size;

  /// 设备像素比例(获取屏幕dp比例) window.devicePixelRatio
  static double get devicePixelRatio => mediaQuery.devicePixelRatio;

  /// 获取顶部安全区域
  static double get statusBar => mediaQuery.padding.top;

  /// 获取底部安全区域
  static double get bottomBar => mediaQuery.padding.bottom;

  /// 获取文本的Size
  static Size boundingTextSize(String text, TextStyle style,
      {int maxLines = 2 ^ 31, double maxWidth = double.infinity}) {
    if (text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: text, style: style),
        maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }
}
