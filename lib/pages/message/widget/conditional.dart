import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;

class BuildConditional extends StatelessWidget {
  final dynamic item;

  const BuildConditional(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget wd = Icon(
      Icons.arrow_forward_ios_rounded,
      size: 16.w,
      color: Colors.grey,
    );
    if (item is bool && item) {
      wd = badges.Badge(
        badgeStyle: badges.BadgeStyle(
          badgeColor: Colors.red,
          elevation: 0,
          padding: EdgeInsets.all(5.r),
        ),
      );
    } else if (item is int) {
      wd = badges.Badge(
        badgeContent: Text(
          item <= 99 ? item.toString() : "99+",
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
        badgeStyle: badges.BadgeStyle(
          badgeColor: Colors.red,
          elevation: 0,
          padding: EdgeInsets.all(5.r),
        ),
      );
    }
    return wd;
  }
}
