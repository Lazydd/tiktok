import 'package:flutter/material.dart';
import 'package:tiktok/common/form/core/formx.dart';
import 'package:tiktok/common/form/formx_inputs.dart';

class FormController {
  final VoidCallback? onChanged;
  final PopInvokedWithResultCallback? onWillPop;

  late final GlobalKey<FormXState> _formKey = GlobalKey();

  FormController({this.onChanged, this.onWillPop});

  FormXState? get form => _formKey.currentState;

  bool validate() => form?.validate() ?? false;

  void reset() => form?.reset();

  T? getField<T>(String name) {
    return form?.getField(name) as T;
  }

  void setValue<T>(String name, T value) => form?.setValue(name, value);

  void setInitialValue(Map<String, dynamic> value) =>
      form?.initialValue = value;

  Map<String, dynamic> getErrors() => form?.errors ?? {};
  Map<String, dynamic> getValue() => form?.value ?? {};

  dynamic getValueBy(String name) => form?.getValue(name);
  dynamic getRawValueBy(String name) => form?.getRawValue(name);

  void clearFocus() => form?.clearAnyFocus();
}

final class FormInput extends StatelessWidget {
  final bool enabled; //是否启用，false为查看，true为编辑
  final bool validateOnInput; //边输入边验证
  final bool showErrors; //是否显示错误提示

  final String? empty;

  final Map<String, dynamic> initialValue;
  final FormController? controller;
  final List<Input> children;

  FormInput({
    super.key,
    this.enabled = true,
    this.validateOnInput = false,
    this.showErrors = false,
    this.empty,
    this.initialValue = const <String, dynamic>{},
    this.controller,
    required List<Input> children,
  }) : children = filtering(enabled, children); //表单初始数据

  late Color background;
  late TextStyle textStyle;
  late TextStyle emptyTextStyle;
  late TextStyle? labelTextStyle;
  late TextStyle errorTextStyle;
  late TextStyle subtitleTextStyle;
  late TextStyle descriptionTextStyle;

  void initializ(BuildContext context) {
    background = Colors.white;
    textStyle = const TextStyle(fontSize: 14);
    emptyTextStyle = textStyle.copyWith(color: const Color(0xFFD5D5D5));
    labelTextStyle = textStyle.copyWith();
    errorTextStyle = const TextStyle(fontSize: 12, color: Colors.redAccent);
    subtitleTextStyle = textStyle.copyWith(color: const Color(0xFF888888));
    descriptionTextStyle = textStyle.copyWith(color: const Color(0xFF888888));
  }

  @override
  Widget build(BuildContext context) {
    initializ(context);
    return FormX(
      key: controller?._formKey,
      enabled: enabled,
      showErrors: showErrors,
      initialValue: initialValue,
      validateOnInput: validateOnInput,
      onChanged: controller?.onChanged,
      onWillPop: controller?.onWillPop,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ofItems(context),
        ),
      ),
    );
  }

  List<Widget> ofItems(BuildContext context) {
    final items = <Widget>[];
    for (int index = 0, size = children.length; index < size; index++) {
      items.add(children[index].build(context, this, index));
      if (index < size - 1) {
        items.add(const SizedBox(
          width: double.infinity,
          height: 1,
          child: ColoredBox(color: Color(0xFFEEEEEE)),
        ));
      }
    }
    return items;
  }

  static List<Input> filtering(bool enabled, List<Input> children) {
    final newList = <Input>[];
    for (int index = 0, size = children.length; index < size; index++) {
      final input = children[index];
      if (enabled) {
        if (input.showOnEnabled) {
          newList.add(input);
        }
        continue;
      }
      if (!input.hideOnDisabled) {
        newList.add(input);
      }
    }
    return newList;
  }
}
