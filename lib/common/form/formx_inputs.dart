import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/fields/formx_field_text.dart';
import 'package:tiktok/common/form/fields/formx_field_text_captcha.dart';
import 'package:tiktok/common/form/fields/formx_field_text_mobile.dart';
import 'package:tiktok/common/form/fields/formx_field_textarea.dart';
import 'package:tiktok/common/form/formx_validator.dart';
import 'package:tiktok/common/form/formx_widget.dart';

typedef InputBuilder = Widget Function(
    BuildContext context, FormInput parent, int index);

class Input {
  final Widget? child;
  final InputBuilder? builder;
  final Object? debugLabel;
  final bool showOnEnabled;
  final bool hideOnDisabled;

  const Input({
    this.child,
    this.builder,
    this.debugLabel,
    bool? showOnEnabled,
    bool? hideOnDisabled,
  })  : showOnEnabled = showOnEnabled ?? true,
        hideOnDisabled = hideOnDisabled ?? false;

  @override
  String toString() {
    return debugLabel == null
        ? super.toString()
        : "$runtimeType -> <$debugLabel>";
  }

  Widget build(BuildContext context, FormInput parent, int index) {
    return child ??
        builder?.call(context, parent, index) ??
        const SizedBox.shrink();
  }

  factory Input.spacer({
    double height = 12,
    bool? showOnEnabled,
    bool? hideOnDisabled,
  }) {
    return Input(
      showOnEnabled: showOnEnabled,
      hideOnDisabled: hideOnDisabled,
      debugLabel: "Spacer($height)",
      child: SizedBox(height: height),
    );
  }

  factory Input.builder({
    required InputBuilder builder,
    bool? showOnEnabled,
    bool? hideOnDisabled,
  }) {
    return Input(
      showOnEnabled: showOnEnabled,
      hideOnDisabled: hideOnDisabled,
      debugLabel: "Builder",
      builder: builder,
    );
  }

  factory Input.customize({
    required Widget child,
    bool? showOnEnabled,
    bool? hideOnDisabled,
  }) {
    return Input(
      showOnEnabled: showOnEnabled,
      hideOnDisabled: hideOnDisabled,
      debugLabel: "Customize($child)",
      child: child,
    );
  }

  factory Input.leading(
    String text, {
    bool? showOnEnabled,
    bool? hideOnDisabled,
  }) {
    return Input(
      showOnEnabled: showOnEnabled,
      hideOnDisabled: hideOnDisabled,
      debugLabel: "Leading($text)",
      builder: (ctx, parent, index) => Padding(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: index == 0 ? 5 : 12,
            bottom: 5,
          ),
          child: Text(
            text,
            style: parent.descriptionTextStyle,
          )),
    );
  }

  factory Input.text({
    Key? key,
    required String name,
    required String label,
    String? restorationId,
    String? defaultValue,
    String? placeholder,
    bool? debug,
    bool? enabled,
    bool required = false,
    bool showClear = true,
    bool showCounter = true,
    bool? showOnEnabled,
    bool? hideOnDisabled,
    int? maxLength,
    Widget? left,
    Icon? leftIcon,
    FocusNode? focusNode,
    TextAlign textAlign = TextAlign.start,
    TextInputType? inputType,
    TextInputAction? inputAction,
    TextEditingController? controller,
    MaxLengthEnforcement? maxLengthEnforcement,
    List<TextInputFormatter>? inputFormatters,
    VoidCallback? onTap,
    VoidCallback? onClear,
    ValueChanged<String?>? onSaved,
    ValueChanged<String?>? onReset,
    ValueChanged<String?>? onChanged,
    ValueChanged<String?>? onSubmitted,
    VoidCallback? onEditingComplete,
    List<Validator<String>>? validator,
    FieldTransformer<String, String>? renderer,
    FieldTransformer<String, String>? converter,
    FieldTransformer<String, String>? transformer,
  }) {
    return Input(
      showOnEnabled: showOnEnabled,
      hideOnDisabled: hideOnDisabled,
      debugLabel: "FormXFieldText($name)",
      builder: (ctx, parent, index) => FormXFieldText(
        key: key,
        name: name,
        label: label,
        left: left,
        leftIcon: leftIcon,
        empty: parent.empty,
        defaultValue: defaultValue,
        placeholder: placeholder,
        required: required,
        enabled: enabled ?? parent.enabled,
        restorationId: restorationId,
        showClear: showClear,
        showCounter: showCounter,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        focusNode: focusNode,
        textAlign: textAlign,
        inputAction: inputAction,
        inputType: inputType,
        inputFormatters: inputFormatters,
        controller: controller,
        validator: validator,
        renderer: renderer,
        converter: converter,
        transformer: transformer,
        background: parent.background,
        textStyle: parent.textStyle,
        emptyTextStyle: parent.emptyTextStyle,
        subtitleTextStyle: parent.subtitleTextStyle,
        labelTextStyle: parent.labelTextStyle,
        errorTextStyle: parent.errorTextStyle,
        descriptionTextStyle: parent.descriptionTextStyle,
        onTap: onTap,
        onSaved: onSaved,
        onReset: onReset,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
      ),
    );
  }

  factory Input.textarea({
    Key? key,
    required String name,
    required String label,
    String? restorationId,
    String? placeholder,
    bool? debug,
    bool? enabled,
    bool? showCounter,
    bool required = false,
    bool showClear = true,
    bool? showOnEnabled,
    bool? hideOnDisabled,
    int? maxLines,
    int? maxLength,
    Widget? left,
    Icon? leftIcon,
    FocusNode? focusNode,
    TextAlign textAlign = TextAlign.start,
    TextInputType? inputType,
    TextInputAction? inputAction,
    TextEditingController? controller,
    MaxLengthEnforcement? maxLengthEnforcement,
    List<TextInputFormatter>? inputFormatters,
    VoidCallback? onTap,
    VoidCallback? onClear,
    ValueChanged<String?>? onSaved,
    ValueChanged<String?>? onReset,
    ValueChanged<String?>? onChanged,
    ValueChanged<String?>? onSubmitted,
    VoidCallback? onEditingComplete,
    List<Validator<String>>? validator,
    FieldTransformer<String, String>? renderer,
    FieldTransformer<String, String>? converter,
    FieldTransformer<String, String>? transformer,
  }) {
    return Input(
      showOnEnabled: showOnEnabled,
      hideOnDisabled: hideOnDisabled,
      debugLabel: "FormXFieldTextArea($name)",
      builder: (ctx, parent, index) => FormXFieldTextArea(
        key: key,
        name: name,
        label: label,
        left: left,
        leftIcon: leftIcon,
        empty: parent.empty,
        placeholder: placeholder,
        required: required,
        enabled: enabled ?? parent.enabled,
        restorationId: restorationId,
        showCounter: showCounter,
        maxLines: maxLines,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        focusNode: focusNode,
        textAlign: textAlign,
        inputAction: inputAction,
        inputType: inputType,
        inputFormatters: inputFormatters,
        controller: controller,
        validator: validator,
        renderer: renderer,
        converter: converter,
        transformer: transformer,
        background: parent.background,
        textStyle: parent.textStyle,
        emptyTextStyle: parent.emptyTextStyle,
        subtitleTextStyle: parent.subtitleTextStyle,
        labelTextStyle: parent.labelTextStyle,
        errorTextStyle: parent.errorTextStyle,
        descriptionTextStyle: parent.descriptionTextStyle,
        onTap: onTap,
        onSaved: onSaved,
        onReset: onReset,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
      ),
    );
  }

  factory Input.mobile({
    Key? key,
    required String name,
    required String label,
    String? restorationId,
    String? placeholder,
    bool? debug,
    bool? enabled,
    bool required = false,
    bool showClear = true,
    bool? showOnEnabled,
    bool? hideOnDisabled,
    int? maxLines,
    int? maxLength,
    int? coutdown,
    Widget? left,
    Icon? leftIcon,
    FocusNode? focusNode,
    TextAlign textAlign = TextAlign.start,
    TextInputAction? inputAction,
    TextEditingController? controller,
    MaxLengthEnforcement? maxLengthEnforcement,
    VoidCallback? onTap,
    VoidCallback? onClear,
    ValueChanged<String?>? onSaved,
    ValueChanged<String?>? onReset,
    ValueChanged<String?>? onChanged,
    ValueChanged<String?>? onSubmitted,
    VoidCallback? onEditingComplete,
    List<Validator<String>>? validator,
    FieldTransformer<String, String>? renderer,
    FieldTransformer<String, String>? converter,
    FieldTransformer<String, String>? transformer,
  }) {
    return Input(
      showOnEnabled: showOnEnabled,
      hideOnDisabled: hideOnDisabled,
      debugLabel: "FormXFieldTextArea($name)",
      builder: (ctx, parent, index) => FormXFieldTextMobile(
        key: key,
        name: name,
        label: label,
        left: left,
        leftIcon: leftIcon,
        empty: parent.empty,
        placeholder: placeholder,
        required: required,
        enabled: enabled ?? parent.enabled,
        restorationId: restorationId,
        maxLength: maxLength,
        coutdown: coutdown,
        maxLengthEnforcement: maxLengthEnforcement,
        focusNode: focusNode,
        textAlign: textAlign,
        inputAction: inputAction,
        controller: controller,
        validator: validator,
        renderer: renderer,
        converter: converter,
        transformer: transformer,
        background: parent.background,
        textStyle: parent.textStyle,
        emptyTextStyle: parent.emptyTextStyle,
        subtitleTextStyle: parent.subtitleTextStyle,
        labelTextStyle: parent.labelTextStyle,
        errorTextStyle: parent.errorTextStyle,
        descriptionTextStyle: parent.descriptionTextStyle,
        onTap: onTap,
        onSaved: onSaved,
        onReset: onReset,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
      ),
    );
  }

  factory Input.captcha({
    Key? key,
    required String name,
    required String label,
    String? restorationId,
    String? placeholder,
    bool? debug,
    bool? enabled,
    bool required = false,
    bool showClear = true,
    bool? showOnEnabled,
    bool? hideOnDisabled,
    int? maxLines,
    int? maxLength,
    int? coutdown,
    Widget? left,
    Icon? leftIcon,
    FocusNode? focusNode,
    TextAlign textAlign = TextAlign.start,
    TextInputAction? inputAction,
    TextEditingController? controller,
    MaxLengthEnforcement? maxLengthEnforcement,
    VoidCallback? onTap,
    VoidCallback? onClear,
    ValueChanged<String?>? onSaved,
    ValueChanged<String?>? onReset,
    ValueChanged<String?>? onChanged,
    ValueChanged<String?>? onSubmitted,
    VoidCallback? onEditingComplete,
    List<Validator<String>>? validator,
    FieldTransformer<String, String>? renderer,
    FieldTransformer<String, String>? converter,
    FieldTransformer<String, String>? transformer,
  }) {
    return Input(
      showOnEnabled: showOnEnabled,
      hideOnDisabled: hideOnDisabled,
      debugLabel: "FormXFieldTextCaptcha($name)",
      builder: (ctx, parent, index) => FormXFieldTextCaptcha(
        key: key,
        name: name,
        label: label,
        left: left,
        leftIcon: leftIcon,
        empty: parent.empty,
        placeholder: placeholder,
        required: required,
        enabled: enabled ?? parent.enabled,
        restorationId: restorationId,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
        focusNode: focusNode,
        textAlign: textAlign,
        inputAction: inputAction,
        controller: controller,
        validator: validator,
        renderer: renderer,
        converter: converter,
        transformer: transformer,
        background: parent.background,
        textStyle: parent.textStyle,
        emptyTextStyle: parent.emptyTextStyle,
        subtitleTextStyle: parent.subtitleTextStyle,
        labelTextStyle: parent.labelTextStyle,
        errorTextStyle: parent.errorTextStyle,
        descriptionTextStyle: parent.descriptionTextStyle,
        onTap: onTap,
        onSaved: onSaved,
        onReset: onReset,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
