import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker_plus/picker.dart';
import 'package:tiktok/common/models/option.dart';
import 'package:tiktok/common/models/regional.dart';
import 'package:tiktok/common/models/tree_model.dart';
import 'package:tiktok/common/utils/helper.dart';
import 'package:tiktok/common/values/consts.dart';
import 'package:tiktok/common/widgets/button_sheet/base_bottom_sheet.dart';

typedef AdapterTransformer<P extends PickerAdapter, T> = T Function(P adapter);

/// 日期时间格式化分类
///
/// * @author xbaistack
/// * @since 2025/06/01 18:33
enum DateTimeFormatter {
  YYYY(PickerDateTimeType.kY, r"yyyy"),
  YYYY_MM(PickerDateTimeType.kYM, r"yyyy-MM"),
  YYYY_MM_DD(PickerDateTimeType.kYMD, r"yyyy-MM-dd"),
  YYYY_MM_DD_HH_MM(PickerDateTimeType.kYMDHM, r"yyyy-MM-dd HH:mm"),
  YYYY_MM_DD_HH_MM_SS(PickerDateTimeType.kYMDHMS, r"yyyy-MM-dd HH:mm:ss"),
  HH_MM(PickerDateTimeType.kHM, r"HH:mm"),
  HH_MM_SS(PickerDateTimeType.kHMS, r"HH:mm:ss");

  final int type;
  final String format;

  const DateTimeFormatter(this.type, this.format);
}

/// 核心数据选择器
///
/// * [datetime] - 用于提供时间/日期选择；
/// * [number] - 用于数字选择器；
/// * [numbers] - 用于提供多列数字选择器；
/// * [list] - 用于提供普通列表/层级联动/树形结构等数据的选择；
/// * [regional] - 用于提供省市区数据的选择；
///
/// * @author xbaistack
/// * @since 2025/06/02 18:35
final class DataPicker {
  static List<Regional>? cities;

  static Future<void> load() async {
    final data = await rootBundle.loadString("assets/city.json");
    final items = jsonDecode(data) as List<dynamic>;
    cities = items.map((e) => Regional.fromJson(e)).toList();
  }

  /// 时间/日期 选择器
  static PickerBottomSheet<DateTime?, DateTimePickerAdapter> datetime({
    required BuildContext context,
    DateTimeFormatter formatter = DateTimeFormatter.YYYY_MM_DD,
    String? title,
    String? confirmText,
    bool showHeader = true,
    bool showFooter = true,
    bool showClose = true,
    DateTime? initialValue,
    DateTime? minValue,
    DateTime? maxValue,
    int? yearBegin = 1970,
    int? yearEnd,
  }) {
    return PickerBottomSheet(
      context: context,
      title: title,
      confirmText: confirmText,
      showHeader: showHeader,
      showFooter: showFooter,
      showClose: showClose,
      transformer: (adapter) => adapter.value,
      adapter: DateTimePickerAdapter(
        type: formatter.type,
        value: initialValue,
        minValue: minValue,
        maxValue: maxValue,
        yearBegin: yearBegin,
        yearEnd: yearEnd ?? DateTime.now().year + 100,
        isNumberMonth: true,
        strAMPM: const ["上午", "下午"],
        yearSuffix: "年",
        monthSuffix: "月",
        daySuffix: "日",
        hourSuffix: "时",
        minuteSuffix: "分",
        secondSuffix: "秒",
      ),
    );
  }

  /// 数字选择器
  static PickerBottomSheet<int?, NumberPickerAdapter> number({
    required BuildContext context,
    required int minValue,
    required int maxValue,
    int? initialValue,
    int step = 1,
    String? title,
    String? confirmText,
    String? postfix,
    String? suffix,
    PickerValueFormat<int>? onFormatValue,
    bool showHeader = true,
    bool showFooter = true,
    bool showClose = true,
  }) {
    return PickerBottomSheet(
      context: context,
      title: title,
      confirmText: confirmText,
      showHeader: showHeader,
      showFooter: showFooter,
      showClose: showClose,
      transformer: (adapter) => adapter.getSelectedValues()[0],
      adapter: NumberPickerAdapter(
        data: [
          NumberPickerColumn(
            begin: minValue,
            end: maxValue,
            jump: step,
            suffix: suffix == null
                ? null
                : Text(suffix, style: const TextStyle(fontSize: 16)),
            postfix: postfix == null
                ? null
                : Text(postfix, style: const TextStyle(fontSize: 16)),
            onFormatValue: onFormatValue,
            initValue: initialValue,
          ),
        ],
      ),
    );
  }

  /// 多列数字选择器
  static PickerBottomSheet<List<int>?, NumberPickerAdapter> numbers({
    required BuildContext context,
    required List<NumberPickerColumn> columns,
    String? title,
    String? confirmText,
    bool showHeader = true,
    bool showFooter = true,
    bool showClose = true,
  }) {
    return PickerBottomSheet(
      context: context,
      title: title,
      confirmText: confirmText,
      showHeader: showHeader,
      showFooter: showFooter,
      showClose: showClose,
      transformer: (adapter) => adapter.getSelectedValues(),
      adapter: NumberPickerAdapter(data: columns),
    );
  }

  /// 列表选择器，支持 `多级联动`（树型结构的列表）
  static PickerBottomSheet<List<Option<T>>?, PickerDataAdapter<Option<T>>>
  list<T>({
    required BuildContext context,
    required List<Option<T>> options,
    List<T>? initialValue,
    String? title,
    String? confirmText,
    bool showHeader = true,
    bool showFooter = true,
    bool showClose = true,
  }) {
    return PickerBottomSheet(
      context: context,
      title: title,
      confirmText: confirmText,
      showHeader: showHeader,
      showFooter: showFooter,
      showClose: showClose,
      transformer: (adapter) => adapter.getSelectedValues(),
      adapter: PickerDataAdapter(data: _itemConvert(options)),
      initialValue: _convert2SelectedList(
        options,
        initialValue,
        (e) => e.value,
      ),
    );
  }

  /// 省市区选择器
  static PickerBottomSheet<List<Regional>?, PickerDataAdapter<Regional>>
  regional<T>({
    required BuildContext context,
    List<String>? initialValue,
    String? title,
    String? confirmText,
    bool showHeader = true,
    bool showFooter = true,
    bool showClose = true,
  }) {
    final regions = Consts.regional;

    return PickerBottomSheet(
      context: context,
      title: title,
      confirmText: confirmText,
      showHeader: showHeader,
      showFooter: showFooter,
      showClose: showClose,
      transformer: (adapter) => adapter.getSelectedValues(),
      adapter: PickerDataAdapter(data: _regionConvert(regions)),
      initialValue: _convert2SelectedList(regions, initialValue, (e) => e.code),
    );
  }

  /// 为了保持数据格式的统一性，需要将 [Option] 列表转换为 [PickerItem] 类表。
  static List<PickerItem<Option<T>>>? _itemConvert<T>(
    List<Option<T>>? options,
  ) {
    if (Helper.isEmpty(options)) return null;
    return options!.map((option) {
      Widget child = Text(option.label);

      if (option.icon != null) {
        child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme(data: const IconThemeData(size: 16), child: option.icon!),
            const SizedBox(width: 5),
            child,
          ],
        );
      }
      return PickerItem(
        value: option,
        text: child,
        children: _itemConvert(option.children),
      );
    }).toList();
  }

  /// 将省市区数据 [Regional] 转换成 [PickerItem] 列表
  static List<PickerItem<Regional>>? _regionConvert(List<Regional>? regions) {
    if (Helper.isEmpty(regions)) return null;
    return regions!.map((region) {
      return PickerItem(
        value: region,
        text: Text(region.name),
        children: _regionConvert(region.children),
      );
    }).toList();
  }

  /// 将选中的数据列表转换成 [sources] 列表中对应数据的下标，
  /// 由于 `flutter_picker_plus` 对于初始化数据的设置不是很完善，
  /// 导致设置的选中列表数量和对应选择器的 `列数` 对应不上就会报错！
  ///
  /// 比如：你有 `3` 列选择器，但是你给的选中数据 `[0, 1]` 少于了 `3` 个，它就会报错！
  /// 所以只好手动转换一下了，这样可以保证在某一列数据不完善的情况下，程序不会报错。
  static List<int>? _convert2SelectedList<T extends TreeModel<T>>(
    List<T> sources,
    List? values,
    dynamic Function(T) getValue,
  ) {
    if (Helper.isEmpty(values)) return null;
    int maxLevel = sources.map((o) => o.level).reduce((a, b) => max(a, b));
    List<int> selected = List.generate(maxLevel, (index) => 0);
    List<T>? items = sources!;
    for (int i = 0; i < values!.length; i++) {
      final initValue = values![i];
      final index = items!.indexWhere((e) => getValue(e) == initValue);
      if (index >= 0) {
        final tempList = items![index].children;
        if (Helper.isNotEmpty(tempList)) {
          items = tempList;
        }
        selected[i] = index;
      }
    }
    return selected;
  }
}

/// Picker 底部模态弹窗组件
///
/// 泛型参数说明：
/// * [OUT] - 组件选择后的返回数据类型；
/// * [P] - Picker 中用于构造不同选择器的数据适配器；
///
/// 常用方法说明：
/// * [show] - `show()` 方法可以打开弹窗并显示内容；
/// * [close] - `close()` 方法用于关闭弹窗并不响应任何内容；
/// * [confirm] - `confirm()` 方法用于关闭弹窗并将 `选择数据` 回传到 `show()` 方法中去；
//
/// * @author xbaistack
/// * @since 2025/06/02 19:03
class PickerBottomSheet<OUT, P extends PickerAdapter>
    extends BaseBottomSheet<OUT> {
  final P adapter;
  final List<int>? initialValue;
  final AdapterTransformer<P, OUT> transformer;
  final PickerSelectedCallback? onSelect;
  final List<PickerDelimiter>? delimiter;

  PickerBottomSheet({
    required super.context,
    required this.adapter,
    this.initialValue,
    this.onSelect,
    this.delimiter,
    required this.transformer,
    super.title,
    super.confirmText,
    super.showHeader,
    super.showFooter,
    super.showClose,
  }) : super(widget: _PickerWidget());

  @override
  void confirm() => Navigator.of(context).pop(transformer.call(adapter));
}

/// Picker 核心视图构造类，内部用于构造数据选择组件。
///
/// * @author xbaistack
/// * @since 2025/06/02 19:02
class _PickerWidget<OUT, P extends PickerAdapter>
    extends BottomSheetWidget<PickerBottomSheet<OUT, P>> {
  @override
  Widget body(BuildContext context) {
    final picker = Picker(
      adapter: parent.adapter,
      hideHeader: true,
      changeToFirst: false,
      itemExtent: 30,
      squeeze: 1.45,
      diameterRatio: 1.0,
      magnification: 1.1,
      height: 180,
      selecteds: parent.initialValue,
      onSelect: parent.onSelect,
      textStyle: const TextStyle(fontSize: 16),
      selectedTextStyle: const TextStyle(fontSize: 16),
      backgroundColor: Colors.white,
      delimiter: parent.delimiter,
    );
    return picker.makePicker(null, false);
  }
}
