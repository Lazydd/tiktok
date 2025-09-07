import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/core/formx_field_popup.dart';
import 'package:tiktok/common/utils/helper.dart';
import 'package:tiktok/common/widgets/button_sheet/date_picker.dart';

class FormXFieldRegional
    extends FormXFieldPopup<FormXFieldRegional, List<String>, List<String>> {
  const FormXFieldRegional({
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
  });

  @override
  void initialize() {
    super.initialize();
    if (Helper.isEmpty(DataPicker.cities)) {
      DataPicker.load();
    }
  }

  @override
  Widget ofSelectedValue(
    FormXFieldState<FormXFieldRegional, List<String>, List<String>> field,
  ) {
    String? value;
    if (field.isNotEmpty && Helper.isNotEmpty(DataPicker.cities)) {
      final names = <String>[];
      var regionals = DataPicker.cities;

      for (String code in field.rawValue!) {
        for (int i = 0, size = regionals!.length; i < size; i++) {
          final regional = regionals![i];
          if (regional != null && regional.code == code) {
            names.add(regional.name);
            regionals = regional.children;
            break;
          }
        }
      }
      if (names.isNotEmpty) {
        value = names.join(" / ");
      }
    }
    return super.ofValueLabel(field, value);
  }

  @override
  void onPopup(
    FormXFieldState<FormXFieldRegional, List<String>, List<String>> field,
  ) {
    super.onPopup(field);

    DataPicker.regional(
      context: field.context,
      title: title ?? label,
      initialValue: field.rawValue,
    ).show().then((values) {
      if (Helper.isNotEmpty(values)) {
        field.setValue(values!.map((e) => e.code).toList(), refresh: true);
      }
    });
  }
}
