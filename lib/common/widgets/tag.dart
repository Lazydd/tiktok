import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagWidget extends StatelessWidget {
  final String? text;

  final Widget? icon;

  final double? radius;

  final Color? color;

  final Color? backgroundColor;

  const TagWidget(
    this.text, {
    super.key,
    this.icon,
    this.radius,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 2.sp),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
        color: backgroundColor ?? const Color.fromRGBO(58, 58, 58, 0.4),
        child: Row(children: [
          if (icon != null) ...[icon ?? const SizedBox(), SizedBox(width: 2.w)],
          Text(
            text ?? '',
            style: TextStyle(
              color: color ?? const Color(0xffbababb),
              fontSize: 12.sp,
            ),
          )
        ]),
      ),
    );
  }
}
