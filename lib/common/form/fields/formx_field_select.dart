import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/core/formx_field_popup.dart';
import 'package:tiktok/common/models/option.dart';
import 'package:tiktok/common/utils/helper.dart';
import 'package:tiktok/common/widgets/button_sheet/selectable.dart';

class FormXFieldSelect<IN, OUT>
    extends FormXFieldPopup<FormXFieldSelect<IN, OUT>, OUT, OUT> {
  final List<Option<IN>> options;

  const FormXFieldSelect({
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
    // FormXFieldSelect
    required this.options,
  });

  List<IN>? defaults(
    FormXFieldState<FormXFieldSelect<IN, OUT>, OUT, OUT> field,
  ) {
    if (field.isEmpty) return null;
    if (field.rawValue is List<IN>) {
      return field.rawValue as List<IN>;
    } else if (field.rawValue is IN) {
      return [field.rawValue as IN];
    }
    return null;
  }

  @override
  Widget ofSelectedValue(
    FormXFieldState<FormXFieldSelect<IN, OUT>, OUT, OUT> field,
  ) {
    final selected = field.rawValue is List<IN>
        ? field.rawValue as List<IN>
        : [field.rawValue! as IN];
    final label = options
        .where((option) => selected.contains(option.value))
        .map((option) => option.label)
        .join(" / ");
    return super.ofValueLabel(field, label);
  }

  @override
  void onPopup(FormXFieldState<FormXFieldSelect<IN, OUT>, OUT, OUT> field) {
    bool isValid = false;
    super.onPopup(field);
    final multiple = Helper.sameType<OUT, List<IN>>();
    Selectable(
      context: field.context,

      options: options,
      multiple: multiple,
      title: title ?? label,
      initialValue: defaults(field),
      onConfirmBefore: (values) =>
          isValid = !this.required || values.isNotEmpty,
    ).show().then((values) {
      if (isValid) {
        OUT? result;
        if (Helper.isEmpty(values)) {
          result = null;
        } else if (multiple) {
          result = values!.map((e) => e.value).toList() as OUT;
        } else {
          result = values![0].value as OUT;
        }

        field.setValue(result, refresh: true);
      }
    });
  }
}
