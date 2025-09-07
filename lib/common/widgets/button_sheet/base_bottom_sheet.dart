import 'package:flutter/material.dart';
import 'package:tiktok/common/utils/helper.dart';

abstract class BaseBottomSheet<OUT> {
  final BuildContext context;
  final Color? backgroundColor;
  final double radius;
  final double spacing;
  final bool isDismissible;
  final bool showHeader;
  final bool showFooter;
  final bool showClose;
  final String? title;
  final String? confirmText;

  /// 内容构造组件（一个普通类）
  final BottomSheetWidget<BaseBottomSheet<OUT>> widget;

  late final EdgeInsets padding;

  BaseBottomSheet({
    required this.context,
    required this.widget,
    this.backgroundColor,
    this.radius = 12,
    this.spacing = 14,
    this.isDismissible = true,
    this.showHeader = true,
    this.showFooter = true,
    this.showClose = false,
    this.title,
    this.confirmText,
  }) : padding = EdgeInsets.all(spacing);

  /// 固定设置了一些参数值，其它利用参数进行传递
  Future<OUT?> show() {
    return showModalBottomSheet<OUT>(
      context: context,
      useSafeArea: true,
      useRootNavigator: false,
      enableDrag: isDismissible,
      isDismissible: isDismissible,
      showDragHandle: false,
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,

      backgroundColor: backgroundColor ?? const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      builder: (context) => _InternalContentWidget(this), // 构造内容视图
    );
  }

  /// 关闭底部模态弹窗
  void close() => Navigator.of(context).maybePop();

  /// 点击“确认”关闭弹窗
  void confirm() => Navigator.of(context).maybePop();
}

/// 由于弹窗内部会涉及到数据刷新等操作，
/// 所以这里将其封装成内部私有类去创建视图内容，
/// 然后将具体内容构建委托给 `BottomSheetWidget` 去构造，
/// 这样子类在重写时可以省去一个 `StatefulWidget` 和 `State`；
class _InternalContentWidget<P extends BaseBottomSheet> extends StatefulWidget {
  /// 持有对 `BaseBottomSheet` 的引用,
  /// 主要是为了访问 `BaseBottomSheet` 中的设置属性；
  final P parent;

  const _InternalContentWidget(this.parent, {super.key});

  @override
  State<StatefulWidget> createState() => _InternalContentWidgetState();
}

class _InternalContentWidgetState<P extends BaseBottomSheet>
    extends State<_InternalContentWidget<P>> {
  late P parent = widget.parent;

  @override
  void initState() {
    super.initState();

    parent.widget.parent = parent;

    parent.widget.setState = setState;

    parent.widget.onInitialized();
  }

  @override
  Widget build(BuildContext context) {
    final showHeader = parent.showHeader && Helper.isNotEmpty(parent.title);

    final height = MediaQuery.sizeOf(context).height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showHeader) parent.widget.header(context),
        Container(
          constraints: BoxConstraints(maxHeight: height / 2),
          child: parent.widget.body(context),
        ),
        if (parent.showFooter) parent.widget.footer(context),
      ],
    );
  }
}

/// 底部模态弹窗的抽象 `组件` 构造类，
/// 这是一个普通方法，并非 `StatelessWidget` 或者 `StatefulWidget`，
/// 它主要是收集子类提供的 `header()`/`body()`/`footer()` 方法的返回值，
/// 然后在 `build` 方法中组合成一个完整的视图。
abstract class BottomSheetWidget<P extends BaseBottomSheet> {
  late final P parent;
  late final void Function(VoidCallback) setState;
  final border = const BorderSide(color: Color(0xFFDDDDDD), width: 0.2);

  /// 初始化方法
  void onInitialized() {}

  /// 是否生成底部 `取消` 按钮
  bool hasCancelButton() => false;

  /// 公共的弹窗头部，如果子类没有重写则使用此默认实现。
  Widget header(BuildContext context) {
    Widget content = Container(
      padding: parent.padding,
      color: parent.backgroundColor,
      alignment: Alignment.center,
      child: Text(
        parent.title!,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
    if (parent.showClose) {
      content = Stack(
        alignment: Alignment.center,
        children: [
          content,
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: parent.close,
              child: Padding(
                padding: parent.padding,
                child: const Icon(Icons.cancel, size: 24, color: Colors.grey),
              ),
            ),
          ),
        ],
      );
    }
    return content;
  }

  /// 内容区由具体子类去实现
  Widget body(BuildContext context);

  /// 公共的底部内容，
  /// 根据 `hasCancelButton()` 决定是否生成取消按钮，
  /// 如果方法返回值为 false，则只生成一个 “我选好了” 按钮。
  Widget footer(BuildContext context) {
    final hasCancelBtn = hasCancelButton();

    Widget confirm = GestureDetector(
      onTap: parent.confirm,
      child: Container(
        padding: parent.padding,
        alignment: Alignment.center,
        decoration: hasCancelBtn == null
            ? null
            : BoxDecoration(border: Border(right: border)),
        child: Text(
          parent.confirmText ?? "我选好了",
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );

    if (!hasCancelBtn) return confirm;

    Widget cancel = GestureDetector(
      onTap: parent.confirm,
      child: Container(
        padding: parent.padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border(right: border)),
        child: const Text(
          "取消",
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );

    return Row(
      children: [
        Expanded(flex: 2, child: confirm),
        Expanded(flex: 1, child: cancel),
      ],
    );
  }
}
