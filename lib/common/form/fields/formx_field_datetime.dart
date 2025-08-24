import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/core/formx_field_popup.dart';
import 'package:tiktok/common/utils/dates.dart';
import 'package:tiktok/common/utils/helper.dart';
import 'package:tiktok/common/widgets/button_sheet/date_picker.dart';

class FormXFieldDateTime<OUT>
    extends FormXFieldPopup<FormXFieldDateTime<OUT>, DateTime, OUT> {
  final DateTime? initialValue;
  final DateTime? minValue;
  final DateTime? maxValue;
  final String? minValueBy;
  final String? maxValueBy;
  final int? yearBegin;
  final int? yearEnd;
  final DateTimeFormatter formatter;

  const FormXFieldDateTime({
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
    super.title,
    this.initialValue,
    this.minValue,
    this.maxValue,
    this.yearBegin,
    this.yearEnd,
    this.minValueBy,
    this.maxValueBy,
    required this.formatter,
  });

  @override
  Widget ofSelectedValue(
      FormXFieldState<FormXFieldDateTime<OUT>, DateTime, OUT> field) {
    final value = field.isEmpty
        ? null
        : (renderer == null
            ? Dates.format(formatter.format, field.rawValue)
            : field.renderValue);
    return super.ofValueLabel(field, value);
  }

  @override
  void onPopup(FormXFieldState<FormXFieldDateTime<OUT>, DateTime, OUT> field) {
    super.onPopup(field);
    final state = field as FormXFieldDateTimeState;
    state._setBoundaryLimited(field.rawValue);
    DataPicker.datetime(
      context: field.context,
      minValue: state._minValue,
      maxValue: state._maxValue,
      yearBegin: yearBegin ?? state._minValue?.year,
      yearEnd: yearEnd ?? state._maxValue?.year,
      title: title ?? label,
      formatter: formatter,
      initialValue: field.rawValue,
    ).show().then((datetime) {
      if (datetime != null) {
        field.setValue(datetime, refresh: true);
      }
    });
  }

  @override
  State<StatefulWidget> createState() => FormXFieldDateTimeState<OUT>();
}

class FormXFieldDateTimeState<OUT>
    extends FormXFieldState<FormXFieldDateTime<OUT>, DateTime, OUT> {
  late DateTime? _minValue = widget.minValue;
  late DateTime? _maxValue = widget.maxValue;
  @override
  void setValue(DateTime? inputValue, {bool refresh = false}) {
    super.setValue(inputValue, refresh: refresh);
    if (initialized) {
      _setBoundaryLimited(inputValue);
    }
  }

  @override
  void didUpdateWidget(covariant FormXFieldDateTime<OUT> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.minValue != oldWidget.minValue) {
      _minValue = widget.minValue;
    }
    if (widget.maxValue != oldWidget.maxValue) {
      _maxValue = widget.maxValue;
    }
  }

  void _setBoundaryLimited(DateTime? inputValue) {
    if (Helper.isNotEmpty(widget.minValueBy) &&
        widget.minValueBy != widget.name) {
      final state =
          form?.getField(widget.minValueBy!) as FormXFieldDateTimeState;
      if (state != null) {
        if (inputValue != null &&
            (state.rawValue?.isAfter(inputValue) ?? false)) {
          state.setValue(inputValue);
        }
        _minValue = state.rawValue ?? state._minValue;
        state._maxValue = inputValue;
      }
    } else if (Helper.isNotEmpty(widget.maxValueBy) &&
        widget.maxValueBy != widget.name) {
      final state =
          form?.getField(widget.maxValueBy!) as FormXFieldDateTimeState;
      if (state != null) {
        if (inputValue != null &&
            (state.rawValue?.isBefore(inputValue) ?? false)) {
          state.setValue(inputValue);
        }
        _maxValue = state.rawValue ?? state._maxValue;
        state._minValue = inputValue;
      }
    }
  }
}
