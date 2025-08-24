import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/fields/formx_field_text.dart';

class FormXFieldTextCaptcha extends FormXFieldText<String> {
  const FormXFieldTextCaptcha({
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
    super.maxLength = 6,
    super.focusNode,
    super.textAlign,
    super.inputAction,
    super.controller,
    super.maxLengthEnforcement,
    super.onTap,
    super.onClear,
    super.onEditingComplete,
    super.onSubmitted,
  }) : super(showCounter: false, inputType: TextInputType.text);

  @override
  void ofItems(
    List<Widget> items,
    FormXFieldState<FormXFieldText<String>, String, String> field,
  ) {
    super.ofItems(items, field);
    if (field.enabled) {
      items.add(GestureDetector(
        onTap: field.rebuild,
        child: Image.network(
          'https://img2018.cnblogs.com/blog/736399/202001/736399-20200108170302307-1377487770.jpg',
          height: 30,
        ),
      ));
    }
  }
}
