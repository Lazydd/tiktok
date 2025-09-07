import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/core/formx_field_decoration.dart';
import 'package:tiktok/common/utils/helper.dart';
import 'package:tiktok/common/widgets/number_stepper.dart';

class FormXFieldNumberStepper
    extends FormXFieldDecoration<FormXFieldNumberStepper, int, int> {
  /// 数字变化基数，每次增长或者减少的基数，例如：[+10] 或者 [-10]。
  final int step;

  /// 数字步进器所能达到的最小值
  final int minValue;

  /// 数字步进器所能达到的最大值
  final int maxValue;

  /// 字步进器组件的宽度，不指定默认为：[120]。
  final double? width;

  /// 追加在数字步进器后面的尾缀，你可以把它当做是一个 [单位] 来使用。
  final String? suffix;

  const FormXFieldNumberStepper({
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
    super.left,
    super.leftIcon,
    super.background,
    super.textStyle,
    super.emptyTextStyle,
    super.labelTextStyle,
    super.errorTextStyle,
    super.subtitleTextStyle,
    super.descriptionTextStyle,
    // FormXFieldNumberStepper
    this.step = 1,
    required this.minValue,
    required this.maxValue,
    this.width,
    this.suffix,
  }) : super(islabelExpanded: true);

  @override
  void ofItems(
    List<Widget> items,
    FormXFieldState<FormXFieldNumberStepper, int, int> field,
  ) {
    final state = field as FormXFieldNumberStepperState;
    if (field.enabled) {
      items.add(
        NumberStepper(
          step: step,
          width: width ?? 120,
          minValue: minValue,
          maxValue: maxValue,
          initialValue: field.rawValue,
          focusNode: state.focusNode,
          onChanged: (value) => field.setValue(value, refresh: true),
        ),
      );
    } else {
      items.add(ofValueLabel(field, "${field.rawValue}"));
    }
    if (Helper.isNotEmpty(suffix)) {
      items.add(const SizedBox(width: 8));

      items.add(Text(suffix!, style: labelTextStyle));
    }
  }

  @override
  State<StatefulWidget> createState() => FormXFieldNumberStepperState();
}

class FormXFieldNumberStepperState
    extends FormXFieldState<FormXFieldNumberStepper, int, int> {
  late FocusNode focusNode = FocusNode(debugLabel: widget.name);

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        form?.lastField = this;
      }
    });
  }

  @override
  void setValue(int? inputValue, {bool refresh = false}) {
    super.setValue(inputValue ?? widget.minValue, refresh: refresh);
  }

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
  }

  @override
  void unfocus() {
    super.unfocus();
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }
}
