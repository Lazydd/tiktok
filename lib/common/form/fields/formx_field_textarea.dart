import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/fields/formx_field_text.dart';
import 'package:tiktok/common/widgets/input_text.dart';

class FormXFieldTextArea extends FormXFieldText<String> {
  final int? maxLines;

  const FormXFieldTextArea({
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
    super.showCounter,
    super.maxLength,
    super.focusNode,
    super.textAlign = TextAlign.start,
    super.inputType,
    super.inputAction,
    super.controller,
    super.maxLengthEnforcement,
    super.inputFormatters,
    super.onTap,
    super.onClear,
    super.onEditingComplete,
    super.onSubmitted,
    this.maxLines,
  });

  @override
  EdgeInsets ofBoxPadding(
      FormXFieldState<FormXFieldText, String, String> field) {
    return EdgeInsets.zero;
  }

  @override
  Widget build(FormXFieldState<FormXFieldText<String>, String, String> field) {
    Widget widget;
    final state = field as FormXFieldTextState<String>;
    if (field.enabled) {
      widget = InputText(
        enabled: field.enabled,
        readOnly: field.readOnly,
        showClear: false,
        showCounter: showCounter ?? true,
        controller: state.controller,
        focusNode: state.focusNode,
        // initialValue: field.rawValue,
        errorText: state.showErrors ? state.errorText : null,
        textAlign: textAlign,
        textStyle: textStyle,
        inputType: inputType,
        inputAction: inputAction,
        inputFormatters: inputFormatters,
        placeholder: field.readOnly && field.isEmpty ? empty : placeholder,
        maxLines: maxLines ?? 3,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        enableInteractiveSelection: field.enabled,
        padding: insets(top: 0),
        onTap: onTap,
        onClear: onClear,
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
      );
    } else {
      widget = Container(
        padding: insets(top: 0),
        alignment: Alignment.topLeft,
        child: Text(
          state.rawValue ?? empty,
          style: state.isEmpty ? descriptionTextStyle : textStyle,
        ),
      );
    }
    return ofWrapper(
        field,
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: insets(bottom: 5), child: ofLabel(field)),
            widget
          ],
        ));
  }
}
