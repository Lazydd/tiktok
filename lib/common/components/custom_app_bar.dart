import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/common/index.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    bool automaticallyImplyLeading = true,
    Widget? title,
    List<Widget>? actions,
    bool? centerTitle,
    double? elevation,
    double? titleSpacing,
    double? leadingWidth,
    Widget? leading,
    Color? backgroundColor,
    double? toolbarHeight,
    SystemUiOverlayStyle? systemOverlayStyle,
  }) : super(
          key: key,
          title: title,
          titleSpacing: titleSpacing,
          leadingWidth: leadingWidth,
          leading: leading,
          systemOverlayStyle: systemOverlayStyle,
          automaticallyImplyLeading: automaticallyImplyLeading,
          backgroundColor: backgroundColor ?? Colors.white,
          toolbarHeight: toolbarHeight,
          centerTitle: centerTitle ?? true,
          elevation: elevation ?? 0,
          actions: _buildActions(actions),
          iconTheme: IconThemeData(
            color: AppColors.primary, // 返回按钮颜色
          ),
          toolbarTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        );

  static List<Widget>? _buildActions(List<Widget>? items) {
    if ((items ?? []).isEmpty) return null;
    final ws = <Widget>[];
    for (var element in items!) {
      ws.add(Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: AppSpace.page),
        child: element,
      ));
    }
    return ws;
  }
}
