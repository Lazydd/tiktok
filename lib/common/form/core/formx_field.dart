part of 'formx.dart';

abstract class FormXField<W extends FormXField<W, IN, OUT>, IN, OUT>
    extends StatefulWidget {
  /// 表单字段名
  final String name;

  /// 表单文字标签
  final String label;
  final String? restorationId;

  /// 组件默认值（优先使用表单中的 [initialValue] 中的值，其次再使用此值）
  final OUT? defaultValue;

  /// 是否启用表单（默认：[true] 最终值需要结合 [FormX] 中的设置）
  final bool enabled;

  /// 是否是必填字段，如果设置为 [true] 的话则会在 [label] 的右侧显示一个小红星 [*]。
  final bool required;

  /// 执行 [save] 保存动作时的回调监听
  final ValueSetter<OUT?>? onSaved;

  /// 执行 [reset] 动作时的回调监听
  final ValueChanged<IN?>? onReset;

  /// 当内部值发生变更时会回调此函数
  final ValueChanged<IN?>? onChanged;

  final List<Validator<IN>>? validator;

  /// 将外部的值 [OUT] 转换成内部使用的 [IN] 数据格式
  /// ```dart
  /// FormXField<String, int>(
  ///   ...,
  ///   converter: (value) => "$value",
  /// );
  /// ```
  final FieldTransformer<OUT, IN> converter;

  final FieldTransformer<IN, OUT> transformer;

  /// 将内部流转的值 [IN] 转换用于渲染的字符串
  /// ```dart
  /// FormXField<String, int>(
  ///   ...,
  ///   renderer: (value) => "postfix:$value:suffix",
  /// );
  /// ```
  final FieldTransformer<IN, String>? renderer;

  const FormXField({
    super.key,
    required this.name,
    required this.label,
    this.restorationId,
    this.defaultValue,
    this.enabled = true,
    this.required = false,
    this.onSaved,
    this.onReset,
    this.onChanged,
    this.validator,
    FieldTransformer<OUT, IN>? converter,
    FieldTransformer<IN, OUT>? transformer,
    this.renderer,
  })  : converter = converter ?? Helper.converter,
        transformer = transformer ?? Helper.converter;

  void initialize() {}

  void dispose() {}

  Widget build(FormXFieldState<W, IN, OUT> field);

  @override
  State<StatefulWidget> createState() => FormXFieldState<W, IN, OUT>();
}

class FormXFieldState<W extends FormXField<W, IN, OUT>, IN, OUT>
    extends State<W> with RestorationMixin<W> {
  late final whitespace = RegExp(r'\s+');
  final RestorableStringN _errorText = RestorableStringN(null);

  /// 用于记录表单是否已经被初始化，可以配合做一些仅在初始化之后做的工作。
  bool _initialized = false;

  /// 表单组件内部维护的值
  late IN? _value;

  /// 表单 [State] 对象，所有交互类动作都是通过它进行的。
  late FormXState? _form;

  /// 当前组件的校验规则，如果标注了 [required]，但是没有设置 [Validator] 的话，
  /// 会自动在校验规则中加入 [required] 相关的校验。
  late List<Validator<IN>>? _validator;

  /// 组件原始值（内部值）
  IN? get rawValue => _value;

  /// 表单 [State] 对象
  FormXState? get form => _form;

  /// 用于返回当前组件是否已经完成初始化
  bool get initialized => _initialized;

  /// 用于判断当前组件的值是否为空
  bool get isEmpty => Helper.isEmpty(rawValue);

  /// 用于判断当前组件的值是否有值
  bool get isNotEmpty => Helper.isNotEmpty(rawValue);

  /// 用于判断是否启用了表单
  bool get enabled => widget.enabled && (_form?.enabled ?? true);

  /// 用于判断当前表单是否是只读（查看）模式
  bool get readOnly => !enabled;

  /// 用于判断当前组件是否启用了边输入边验证功能
  bool get validateOnInput => _form?.validateOnInput ?? false;

  /// 用于判断当前表单是否启用了错误显示
  bool get showErrors => _form?.showErrors ?? false;

  /// 用于判断当前组件是否有验证错误
  bool get hasError => Helper.isNotEmpty(errorText);

  /// 用于获取当前组件的验证错误信息
  String? get errorText => _errorText.value;

  @override
  String? get restorationId => widget.restorationId ?? widget.name;

  /// 用于返回当前组件的最终值，此值可以直接用于提交给服务端。
  ///
  /// - 首先会尝试获取在表单中保存过的值；
  /// - 没有获取到则会尝试使用 [transformer] 去转换内部值；
  /// - 当内部值都为空时，则尝试获取默认值。
  ///
  /// 在一定程度上此方法一定能获取到一个有效的值
  OUT? get value {
    return _form?.getSavedValue(widget.name) ??
        transformedValue ??
        defaultValue;
  }

  /// 返回组件的初始值
  IN? get initialValue {
    final defValue = defaultValue;
    return defValue == null ? null : widget.converter.call(defValue);
  }

  String? get renderValue {
    final rawvalue = this.rawValue;
    final renderer = widget.renderer ?? Helper.converter;
    return rawvalue == null ? null : renderer.call(rawvalue);
  }

  OUT? get defaultValue {
    final name = widget.name;

    dynamic initialValue = _form?.getInitialValue(name);
    if (initialValue == null) return widget.defaultValue;

    try {
      if (initialValue is OUT) return initialValue;
      return Helper.converter<dynamic, OUT>(initialValue);
    } catch (e) {
      throw FormatException(
        '## $name ## required "$OUT", but got ${initialValue.runtimeType}',
      );
    }
  }

  /// 用于返回通过 [transformer] 转换后的值
  OUT? get transformedValue {
    final rawValue = this.rawValue;
    return rawValue == null ? null : widget.transformer.call(rawValue);
  }

  /// 用于消除子组件的焦点（主要是一些文本类组件）
  void unfocus() {}
  void rebuild() => setState(() {});

  bool validate() {
    setState(_validate);

    return !hasError;
  }

  /// 重置表单组件，当执行此方法之后，对应的表单组件值会重置为 [initialValue]。
  void reset() {
    _resetError();
    setValue(initialValue);

    widget.dispose();

    widget.onReset?.call(rawValue);

    rebuild();
  }

  /// 执行表单组件值保存操作，当调用此方法时会把每个组件内部的值保存到表单的 [_savedValues] 中。
  void save() {
    final value = transformedValue;
    _form?._saveValue(widget.name, value);

    widget.onSaved?.call(value);
  }

  /// （核心方法）用于设置表单组件的值，此方法会自动将给定的 [inputValue] 设置到表单中保存起来，
  /// 并通知外部的 [onChanged] 监听。
  void setValue(IN? inputValue, {bool refresh = false}) {
    // 修正传入的值（"" => null）
    if (Helper.isEmpty(inputValue)) {
      inputValue = null;
      _resetError();
    }

    // 打印调试日志

    // 设置值
    _value = inputValue;
    _form?._setValue(widget.name, inputValue);

    // 边输入边校验
    if (validateOnInput) {
      _validate();
    }

    // 通知外部值发生了变更

    widget.onChanged?.call(inputValue);

    _form?._notifyChange();

    // 清除上一个表单元素的焦点（文本框）
    if (initialized && _form?.lastField != this) {
      _form?.lastField?.unfocus();
      _form?.lastField = this;
    }

    // 根据情况决定是否重构组件
    if (refresh) rebuild();
  }

  void _resetError() {
    // ignore: invalid_use_of_protected_member
    if (_errorText.isRegistered) {
      _errorText.value = null;
    }
  }

  void _validate() {
    if (_errorText.isRegistered) {
      if (_validator != null) {
        _errorText.value = null;
        for (final validator in _validator!) {
          final errorMessage = validator.validate(widget.label, rawValue);
          if (Helper.isNotEmpty(errorMessage)) {
            _errorText.value = errorMessage!.replaceAll(whitespace, '');
            break;
          }
        }
      }
    }
  }

  /// 用于整合设置给组件的必填标识 [required]，保证无论外部是否设置了 [validator]，一定会有必填规则校验。
  List<Validator<IN>>? _getValidator() {
    if (!widget.required) return widget.validator;
    final validator = widget.validator ?? <Validator<IN>>[];
    if (validator.isEmpty) {
      validator.add(Validator.required());
    } else if (validator.every((v) => v.name() != 'required')) {
      validator.insert(0, Validator.required());
    }
    return validator;
  }

  @override
  void initState() {
    super.initState();

    widget.initialize();

    _validator = _getValidator();
    _form = FormX.maybeOf(context);

    _form?._register(widget.name, this);
    _initialized = true;
  }

  @override
  void didUpdateWidget(covariant W oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.name != oldWidget.name) {
      _form?._unregister(widget.name, this);
      _form?._register(widget.name, this);
    }
    if (widget.validator != oldWidget.validator ||
        widget.required != oldWidget.required) {
      _resetError();
      _validator = _getValidator();
    }
  }

  @override
  void dispose() {
    super.dispose();

    widget.dispose();

    _form?._unregister(widget.name, this);
  }

  @override
  Widget build(BuildContext context) => widget.build(this);

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_errorText, 'error_text');
  }
}
