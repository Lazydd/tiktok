import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:tiktok/common/form/formx_validator.dart';
import 'package:tiktok/common/utils/helper.dart';

part 'formx_field.dart';

const Duration _kIOSAnnouncementDelayDuration = Duration(seconds: 1);

typedef FieldTransformer<IN, OUT> = OUT? Function(IN value);

class FormX extends StatefulWidget {
  final Widget child;
  final bool enabled; //是否启用，false为查看，true为编辑
  final bool validateOnInput; //边输入边验证
  final bool showErrors; //是否显示错误提示

  final Map<String, dynamic> initialValue; //表单初始数据
  final VoidCallback? onChanged; //表单数据变化回调
  final PopInvokedWithResultCallback<Map<String, dynamic>>? onWillPop; //页面返回时回调

  const FormX({
    super.key,
    required this.child,
    this.enabled = true,
    this.validateOnInput = true,
    this.showErrors = false,
    this.initialValue = const <String, dynamic>{},
    this.onChanged,
    this.onWillPop,
  });

  static FormXState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<FormXState>();
  }

  @override
  State<FormX> createState() => FormXState();
}

class FormXState extends State<FormX> {
  final Map<String, FormXFieldState> _fields = {};
  final Map<String, dynamic> _formValues = {};
  final Map<String, dynamic> _saveValues = {};

  FormXFieldState? lastField;

  bool get enabled => widget.enabled;

  bool get readOnly => !widget.enabled;

  bool get validateOnInput => widget.validateOnInput;

  bool get showErrors => widget.showErrors;

  Map<String, FormXFieldState> get fields => Map.unmodifiable(_fields);

  FormXFieldState? getField(String name) => _fields[name];

  Map<String, dynamic> get formValues => Map.unmodifiable(_formValues);

  Map<String, dynamic> get value {
    _fields.forEach((name, field) => field.save());
    return Map.unmodifiable(_saveValues);
  }

  Map<String, String> get errors {
    final errorMap = <String, String>{};
    final entries = fields.entries.where((e) => e.value.hasError);
    for (var entry in entries) {
      errorMap[entry.key] = entry.value.errorText!;
    }
    return Map.unmodifiable(errorMap);
  }

  set initialValue(Map<String, dynamic> values) {
    if (Helper.isNotEmpty(values)) {
      values.forEach((name, value) {
        _fields[name]?.setValue((value, refresh: true));
      });
    }
  }

  dynamic getValue(String name) => _fields[name]?.value;
  dynamic getRawValue(String name) => _fields[name]?.rawValue;
  dynamic getInitialValue(String name) => widget.initialValue[name];
  dynamic getSavedValue(String name) => _saveValues[name];

  void clearAnyFocus() => lastField?.unfocus();

  void setValue<T>(String name, T? value) {
    if (value != null) {
      _fields[name]?.setValue(value, refresh: true);
    }
  }

  bool validate() {
    if (readOnly) return false;
    _forceRebuild();
    return false;
  }

  void reset() {
    if (readOnly) return;
    _fields.forEach((name, field) => field.reset());
    _notifyChange();
    _forceRebuild();
  }

  void _forceRebuild() => setState(() {});

  void _notifyChange() => widget.onChanged?.call();

  void _saveValue(String name, dynamic value) => _saveValues[name] = value;

  void _setValue(String name, dynamic value) => _formValues[name] = value;

  void _register(String name, FormXFieldState field) {
    _fields[name] = field;
    field.setValue(field.initialValue);
  }

  void _unregister(String name, FormXFieldState field) {
    if (_fields.containsKey(name) && _fields[name] == field) {
      _fields.remove(name);
      _formValues.remove(name);
      _saveValues.remove(name);
    }
  }

  bool _validate() {
    bool hasError = false;
    String errorMessage = "";
    _fields.forEach((name, field) {
      hasError = !field.validate() || hasError;
      errorMessage += field.errorText ?? "";
    });
    if (errorMessage.isNotEmpty) {
      final TextDirection directionality = Directionality.of(context);
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        unawaited(Future<void>(() async {
          await Future<void>.delayed(_kIOSAnnouncementDelayDuration);
          SemanticsService.announce(errorMessage, directionality,
              assertiveness: Assertiveness.assertive);
        }));
      } else {
        SemanticsService.announce(errorMessage, directionality,
            assertiveness: Assertiveness.assertive);
      }
    }
    return !hasError;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: widget.onWillPop,
      child: FocusTraversalGroup(
        policy: WidgetOrderTraversalPolicy(),
        child: widget.child,
      ),
    );
  }
}
