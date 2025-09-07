import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

typedef OnChanged = void Function(SwitcherState state, bool value);

/// Switcher 仿 IOS 开关组件
///
/// * @author xbaistack
/// * @source B站/抖音/小红书/公众号（@小白栈记）
class Switcher extends StatefulWidget {
  const Switcher({
    super.key,
    this.width,
    this.height,
    this.toggleSize,
    this.padding,
    required this.value,
    this.onChangedFirst = false,
    this.disabled = false,
    this.toggleColor,
    this.trackOnColor,
    this.trackOffColor,
    this.onChanged,
  });

  /// 初始布尔值
  final bool value;

  /// 组件是否是禁用状态
  final bool disabled;

  /// 是否初始化就调用变更函数
  final bool onChangedFirst;

  /// 开关组件的宽度，默认：40。
  final double? width;

  /// 开关组件的高度，默认：22。
  final double? height;

  /// 开关组件中间小圆点指示器的大小，默认：16。
  final double? toggleSize;

  /// 开关组件内部的基础间距，默认：2.0。
  final double? padding;

  /// 开关打开时在开关上使用的颜色，默认：绿色（[Colors.green]）。

  final Color? trackOnColor;

  /// 开关关闭时在开关上使用的颜色，默认：浅灰色。
  final Color? trackOffColor;

  /// 开关切换组件上切换器的颜色，默认：白色（[Colors.white]）。

  final Color? toggleColor;

  /// 开关组件切换的回调，如传入此函数，则需手动调用组件的切换动作，否则组件将看不到任何变化。
  ///
  /// ```dart
  /// Switcher(
  ///  ...,
  ///  onChanged: (state, value) {
  ///    print("Value is: $value");
  ///
  ///     state.toggle(value);
  ///  }
  /// );
  /// ```
  final OnChanged? onChanged;

  @override
  State<Switcher> createState() => SwitcherState();
}

class SwitcherState extends State<Switcher> {
  late bool _value;
  Widget? _icon;
  ProgressIndicator? _progress;

  @override
  void initState() {
    super.initState();
    _value = widget.value;

    if (widget.onChangedFirst) {
      widget.onChanged!.call(this, _value);
    }
  }

  @override
  void didUpdateWidget(covariant Switcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      _value = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      showOnOff: false,
      valueFontSize: 16,
      value: _value,
      width: widget.width ?? 40,
      height: widget.height ?? 22,
      disabled: widget.disabled || _icon != null,
      activeIcon: _icon,
      inactiveIcon: _icon,
      toggleSize: widget.toggleSize ?? 16.0,
      borderRadius: widget.width ?? 40,
      padding: widget.padding ?? 2.0,
      toggleColor: widget.toggleColor ?? Colors.white,

      activeColor: widget.trackOnColor ?? Colors.green,

      inactiveColor: widget.trackOffColor ?? const Color(0xFFE0E0E0),
      onToggle: (value) {
        if (!widget.disabled) {
          if (widget.onChanged == null) {
            toggle(value);
          } else {
            widget.onChanged!.call(this, value);
          }
        }
      },
    );
  }

  void finished(bool value) {
    super.setState(() {
      _icon = null;
      _value = value;
    });
  }

  void toggle(bool value) {
    super.setState(() => _value = value);
  }

  void loading() {
    _progress ??= CircularProgressIndicator(
      strokeWidth: 10,
      valueColor: AlwaysStoppedAnimation(widget.trackOnColor),
    );
    super.setState(() => _icon = _progress);
  }
}
