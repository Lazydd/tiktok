import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class GetViewKeepAlive<T> extends StatefulWidget {
  const GetViewKeepAlive({super.key, this.tag});

  @override
  State<GetViewKeepAlive<T>> createState() => _GetViewKeepAliveState<T>();

  @protected
  Widget build(BuildContext context);

  @protected
  final String? tag;

  @protected
  T get controller => GetInstance().find<T>(tag: tag)!;
}

class _GetViewKeepAliveState<T> extends State<GetViewKeepAlive<T>>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.build(context);
  }

  @override
  bool get wantKeepAlive => true;
}
