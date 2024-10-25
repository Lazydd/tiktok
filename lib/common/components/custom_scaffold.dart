import 'package:flutter/material.dart';
import 'package:tiktok/common/index.dart';

class CustomScaffold extends Scaffold {
  CustomScaffold({
    Key? key,
    PreferredSizeWidget? appBar,
    extendBodyBehindAppBar = false,
    Widget? body,
    Color? backgroundColor,
    Widget? bottomNavigationBar,
    Widget? floatingActionButton,
  }) : super(
          key: key,
          appBar: appBar,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          body: body,
          backgroundColor: backgroundColor ?? AppColors.bgColor,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
        );
}
