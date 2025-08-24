import 'package:flutter/material.dart';
import 'package:tiktok/common/models/tree_model.dart';
import 'package:tiktok/common/utils/helper.dart';

class Option<T> extends TreeModel<Option<T>> {
  final String label;
  final T value;
  final Widget? icon;

  const Option({
    required this.label,
    required this.value,
    this.icon,
    super.children,
  });

  int _getLevel(List<Option<T>>? children, int level) {
    if (children?.isEmpty ?? true) return 1;
    for (int i = 0, s = children!.length; i < s; i++) {
      if (children[i].children?.isNotEmpty ?? false) {
        return _getLevel(children[i].children, level + 1);
      }
    }
    return level + 1;
  }

  factory Option.fromJson(Map<String, dynamic> json) {
    final list = json["children"];
    List<Option<T>>? children;
    if (Helper.isNotEmpty(list) && list is List) {
      children = list.map<Option<T>>((e) => Option.fromJson(e)).toList();
    }
    return Option<T>(
      label: json["label"],
      value: json["value"],
      children: children,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "label": label,
      "value": value,
      "children": children?.map((e) => e.toJson()).toList()
    };
  }

  @override
  String toString() =>
      'Option(label: $label, value: $value, children: ${children?.length})';
}
