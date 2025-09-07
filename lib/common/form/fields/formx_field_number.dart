import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/core/formx_field_popup.dart';
import 'package:tiktok/common/utils/helper.dart';
import 'package:tiktok/common/widgets/button_sheet/date_picker.dart';

class FormXFieldNumber extends FormXFieldPopup<FormXFieldNumber, int, int> {
  final int minValue;
  final int maxValue;
  final String? postfix;
  final String? suffix;

  const FormXFieldNumber({
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
    super.converter,
    super.transformer,
    // FormXFieldDecoration
    super.empty,
    super.subtitle,
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
    // FormXFieldPopup
    super.title,
    // FormXFieldNumber
    required this.minValue,
    required this.maxValue,
    this.postfix,
    this.suffix,
  });

  @override
  Widget ofValueLabel(
    FormXFieldState<FormXFieldNumber, int, int> field,
    String? value,
  ) {
    return super.ofValueLabel(
      field,

      Helper.isEmpty(value) ? value : "${postfix ?? ""}$value${suffix ?? ""}",
    );
  }

  @override
  void onPopup(FormXFieldState<FormXFieldNumber, int, int> field) {
    super.onPopup(field);

    DataPicker.number(
      context: field.context,

      title: title ?? label,
      minValue: minValue,
      maxValue: maxValue,
      postfix: postfix,
      suffix: suffix,
      initialValue: field.rawValue,
    ).show().then((value) {
      if (value != null) {
        field.setValue(value, refresh: true);
      }
    });
  }
}
