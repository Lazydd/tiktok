import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/common/index.dart';

class InputText extends StatefulWidget {
  final bool password;

  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool expands;
  final bool showCursor;
  final bool showClear;
  final bool showBorder;
  final bool showCounter;
  final bool showScrollbar;
  final bool? enableInteractiveSelection;

  final Widget? icon;
  final String? label;
  final String? initialValue;
  final String? errorText;
  final String? placeholder;

  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final List<TextInputFormatter>? inputFormatters;

  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  final FocusNode? focusNode;
  final TextInputType? inputType;
  final TextInputAction? inputAction;

  final TextAlign textAlign;
  final TextDirection? textDirection;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;
  final TextEditingController? controller;

  final TextStyle? textStyle;
  final Color? filledColor;

  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const InputText({
    super.key,
    this.password = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.expands = false,
    this.showCursor = true,
    this.showClear = true,
    this.showBorder = false,
    this.showCounter = false,
    this.showScrollbar = true,
    this.enableInteractiveSelection = true,
    this.icon,
    this.label,
    this.initialValue,
    this.errorText,
    this.placeholder,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforcement,
    this.inputFormatters,
    this.padding,
    this.borderRadius,
    this.focusNode,
    this.inputType,
    this.inputAction,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.textCapitalization = TextCapitalization.none,
    this.textAlignVertical,
    this.controller,
    this.textStyle,
    this.filledColor,
    this.onTap,
    this.onClear,
    this.onEditingComplete,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late AppTheme theme;

  late FocusNode focusNode;
  late TextStyle textStyle;
  late EdgeInsets padding;

  bool passwordInput = false;
  bool displayClear = false;
  late TextEditingController controller;
  late ScrollController? scrollController;
  late ValueNotifier<String>? countNotifier;

  @override
  void initState() {
    super.initState();
    passwordInput = widget.password;
    focusNode = widget.focusNode ?? FocusNode();
    textStyle = widget.textStyle ?? const TextStyle(fontSize: 14);
    padding = widget.padding ?? const EdgeInsets.all(10);
    controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    countNotifier =
        widget.maxLength == null ? null : ValueNotifier(controller.text);
    controller.addListener(_doValueChanged);
    if (widget.showClear) {
      displayClear = Helper.isNotEmpty(controller.text);
    }
    if (widget.showScrollbar) {
      scrollController = ScrollController();
    } else {
      scrollController = null;
    }
  }

  @override
  void didUpdateWidget(covariant InputText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.password != widget.password) {
      passwordInput = widget.password;
    }
    if (oldWidget.focusNode != oldWidget.focusNode) {
      focusNode = widget.focusNode ?? FocusNode();
    }
    if (oldWidget.textStyle != widget.textStyle) {
      textStyle = widget.textStyle ?? const TextStyle(fontSize: 14);
    }
    if (oldWidget.padding != widget.padding) {
      padding = widget.padding ?? const EdgeInsets.all(10);
    }
    if (oldWidget.controller != widget.controller) {
      controller.removeListener(_doValueChanged);
      controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
      controller.addListener(_doValueChanged);
    }
    final oldValue = oldWidget.initialValue;
    if (Helper.isNotEmpty(oldValue) && oldValue != widget.initialValue) {
      if (Helper.isNotEmpty(widget.initialValue)) {
        controller.text = widget.initialValue!;
      } else {
        controller.clear();
      }
    }
    displayClear = widget.showClear && Helper.isNotEmpty(controller.text);
    if (oldWidget.maxLength != widget.maxLength) {
      countNotifier =
          widget.maxLength == null ? null : ValueNotifier(controller.text);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(_doValueChanged);
    if (widget.controller == null) {
      controller.dispose();
    }
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    countNotifier?.dispose();
    scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme = context.theme;
    final ixExpanded =
        widget.enabled && widget.maxLength != null && widget.expands;
    Widget input = TextField(
      focusNode: focusNode,
      controller: controller,
      // 属性
      autocorrect: false,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      expands: widget.expands,

      obscureText: passwordInput,
      obscuringCharacter: '*',
      //光标
      showCursor: widget.showCursor,
      cursorWidth: 3,
      cursorOpacityAnimates: true,
      // 文本样式
      style: textStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      textCapitalization: widget.textCapitalization,
      textAlignVertical: widget.textAlignVertical,
      // 输入限制
      minLines: widget.expands ? null : (widget.password ? 1 : widget.minLines),
      maxLines: widget.expands ? null : (widget.password ? 1 : widget.maxLines),
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      //键盘配置
      keyboardType: widget.inputType,
      textInputAction: widget.inputAction,
      // 格式限制
      inputFormatters: widget.inputFormatters,
      //监听
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete, //点击键盘确认触发
      onTapOutside: (e) => focusNode.hasFocus ? focusNode.unfocus() : 0,
      // 样式
      decoration: InputDecoration(
        enabled: false,
        isDense: true,
        isCollapsed: true,
        filled: true,
        fillColor: widget.filledColor,
        // fillColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        //   return states.contains(WidgetState.disabled)
        //       ? const Color(0xFFEDEDED)
        //       : states.contains(WidgetState.focused)
        //           ? Colors.red
        //           : Colors.black;
        // }),

        //内间距
        alignLabelWithHint: false,
        error: _createInputErrorText(),
        counter: countNotifier == null ? null : const SizedBox.shrink(),
        contentPadding: ixExpanded ? padding.copyWith(bottom: 28) : padding,

        //占位文本
        hintText: widget.placeholder,
        hintStyle: textStyle.copyWith(color: const Color(0xFFC8C8C8)),
        hintMaxLines: 1,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        //自定义前缀
        prefixIcon: _createPrefixWidget(),
        prefixIconConstraints: const BoxConstraints(minWidth: 30),
        //自定义尾缀
        suffixIcon: _createSuffixWidget(),
        suffixIconConstraints: const BoxConstraints(minWidth: 30),

        border: InputBorder.none,
        enabledBorder: _createBorder(Colors.grey),
        errorBorder: _createBorder(Colors.red),
        focusedBorder: _createBorder(Colors.blueAccent),
        focusedErrorBorder: _createBorder(Colors.red, 1),
        disabledBorder: _createBorder(const Color(0xFFBCBCBC)),
      ),
    );
    if (!widget.enabled) return input;
    input = widget.expands ? _decorateTextArea(input) : input;
    return input;
  }

  InputBorder? _createBorder(Color color, [double width = 0.5]) {
    return widget.showBorder
        ? OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.zero,
            borderSide: BorderSide(width: width, color: color))
        : null;
  }

  Widget? _createPrefixWidget() {
    if (widget.expands) return null;
    final isIconNull = widget.icon == null;
    final isLabelEmpty = Helper.isEmpty(widget.label);
    if (isIconNull && isLabelEmpty) return null;
    Widget? content;
    if (!isIconNull) {
      if (widget.icon is Icon) {
        content = IconTheme(
          data: theme.data.iconTheme.copyWith(size: 16),
          child: widget.icon!,
        );
      } else {
        content = SizedBox(width: 20, child: widget.icon);
      }
    }
    if (!isLabelEmpty) {
      final label = Text(
        widget.label!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textStyle.copyWith(color: Colors.white),
      );
      if (content == null) {
        content = label;
      } else {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [content, const SizedBox(width: 5), label],
        );
      }
    }
    return Padding(
      padding: EdgeInsets.only(left: padding.left, right: padding.right),
      child: content,
    );
  }

  Widget? _createSuffixWidget() {
    if (widget.expands ||
        !widget.enabled ||
        widget.readOnly ||
        widget.maxLines > 2) return null;
    final items = <Widget>[];

    //数量统计
    if (countNotifier != null && widget.showCounter) {
      items.add(_createCountNotifier());
    }

    //密码明文切换
    if (widget.password) {
      if (items.isNotEmpty) {
        items.add(const SizedBox(width: 5));
      }
      items.add(GestureDetector(
        onTap: () => setState(() => passwordInput = !passwordInput),
        child: Icon(
          passwordInput ? Icons.visibility : Icons.visibility_off,
          size: 19,
          color: Colors.white,
        ),
      ));
    }
    //清除按钮
    if (widget.showClear) {
      if (items.isNotEmpty) {
        items.add(const SizedBox(width: 5));
      }
      items.add(Visibility(
        visible: displayClear,
        child: GestureDetector(
          onTap: () {
            controller.clear();
            widget.onClear?.call();
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color(0xFFB5B5B5),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.clear,
              color: Colors.white,
              size: 14,
            ),
          ),
        ),
      ));
    }
    return Padding(
      padding: EdgeInsets.only(left: 5, right: padding.right),
      child: items.length == 1
          ? items[0]
          : Row(mainAxisSize: MainAxisSize.min, children: items),
    );
  }

  Widget _createCountNotifier() {
    return ValueListenableBuilder(
      valueListenable: countNotifier!,
      builder: (context, text, child) {
        final len = text.length, max = widget.maxLength!;
        return Text(
          "$len/$max",
          style:
              textStyle.copyWith(color: len > max ? Colors.red : Colors.white),
        );
      },
    );
  }

  Widget? _createInputErrorText() {
    if (widget.expands || Helper.isEmpty(widget.errorText)) return null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        widget.errorText!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textStyle.copyWith(fontSize: 12, color: Colors.red),
      ),
    );
  }

  Widget _decorateTextArea(Widget input) {
    if (widget.showScrollbar) {
      input = Scrollbar(controller: scrollController, child: input);
    }
    final hasErrorText = Helper.isNotEmpty(widget.errorText);
    final hasCounter = countNotifier != null;
    if (!hasCounter && !hasCounter) return input;
    final items = <Widget>[];
    if (hasErrorText) {
      Widget error = Text(
        widget.errorText!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textStyle.copyWith(fontSize: 12, color: Colors.red),
      );
      items.add(hasCounter ? Expanded(child: error) : error);
    }
    if (hasCounter) {
      if (items.isNotEmpty) {
        items.add(const SizedBox(width: 5));
      }
      items.add(_createCountNotifier());
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        input,
        Container(
          margin: const EdgeInsets.only(left: 1, right: 1, bottom: 1),
          padding: padding.copyWith(top: 3, bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: items,
          ),
        )
      ],
    );
  }

  void _doValueChanged() {
    countNotifier?.value = controller.text;
    if (!widget.showClear) return;
    if (Helper.isNotEmpty(controller.text)) {
      if (!displayClear) {
        displayClear = true;
        setState(() {});
      }
    } else if (displayClear) {
      displayClear = false;
      setState(() {});
    }
  }
}
