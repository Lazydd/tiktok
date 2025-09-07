import 'package:tiktok/common/utils/helper.dart';

abstract class TreeModel<T extends TreeModel<T>> {
  final List<T>? children;

  const TreeModel({this.children});

  int _getLevel(List<T>? children, int level) {
    if (Helper.isEmpty(children)) return 1;
    for (int i = 0, s = children!.length; i < s; i++) {
      if (Helper.isNotEmpty(children![i].children)) {
        return _getLevel(children![i].children, level + 1);
      }
    }
    return level + 1;
  }

  int get level => _getLevel(children, 1);
}
