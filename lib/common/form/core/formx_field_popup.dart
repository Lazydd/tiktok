import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/core/formx_field_decoration.dart';

abstract class FormXFieldPopup<W extends FormXFieldPopup<W, IN, OUT>, IN, OUT>
    extends FormXFieldDecoration<W, IN, OUT> {
  final String? title;
  const FormXFieldPopup({
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
    //FormXFieldPopup
    super.empty,
    super.subtitle,
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
    this.title,
  });

  void onPopup(FormXFieldState<W, IN, OUT> field) {
    field.form?.clearAnyFocus();
  }

  Widget ofSelectedValue(FormXFieldState<W, IN, OUT> field) {
    return ofValueLabel(field, field.renderValue);
  }

  @override
  Widget ofValueLabel(FormXFieldState<W, IN, OUT> field, String? value) {
    value = value ?? (field.enabled ? placeholder ?? "请选择" : empty);
    return super.ofValueLabel(field, value);
  }

  @override
  Widget ofWrapper(FormXFieldState<W, IN, OUT> field, Widget child) {
    child = super.ofWrapper(field, child);
    if (field.readOnly) return child;

    return GestureDetector(
      onTap: () => onPopup(field),
      child: super.ofWrapper(field, child),
    );
  }

  @override
  void ofItems(List<Widget> items, FormXFieldState<W, IN, OUT> field) {
    Widget valueLabel =
        field.isEmpty ? ofValueLabel(field, null) : ofSelectedValue(field);
    if (valueLabel is! Expanded) {
      valueLabel = Expanded(
        child: Align(
          alignment: Alignment.centerRight,
          child: valueLabel,
        ),
      );
    }
    items.add(valueLabel);
    if (field.enabled) {
      items.add(const Icon(
        Icons.chevron_right,
        size: 16,
        color: Colors.grey,
      ));
    }
  }
}
