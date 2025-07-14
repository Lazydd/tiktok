import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok/common/index.dart';

/// cell group
class CustomCellGroup extends StatelessWidget {
  final List<Widget> children;
  final double? minHeight;
  final bool showDivider;

  const CustomCellGroup({
    super.key,
    this.children = const [],
    this.minHeight,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final cellLists = <Widget>[];
    for (var index = 0; index < children.length; index++) {
      if (index != 0 && showDivider) cellLists.add(Divider(height: 1.w));
      cellLists.add(
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight ?? 64.w),
          child: children[index],
        ),
      );
    }
    return cellLists
        .toColumn(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        )
        .padding(left: 15.w, right: 15.w);
  }
}

class CustomCell extends StatelessWidget {
  /// 标题
  final Widget title;

  /// 副标题
  final Widget? subtitle;

  /// 图标路径 svg
  final String? iconPath;

  /// 图标颜色
  final Color? iconColor;

  /// 图标大小
  final double? iconSize;

  /// value值【用于回显】
  final Widget? value;

  ///是否需要右侧箭头
  final bool? showArrow;

  /// value值宽度
  final double? valueWidth;

  /// 标题样式
  final TextStyle? titleStyle;

  /// value值样式
  final TextStyle? valueStyle;

  /// padding
  final EdgeInsets? padding;

  /// 自定义cell头部组件
  final Widget? leading;

  /// 自定义cell尾部组件
  final Widget? trailing;

  /// 是否需要底部分割线
  final bool? showCellDivider;
  final void Function()? onTap;

  final void Function()? onArrowTap;

  const CustomCell({
    super.key,
    required this.title,
    this.subtitle,
    this.iconPath,
    this.iconColor,
    this.iconSize,
    this.value,
    this.showArrow,
    this.valueWidth,
    this.onTap,
    this.onArrowTap,
    this.titleStyle,
    this.valueStyle,
    this.padding,
    this.leading,
    this.trailing,
    this.showCellDivider = false,
  });

  /// 简单的cell风格
  factory CustomCell.simple({
    Key? key,
    required Widget title,
    Widget? value,
    EdgeInsets? padding,
  }) = _CellWithSimple;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cellItems = <Widget>[];
    if (iconPath != null) {
      // 图标
      cellItems.add(
        IconTheme(
          data: IconThemeData(color: colorScheme.primary, size: 26.w),
          child: IconWidget.svg(
            iconPath!,
            color: iconColor ?? AppColors.primary,
            size: iconSize ?? 24.w,
          ),
        ),
      );
      // 图标和标题间的间隔
      cellItems.add(SizedBox(width: 15.w));
    }
    // 左侧组件
    if (leading != null) {
      // cellItems.add(SizedBox(width: 8.w));
      cellItems.add(leading!);
      // 图标和标题间的间隔
      cellItems.add(SizedBox(width: 15.w));
    }
    // 标题
    cellItems.add(
      Expanded(
        // 文本的样式默认是可以被继承
        child:
            <Widget>[
              DefaultTextStyle.merge(
                child: title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.w),
              ).translate(offset: const Offset(0, 0)),
              // 副标题
              if (subtitle != null)
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: DefaultTextStyle.merge(
                    child: subtitle!,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 15.w,
                    ),
                  ),
                ),
            ].toColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
      ),
    );

    // 值value
    if (value != null) {
      cellItems.add(SizedBox(width: 12.w));
      cellItems.add(
        Container(
          constraints: BoxConstraints(maxWidth: valueWidth ?? double.infinity),
          alignment: Alignment.centerRight,
          child: DefaultTextStyle.merge(
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16.w,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ).merge(valueStyle),
            child: value!,
          ),
        ),
      );
    }
    // 右侧组件
    if (trailing != null) {
      cellItems.add(SizedBox(width: 8.w));
      cellItems.add(trailing!);
    }

    // 点击事件以及箭头
    if (onTap != null && showArrow != false) {
      cellItems.add(SizedBox(width: 8.w));
      cellItems.add(
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16.w,
          color: Colors.grey,
        ).onTap(() {
          if (onArrowTap != null) {
            onArrowTap!();
          } else {
            onTap!();
          }
        }),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: padding ?? EdgeInsets.symmetric(vertical: 15.w),
            child: cellItems.toRow(
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          if (showCellDivider == true)
            Divider(height: 1.w).paddingHorizontal(10.w),
        ],
      ),
    );
  }
}

class _CellWithSimple extends CustomCell {
  _CellWithSimple({super.key, required super.title, super.value, super.padding})
    : super(
        titleStyle: TextStyle(fontSize: 18.w),
        valueStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          fontSize: 18.w,
        ),
      );
}
