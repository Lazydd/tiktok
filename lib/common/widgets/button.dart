import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../index.dart';

enum ButtonWidgetType {
  none, // 无
  primary, // 主按钮
  secondary, // 次按钮
  text, // 文字按钮
  icon, // 图标按钮
  textFilled, // 文字/填充
  textRoundFilled, // 文字/填充/圆形
  iconTextUpDown, // 图标/文字/上下
  iconTextOutlined, // 图标/文字/边框
  iconTextUpDownOutlined, // 图标/文字/上下/边框
  textIcon, // 文字/图标
}

/// 按钮
class ButtonWidget extends StatelessWidget {
  /// 按钮类型
  final ButtonWidgetType type;

  /// tap 事件
  final Function()? onTap;

  /// 文字字符串
  final String? text;

  /// 子组件
  final Widget? child;

  /// 图标
  final Widget? icon;

  /// 圆角
  final double? borderRadius;

  /// 背景色
  final Color? backgroundColor;

  /// 边框色
  final Color? borderColor;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  const ButtonWidget({
    super.key,
    this.type = ButtonWidgetType.none,
    this.onTap,
    this.text,
    this.borderRadius,
    this.child,
    this.backgroundColor,
    this.icon,
    this.borderColor,
    this.width,
    this.height,
  });

  /// 主要
  const ButtonWidget.primary(
    this.text, {
    super.key,
    this.type = ButtonWidgetType.primary,
    this.width = double.infinity,
    this.height = 55,
    this.onTap,
    this.borderRadius,
    this.child,
    this.backgroundColor,
    this.icon,
    this.borderColor,
  });

  /// 次要
  const ButtonWidget.secondary(
    this.text, {
    super.key,
    this.type = ButtonWidgetType.secondary,
    this.width = double.infinity,
    this.height = 55,
    this.onTap,
    this.borderRadius,
    this.child,
    this.backgroundColor,
    this.icon,
    this.borderColor,
  });

  /// 文字
  ButtonWidget.text(
    this.text, {
    super.key,
    this.type = ButtonWidgetType.text,
    this.onTap,
    Color? textColor,
    double? textSize,
    FontWeight? textWeight,
    this.borderRadius,
    this.backgroundColor,
    this.icon,
    this.borderColor,
    this.width,
    this.height,
  }) : child = TextWidget.button(
         text: text!,
         size: textSize,
         color: textColor ?? AppColors.onPrimaryContainer,
         weight: textWeight,
       );

  /// 图标
  const ButtonWidget.icon(
    this.icon, {
    super.key,
    this.type = ButtonWidgetType.icon,
    this.onTap,
    this.text,
    this.borderRadius,
    this.backgroundColor,
    this.child,
    this.borderColor,
    this.width,
    this.height,
  });

  /// 文字/填充
  ButtonWidget.textFilled(
    this.text, {
    super.key,
    this.type = ButtonWidgetType.textFilled,
    Color? bgColor,
    Color? textColor,
    double? textSize,
    FontWeight? textWeight,
    this.onTap,
    this.borderRadius,
    this.icon,
    this.borderColor,
    this.width,
    this.height,
  }) : backgroundColor = bgColor ?? AppColors.primary,
       child = TextWidget.button(
         text: text!,
         size: textSize,
         color: textColor ?? AppColors.onPrimaryContainer,
         weight: textWeight,
       );

  /// 文字/填充/圆形 按钮
  ButtonWidget.textRoundFilled(
    this.text, {
    super.key,
    this.type = ButtonWidgetType.textRoundFilled,
    Color? bgColor,
    Color? textColor,
    double? textSize,
    FontWeight? textWeight,
    this.onTap,
    this.borderRadius,
    this.icon,
    this.borderColor,
    this.width,
    this.height,
  }) : backgroundColor = bgColor ?? AppColors.primary,
       child = TextWidget.button(
         text: text!,
         size: textSize,
         color: textColor ?? AppColors.onPrimaryContainer,
         weight: textWeight,
       );

  /// 图标文字 上下
  ButtonWidget.iconTextUpDown(
    this.icon,
    this.text, {
    super.key,
    this.type = ButtonWidgetType.iconTextUpDown,
    Color? textColor,
    double? textSize,
    FontWeight? textWeight,
    this.onTap,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
  }) : child = <Widget>[
         icon!,
         TextWidget.button(
           text: text!,
           size: textSize,
           color: textColor ?? AppColors.onPrimaryContainer,
           weight: textWeight,
         ),
       ].toColumn(mainAxisSize: MainAxisSize.min);

  /// 图标 / 文字 / 边框
  ButtonWidget.iconTextOutlined(
    this.icon,
    this.text, {
    super.key,
    this.type = ButtonWidgetType.iconTextOutlined,
    this.onTap,
    Color? textColor,
    double? textSize,
    FontWeight? textWeight,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
  }) : child = <Widget>[
         icon!,
         TextWidget.button(
           text: text!,
           size: textSize,
           color: textColor ?? AppColors.onPrimaryContainer,
           weight: textWeight,
         ),
       ].toRow(mainAxisSize: MainAxisSize.min);

  /// 图标 / 文字 / 上下 / 边框
  ButtonWidget.iconTextUpDownOutlined(
    this.icon,
    this.text, {
    super.key,
    this.type = ButtonWidgetType.iconTextUpDownOutlined,
    this.onTap,
    Color? textColor,
    double? textSize,
    FontWeight? textWeight,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
  }) : child = <Widget>[
         icon!,
         TextWidget.button(
           text: text!,
           size: textSize,
           color: textColor ?? AppColors.onPrimaryContainer,
           weight: textWeight,
         ),
       ].toColumn(mainAxisSize: MainAxisSize.min);

  /// 文字 / 图标
  ButtonWidget.textIcon(
    this.text,
    this.icon, {
    super.key,
    Color? textColor,
    double? textSize,
    FontWeight? textWeight,
    this.type = ButtonWidgetType.textIcon,
    this.onTap,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
  }) : child = <Widget>[
         icon!,
         TextWidget.button(
           text: text!,
           size: textSize,
           color: textColor ?? AppColors.onPrimaryContainer,
           weight: textWeight,
         ),
       ].toRow(mainAxisSize: MainAxisSize.min);

  // 背景
  WidgetStateProperty<Color?>? get _backgroundColor {
    switch (type) {
      case ButtonWidgetType.primary:
        return WidgetStateProperty.all(backgroundColor ?? AppColors.primary);
      default:
        return WidgetStateProperty.all(backgroundColor ?? Colors.transparent);
    }
  }

  // 边框
  WidgetStateProperty<BorderSide?>? get _side {
    switch (type) {
      case ButtonWidgetType.secondary:
        return WidgetStateProperty.all(
          BorderSide(color: borderColor ?? AppColors.primary, width: 1),
        );
      case ButtonWidgetType.iconTextOutlined:
      case ButtonWidgetType.iconTextUpDownOutlined:
        return WidgetStateProperty.all(
          BorderSide(color: borderColor ?? AppColors.outline, width: 1),
        );
      default:
        return null;
    }
  }

  // 阴影颜色
  WidgetStateProperty<Color?>? get overlayColor {
    switch (type) {
      case ButtonWidgetType.primary:
        return null;
      default:
        return WidgetStateProperty.all(AppColors.surfaceVariant);
    }
  }

  // 形状圆角
  WidgetStateProperty<OutlinedBorder?>? get _shape {
    switch (type) {
      case ButtonWidgetType.primary:
      case ButtonWidgetType.secondary:
        return WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? AppRadius.button),
            ),
          ),
        );
      case ButtonWidgetType.textFilled:
      case ButtonWidgetType.iconTextOutlined:
      case ButtonWidgetType.iconTextUpDownOutlined:
        return WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? AppRadius.buttonTextFilled),
            ),
          ),
        );
      case ButtonWidgetType.textRoundFilled:
        return WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)),
          ),
        );
      default:
        return null;
    }
  }

  // padding
  WidgetStateProperty<EdgeInsetsGeometry?>? get _padding {
    switch (type) {
      // case ButtonWidgetType.primary:
      // case ButtonWidgetType.secondary:
      //   return null;
      default:
        return WidgetStateProperty.all(EdgeInsets.zero);
    }
  }

  // 子元素
  Widget? get _child {
    switch (type) {
      case ButtonWidgetType.primary:
        return TextWidget.button(
          text: text!,
          size: 18,
          color: AppColors.onPrimary,
        );
      case ButtonWidgetType.secondary:
        return TextWidget.button(text: text!, color: AppColors.primary);
      case ButtonWidgetType.icon:
        return icon;
      default:
        return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(0, 0)),
          elevation: WidgetStateProperty.all(0),
          backgroundColor: _backgroundColor,
          side: _side,
          // overlayColor: overlayColor,
          shape: _shape,
          padding: _padding,
          // 去除按钮的水波纹
          overlayColor: WidgetStateProperty.resolveWith((states) {
            return Colors.transparent;
          }),
        ),
        child: _child,
      ),
    );
  }
}

//  ================
enum CustomButtonType { filled, ghost, borderless }

enum CustomButtonSize { large, medium, small }

enum CustomButtonShape { radius, stadium, square }

class CustomButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final CustomButtonType type;
  final CustomButtonSize size;
  final CustomButtonShape shape;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final bool isIcon;

  const CustomButton({
    super.key,
    required this.child,
    this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.type = CustomButtonType.filled,
    this.size = CustomButtonSize.medium,
    this.shape = CustomButtonShape.radius,
    this.width,
    this.height,
    this.fontSize,
    this.padding,
    this.isIcon = false,
  });

  factory CustomButton.icon({
    Key? key,
    required Icon icon,
    void Function()? onPressed,
    Color? foregroundColor,
    Color? backgroundColor,
    CustomButtonShape shape,
    CustomButtonSize size,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
  }) = _ButtonWithIcon;

  OutlinedBorder? get _shape {
    switch (shape) {
      case CustomButtonShape.stadium:
        return const StadiumBorder();
      case CustomButtonShape.radius:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.w));
      case CustomButtonShape.square:
        return const RoundedRectangleBorder(borderRadius: BorderRadius.zero);
    }
  }

  EdgeInsetsGeometry? get _padding {
    switch (size) {
      case CustomButtonSize.large:
        return EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.w);
      case CustomButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.w);
      case CustomButtonSize.small:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w);
    }
  }

  double? get _fontSize {
    switch (size) {
      case CustomButtonSize.large:
        return 18.w;
      case CustomButtonSize.medium:
        return 16.w;
      case CustomButtonSize.small:
        return 14.w;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontSize: fontSize ?? _fontSize),
          ),
          padding: WidgetStateProperty.all(padding ?? _padding),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            switch (type) {
              case CustomButtonType.filled:
                return foregroundColor ??
                    (isIcon ? colorScheme.primary : colorScheme.onPrimary);
              case CustomButtonType.ghost:
              case CustomButtonType.borderless:
                final color = foregroundColor ?? colorScheme.primary;
                final opacity = color.a / 2;
                if (states.contains(WidgetState.pressed)) {
                  return color.withValues(alpha: opacity);
                }
                if (states.contains(WidgetState.disabled)) {
                  return color.withValues(alpha: opacity);
                }
                return color;
            }
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            switch (type) {
              case CustomButtonType.filled:
                final color =
                    backgroundColor ??
                    colorScheme.primary.withValues(alpha: isIcon ? 0.1 : 1);
                final opacity = color.a / 2;
                if (states.contains(WidgetState.pressed)) {
                  return color.withValues(alpha: opacity);
                }
                if (states.contains(WidgetState.disabled)) {
                  return color.withValues(alpha: opacity);
                }
                return color;
              case CustomButtonType.ghost:
              case CustomButtonType.borderless:
                return Colors.transparent;
            }
          }),
          side: WidgetStateProperty.resolveWith((states) {
            switch (type) {
              case CustomButtonType.filled:
              case CustomButtonType.borderless:
                return BorderSide.none;
              case CustomButtonType.ghost:
                final color = foregroundColor ?? colorScheme.primary;
                final opacity = color.a / 2;
                if (states.contains(WidgetState.pressed)) {
                  return BorderSide(
                    color: color.withValues(alpha: opacity),
                    width: 2.w,
                  );
                }
                if (states.contains(WidgetState.disabled)) {
                  return BorderSide(color: color.withValues(alpha: opacity));
                }
                return BorderSide(color: color, width: 2.w);
            }
          }),
          shape: WidgetStateProperty.all(_shape),
        ),
        child: child,
      ),
    );
  }
}

class _ButtonWithIcon extends CustomButton {
  final Icon icon;

  _ButtonWithIcon({
    super.key,
    required this.icon,
    super.onPressed,
    super.foregroundColor,
    Color? backgroundColor,
    super.size,
    super.shape,
    super.width,
    super.height,
    EdgeInsetsGeometry? padding,
  }) : super(
         child: _ButtonWithIconChild(icon: icon, size: size, padding: padding),
         backgroundColor:
             backgroundColor ?? foregroundColor?.withValues(alpha: 0.1),
         isIcon: true,
         padding: padding ?? const EdgeInsets.all(0),
       );
}

class _ButtonWithIconChild extends StatelessWidget {
  final Icon icon;
  final CustomButtonSize size;
  final EdgeInsetsGeometry? padding;

  const _ButtonWithIconChild({
    required this.icon,
    required this.size,
    this.padding,
  });

  double? get _iconSize {
    switch (size) {
      case CustomButtonSize.large:
        return 30.w;
      case CustomButtonSize.medium:
        return 24.w;
      case CustomButtonSize.small:
        return 18.w;
    }
  }

  double get _padding {
    switch (size) {
      case CustomButtonSize.large:
        return 12.w;
      case CustomButtonSize.medium:
        return 10.w;
      case CustomButtonSize.small:
        return 8.w;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == null
          ? EdgeInsets.all(_padding)
          : const EdgeInsets.all(0),
      child: IconTheme.merge(
        data: IconThemeData(size: _iconSize),
        child: icon,
      ),
    );
  }
}
