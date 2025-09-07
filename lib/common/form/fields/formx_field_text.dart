import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/core/formx_field_decoration.dart';
import 'package:tiktok/common/index.dart';

class FormXFieldText<OUT>
    extends FormXFieldDecoration<FormXFieldText<OUT>, String, OUT> {
  final bool? password;
  final bool? showClear;
  final bool? showCounter;

  final int? maxLength;
  final FocusNode? focusNode;

  final TextAlign textAlign;
  final TextInputType? inputType; //文本类型
  final TextInputAction? inputAction; //点击确认后的操作
  final TextEditingController? controller; //控制器
  final MaxLengthEnforcement? maxLengthEnforcement; //最大长度限制
  final List<TextInputFormatter>? inputFormatters; //输入内容格式限制

  final VoidCallback? onTap; //点击回调
  final VoidCallback? onClear; //清除回调
  final VoidCallback? onEditingComplete; //编辑完成回调
  final ValueChanged<String>? onSubmitted; //提交回调

  const FormXFieldText({
    super.key,
    required super.name,
    required super.label,
    super.restorationId,
    super.defaultValue,
    super.enabled,
    super.required,
    super.onSaved,
    super.onReset,
    super.onChanged,
    super.validator,
    super.converter,
    super.transformer,
    super.renderer,
    //FormXFieldDecoration
    String? empty,
    super.placeholder,
    super.left,
    super.icon,
    super.leftIcon,
    super.background,
    super.textStyle,
    super.emptyTextStyle,
    super.labelTextStyle,
    super.errorTextStyle,
    super.subtitleTextStyle,
    super.descriptionTextStyle,
    //FormXFieldText
    this.password,
    this.showClear,
    this.showCounter,
    this.maxLength,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.inputType,
    this.inputAction,
    this.controller,
    this.maxLengthEnforcement,
    this.inputFormatters,
    this.onTap,
    this.onClear,
    this.onEditingComplete,
    this.onSubmitted,
  });

  @override
  EdgeInsets ofBoxPadding(
      FormXFieldState<FormXFieldText<OUT>, String, OUT> field) {
    return field.enabled ? EdgeInsets.only(left: padding) : insets();
  }

  @override
  void ofItems(List<Widget> items,
      FormXFieldState<FormXFieldText<OUT>, String, OUT> field) {
    if (field.readOnly) {
      return items.add(super.ofValueLabel(field, field.rawValue));
    }
    final state = field as FormXFieldTextState;
    items.add(Expanded(
      child: InputText(
        enabled: field.enabled,
        readOnly: field.readOnly,
        password: password ?? false,
        showClear: showClear ?? true,
        showCounter: showCounter ?? true,
        controller: state.controller,
        focusNode: state.focusNode,
        // initialValue: field.rawValue,
        textAlign: textAlign,
        textStyle: textStyle,
        inputType: inputType,
        inputAction: inputAction,
        inputFormatters: inputFormatters,
        placeholder: field.readOnly && field.isEmpty ? empty : placeholder,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        enableInteractiveSelection: field.enabled,
        padding: insets(left: 3),
        onTap: onTap,
        onClear: onClear,
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
      ),
    ));
  }

  @override
  State<StatefulWidget> createState() => FormXFieldTextState<OUT>();
}

class FormXFieldTextState<OUT>
    extends FormXFieldState<FormXFieldText<OUT>, String, OUT> {
  late FocusNode focusNode;
  late FocusAttachment focusAttachment;
  late TextEditingController controller;

  void clear() => controller.clear();

  void focus() {
    if (!focusNode.hasFocus) {
      FocusScope.of(context).requestFocus();
    }
  }

  @override
  void unfocus() {
    super.unfocus();
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  @override
  void setValue(String? inputValue, {bool refresh = false}) {
    super.setValue(inputValue, refresh: refresh);
    if (initialized) {
      _updateControllerValue(inputValue);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: rawValue);
    controller.addListener(_handleValueChanged);
    focusNode = widget.focusNode ?? FocusNode(debugLabel: widget.name);
    focusNode.addListener(_handleFocusChanged);
    focusAttachment = focusNode.attach(context);
  }

  @override
  void didUpdateWidget(covariant FormXFieldText<OUT> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      focusAttachment.detach();
      focusNode.removeListener(_handleFocusChanged);
      focusNode = widget.focusNode ?? FocusNode(debugLabel: widget.name);
      focusNode.addListener(_handleFocusChanged);
      focusAttachment = focusNode.attach(context);
    }
    if (widget.controller != oldWidget.controller) {
      controller.removeListener(_handleValueChanged);
      controller = widget.controller ?? TextEditingController(text: rawValue);
      controller.addListener(_handleValueChanged);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) {
      controller.dispose();
    }
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
  }

  void _handleValueChanged() {
    if (controller.text != (rawValue ?? '')) {
      super.setValue(controller.text, refresh: true);
    }
  }

  void _handleFocusChanged() {
    if (focusNode.hasFocus) {
      form?.lastField = this;
    }
  }

  void _updateControllerValue(String? value) {
    if (controller.text != value) {
      if (Helper.isEmpty(value)) {
        controller.clear();
      } else {
        controller.text = value!;
      }
    }
  }
}
