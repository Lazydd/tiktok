import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/index.dart';

abstract class FormXFieldDecoration<W extends FormXField<W, IN, OUT>, IN, OUT>
    extends FormXField<W, IN, OUT> {
  final String empty;
  final String? subtitle;
  final String? placeholder;

  final Widget? left;
  final Icon? icon;
  final Icon? leftIcon;

  final bool islabelExpanded;
  final padding = 12.0;

  final Color? background;
  final TextStyle? textStyle;
  final TextStyle? emptyTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? errorTextStyle;
  final TextStyle? subtitleTextStyle;
  final TextStyle? descriptionTextStyle;

  const FormXFieldDecoration({
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
    //FormXFieldDecoration
    String? empty,
    this.subtitle,
    this.placeholder,
    this.left,
    this.icon,
    this.leftIcon,
    this.islabelExpanded = false,
    this.background,
    this.textStyle,
    this.emptyTextStyle,
    this.labelTextStyle,
    this.errorTextStyle,
    this.subtitleTextStyle,
    this.descriptionTextStyle,
  }) : empty = empty ?? '(空)';

  EdgeInsets insets({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: left ?? padding,
      top: top ?? padding,
      right: right ?? padding,
      bottom: bottom ?? padding,
    );
  }

  EdgeInsets ofBoxPadding(FormXFieldState<W, IN, OUT> field) => insets();

  void ofItems(List<Widget> items, FormXFieldState<W, IN, OUT> field);

  @override
  Widget build(FormXFieldState<W, IN, OUT> field) {
    final items = <Widget>[];
    final theme = field.context.theme;
    if (left != null) {
      items.add(left!);
    } else if (leftIcon != null) {
      items.add(
        IconTheme(
          data: theme.data.iconTheme.copyWith(size: 18),
          child: leftIcon!,
        ),
      );
    }

    final label = Padding(
      padding: EdgeInsets.only(left: items.isEmpty ? 0 : 5, right: 5),
      child: ofLabel(field),
    );
    items.add(islabelExpanded ? Expanded(child: label) : label);
    ofItems(items, field);
    Widget input = ofWrapper(
      field,
      Row(mainAxisAlignment: MainAxisAlignment.start, children: items),
    );

    if (field.readOnly) return input;
    final columns = <Widget>[input];

    if (field.showErrors && field.hasError) {
      columns.add(ofErrorInfo(field));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columns,
    );
  }

  Widget ofWrapper(FormXFieldState<W, IN, OUT> field, Widget child) {
    return Container(
      // color: background ?? Colors.white,
      padding: ofBoxPadding(field),
      child: child,
    );
  }

  Widget ofLabel(FormXFieldState<W, IN, OUT> field) {
    Widget caption = Text(
      label,
      maxLines: 1,
      style: labelTextStyle,
      overflow: TextOverflow.ellipsis,
    );
    if (this.required && field.enabled) {
      caption = Stack(
        children: [
          Padding(padding: const EdgeInsets.only(right: 7), child: caption),
          const Positioned(
            right: 0,
            top: 4,
            child: Text(
              '*',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
    if (Helper.isNotEmpty(subtitle)) {
      caption = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          caption,
          const SizedBox(height: 3),
          Text(
            subtitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: subtitleTextStyle,
          ),
        ],
      );
    }
    return caption;
  }

  Widget ofValueLabel(FormXFieldState<W, IN, OUT> field, String? value) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          value ?? empty,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: field.enabled || field.isNotEmpty ? textStyle : emptyTextStyle,
        ),
      ),
    );
  }

  Widget ofErrorInfo(FormXFieldState<W, IN, OUT> field) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        color: Color(0x12FF5252),
        border: Border(
          top: BorderSide(width: 1, color: Color(0x26FF5252)),
          bottom: BorderSide(width: 1, color: Color(0x26FF5252)),
        ),
      ),
      padding: insets(top: 2, bottom: 3),
      margin: const EdgeInsets.only(bottom: 1),
      child: Text(field.errorText!, style: errorTextStyle),
    );
  }
}
