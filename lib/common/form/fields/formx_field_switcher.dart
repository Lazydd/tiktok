import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/core/formx_field_decoration.dart';
import 'package:tiktok/common/widgets/switcher.dart';

class FormXFieldSwitcher
    extends FormXFieldDecoration<FormXFieldSwitcher, bool, bool> {
  const FormXFieldSwitcher({
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
  }) : super(islabelExpanded: true);

  @override
  void ofItems(
    List<Widget> items,
    FormXFieldState<FormXFieldSwitcher, bool, bool> field,
  ) {
    items.add(
      Switcher(
        value: field.rawValue ?? false,
        disabled: field.readOnly,

        onChangedFirst: true,
        onChanged: (state, value) {
          field.setValue(value);

          state.toggle(value);
        },
      ),
    );
  }
}
