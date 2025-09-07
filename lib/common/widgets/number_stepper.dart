import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/common/widgets/input_text.dart';

const _kDuration = Duration(milliseconds: 50);

class NumberStepper extends StatefulWidget {
  /// 数字增长步长，默认为 `1`。
  final int step;

  /// 默认值，不设置的话初始展示最小值inValue]。
  final int? value;

  /// 最小值
  final int minValue;

  /// 最大值
  final int maxValue;

  /// 是否只读，只读模式下只会显示一个数字标签。
  final bool readOnly;

  /// 组件的宽度，不设置的话以父组件宽度为准。
  final double? width;

  /// 输入框的内间距，直接影响组件的整体高度。
  final double? padding;

  /// 值变化监听，每一次值变化都会回调此函数，长按的话只会调用一次。
  final ValueChanged<int>? onChanged;

  final int? initialValue;

  final FocusNode? focusNode;

  const NumberStepper({
    super.key,
    this.value,
    this.step = 1,
    required this.minValue,
    required this.maxValue,
    this.readOnly = false,
    this.width,
    this.padding,
    this.onChanged,
    this.initialValue,
    this.focusNode,
  });

  @override
  State<StatefulWidget> createState() => _NumberStepperState();
}

class _NumberStepperState extends State<NumberStepper> {
  late final Border border;
  late final defaultValue = widget.value ?? widget.minValue;

  int value = 0;
  Timer? timer;
  FocusNode? focusNode;
  ValueNotifier<bool>? addNotifier;
  ValueNotifier<bool>? subtractNotifier;
  TextEditingController? controller;

  bool get isOverMinValue => value <= widget.minValue;

  bool get isOverMaxValue => value >= widget.maxValue;

  @override
  void initState() {
    super.initState();
    value = correctValue(defaultValue);
    border = Border.all(color: const Color(0xFFD2D2D2), width: 0.5);
    if (!widget.readOnly) {
      focusNode = FocusNode(debugLabel: "NumberStepper");
      focusNode?.addListener(onFocusChanged);
      controller = TextEditingController(text: value.toString());

      addNotifier = ValueNotifier(isOverMaxValue);
      subtractNotifier = ValueNotifier(isOverMinValue);
    }
  }

  @override
  void didUpdateWidget(covariant NumberStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      value = correctValue(widget.value ?? widget.minValue);

      controller?.text = value.toString();
    }
    if (oldWidget.minValue != widget.minValue && isOverMinValue) {
      value = widget.minValue;
    }
    if (oldWidget.maxValue != widget.maxValue && isOverMaxValue) {
      value = widget.maxValue;
    }
    if (oldWidget.readOnly != widget.readOnly) {
      focusNode?.removeListener(onFocusChanged);
      focusNode = null;
      controller = null;
      addNotifier = null;
      subtractNotifier = null;
    }
    if (!widget.readOnly) {
      controller = TextEditingController(text: value.toString());

      addNotifier = ValueNotifier(isOverMaxValue);
      subtractNotifier = ValueNotifier(isOverMinValue);
      focusNode = FocusNode(debugLabel: "NumberStepper");
      focusNode?.addListener(onFocusChanged);
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    focusNode?.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.readOnly) {
      return Text(value.toString(), style: const TextStyle(fontSize: 14));
    }
    Widget child = Container(
      decoration: BoxDecoration(border: border),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            createOperator(subtractNotifier!, doDecrement),
            Expanded(
              child: InputText(
                showClear: false,
                showCounter: false,
                focusNode: focusNode,
                controller: controller,
                textAlign: TextAlign.center,
                inputType: TextInputType.number,
                textAlignVertical: TextAlignVertical.center,
                maxLength: widget.maxValue.toString().length,
                padding: EdgeInsets.all(widget.padding ?? 3),
                onSubmitted: (text) => onValidateAndCorrectValue(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            createOperator(addNotifier!, doIncrement),
          ],
        ),
      ),
    );
    return widget.width == null
        ? child
        : SizedBox(width: widget.width, child: child);
  }

  Widget createOperator(
    ValueNotifier<bool> notifier,
    void Function([Timer? timer]) handler,
  ) {
    final isAdd = notifier == addNotifier;
    return AspectRatio(
      aspectRatio: 1,
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, disabled, child) => GestureDetector(
          onTap: disabled ? null : handler,
          onLongPress: () => createTimer(true, isAdd, handler),
          onLongPressEnd: (details) => createTimer(false, isAdd, handler),
          child: child!,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: isAdd
                ? Border(left: border.right)
                : Border(right: border.left),
          ),
          child: isAdd
              ? const Icon(Icons.add, size: 14)
              : const Icon(Icons.remove, size: 14),
        ),
      ),
    );
  }

  void doDecrement([Timer? timer]) {
    if (!isOverMinValue) {
      updateValue(value - widget.step);

      if (timer == null) notifyChanged();
    } else if (timer != null) {
      timer?.cancel();
      notifyChanged();
    }
  }

  void doIncrement([Timer? timer]) {
    if (!isOverMaxValue) {
      updateValue(value + widget.step);

      if (timer == null) notifyChanged();
    } else if (timer != null) {
      timer?.cancel();
      notifyChanged();
    }
  }

  /// 长按模式下，通过 [Timer] 创建定时任务的方式来开启持续更新值的操作。
  ///
  /// - [active] 是否处于长按按下的状态；
  /// - [isAdd] 当前方法是否由 `+` 发起调用；
  /// - [callback] 创建定时任务的时候指定任务需要执行的目标方法（引用）。
  void createTimer(
    bool active,
    bool isAdd,
    void Function([Timer? timer]) callback,
  ) {
    timer?.cancel();
    if (active) {
      if (isAdd ? !isOverMaxValue : !isOverMinValue) {
        timer = Timer.periodic(_kDuration, callback);
      }
    } else {
      notifyChanged();
    }
  }

  int correctValue(int value) {
    if (value > widget.maxValue) {
      value = widget.maxValue;
    } else if (value < widget.minValue) {
      value = widget.minValue;
    }
    return value;
  }

  /// 更新值并渲染到输入框中
  void updateValue(int newValue) {
    value = correctValue(newValue);
    controller!.text = value.toString();

    // ValueNotifier 的值发生变更时会通知 ValueListenableBuilder
    // 当 ValueListenableBuilder 接收到变更后会刷新左右两侧的功能按钮。
    addNotifier?.value = isOverMaxValue;
    subtractNotifier?.value = isOverMinValue;
  }

  /// 通知 Widget 值发生了变化
  void notifyChanged() => widget.onChanged?.call(value);

  /// 输入框失去焦点后校验并纠正输入的值
  void onFocusChanged() =>
      focusNode!.hasFocus ? 0 : onValidateAndCorrectValue();

  /// 当点击键盘确认按钮之后校验并纠正输入的值
  void onValidateAndCorrectValue() {
    if (!focusNode!.hasFocus) {
      final text = controller!.text;
      int inputValue = text.isEmpty ? defaultValue : int.parse(text);
      if (inputValue != value) {
        updateValue(inputValue);
        notifyChanged();
      }
    }
  }
}
