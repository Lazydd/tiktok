import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok/common/index.dart';

Future<T?> buttonSheet<T>(
  Widget child, {
  Text? title,
  Color? bottomSheetColor,
  double? height,
  double? headerHeight,
  EdgeInsetsGeometry? padding,
}) async {
  return showStickyFlexibleBottomSheet<T?>(
    minHeight: 0,
    initHeight: height ?? 0.5,
    maxHeight: height ?? .5,
    headerHeight: headerHeight ?? 50.h,
    context: Get.context!,
    isSafeArea: true,
    bottomSheetColor: bottomSheetColor ?? Colors.black,
    bottomSheetBorderRadius: const BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
    headerBuilder: (context, offset) {
      return RepaintBoundary(
        child: Container(
          height: headerHeight ?? 50.h,
          color: bottomSheetColor ?? Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title ?? const SizedBox(),
              Container(
                alignment: Alignment.center,
                width: 20.w,
                height: 20.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: const Color.fromRGBO(58, 58, 70, 0.4),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 14.sp,
                ),
              ).onTap(Get.back)
            ],
          ),
        ),
      );
    },
    bodyBuilder: (context, offset) {
      return SliverChildListDelegate(
        [Padding(padding: padding ?? EdgeInsets.all(10.w), child: child)],
      );
    },
    anchors: [height ?? 0.5],
  );
}
