import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class AddfriendPage extends GetView<AddfriendController> {
  const AddfriendPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("AddfriendPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddfriendController>(
      init: AddfriendController(),
      id: "addfriend",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("添加朋友"),
          ),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
