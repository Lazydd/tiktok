import 'package:tiktok/common/models/tree_model.dart';
import 'package:tiktok/common/utils/helper.dart';

class Regional extends TreeModel<Regional> {
  final String name;
  final String code;
  final String province;
  final String? city;
  final String? area;

  const Regional({
    required this.name,
    required this.code,
    required this.province,
    this.city,
    this.area,
    super.children,
  });

  factory Regional.fromJson(Map<String, dynamic> json) {
    final list = json["children"];
    List<Regional>? children;
    if (Helper.isNotEmpty(list) && list is List) {
      children = list.map((e) => Regional.fromJson(e)).toList();
    }
    return Regional(
      name: json["name"],
      code: json["code"],
      province: json["province"],
      city: json["city"],
      area: json["area"],
      children: children,
    );
  }

  get value => null;

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "code": code,
      "province": province,
      "city": city,
      "area": area,
      "children": children?.map((e) => e.toJson()).toList()
    };
  }

  @override
  String toString() =>
      'Regional(name: $name, code: $code, children: ${children?.length})';
}
