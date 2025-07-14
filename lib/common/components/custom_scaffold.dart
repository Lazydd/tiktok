import 'package:flutter/material.dart';
import 'package:tiktok/common/index.dart';

class CustomScaffold extends Scaffold {
  CustomScaffold({
    super.key,
    super.appBar,
    extendBodyBehindAppBar = false,
    super.body,
    Color? backgroundColor,
    super.bottomNavigationBar,
    super.floatingActionButton,
  }) : super(
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          backgroundColor: backgroundColor ?? AppColors.bgColor,
        );
}
