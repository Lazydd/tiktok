import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/fields/formx_field_text.dart';

class FormXFieldTextMobile extends FormXFieldText<String> {
  final int? coutdown;
  FormXFieldTextMobile({
    super.key,
    // FormXField
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
    super.renderer,
    super.converter,
    super.transformer,
    // FormXFieldDecoration
    super.empty,
    super.placeholder,
    super.left,
    super.leftIcon,
    super.background,
    super.textStyle,
    super.emptyTextStyle,
    super.labelTextStyle,
    super.errorTextStyle,
    super.subtitleTextStyle,
    super.descriptionTextStyle,
    // FormXFieldText
    super.showClear,
    super.maxLength,
    super.focusNode,
    super.textAlign,
    super.inputAction,
    super.controller,
    super.maxLengthEnforcement,
    super.onTap,
    super.onClear,
    super.onEditingComplete,
    super.onSubmitted,
    this.coutdown,
  }) : super(
          showCounter: false,
          inputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        );

  Timer? _timer;
  int _counter = -1;

  void startCountdown(
      FormXFieldState<FormXFieldText<String>, String, String> field) {
    _counter = coutdown ?? 60;
    _timer?.cancel();
    _timer ==
        Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_counter-- <= 0) timer.cancel();
          field.rebuild();
        });
    field.rebuild();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _timer = null;
  }

  @override
  EdgeInsets ofBoxPadding(
      FormXFieldState<FormXFieldText<String>, String, String> field) {
    return field.enabled ? insets(top: 0, bottom: 0) : insets();
  }

  @override
  void ofItems(
    List<Widget> items,
    FormXFieldState<FormXFieldText<String>, String, String> field,
  ) {
    super.ofItems(items, field);
    if (field.readOnly) return;
    Widget label;
    if (_counter >= 0) {
      label = ofText("重发($_counter秒)", Colors.grey);
    } else {
      label = GestureDetector(
        onTap: () => startCountdown(field),
        child: ofText("发送验证码", Colors.blueAccent),
      );
    }
    items.add(Container(
      padding: EdgeInsets.only(left: padding),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xFFDFDFDF), width: 1),
        ),
      ),
      child: label,
    ));
  }

  Widget ofText(String text, Color color) {
    return Text(text, style: textStyle?.copyWith(color: color));
  }
}
