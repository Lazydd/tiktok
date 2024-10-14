import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icebery_flutter/common/index.dart';
import 'package:icebery_flutter/pages/friend/widget/row.dart';

import 'index.dart';

class FriendPage extends GetView<FriendController> {
  const FriendPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView(context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '发现通讯录朋友',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              SizedBox(height: 5.h),
              Text(
                '你身边的朋友在用抖音，快去看看吧',
                style: TextStyle(
                  color: const Color.fromARGB(255, 131, 146, 151),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 252, 47, 86),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                ),
                child: Align(
                  child: Text(
                    '查看',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ).marginOnly(left: 50.w, right: 50.w)
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.all(AppSpace.card.w),
            color: const Color.fromARGB(255, 67, 72, 73),
            child: Column(
              children: <Widget>[
                const BuildRow(
                  icon: AssetsSvgs.wechat,
                  text: '快速添加微信朋友',
                ),
                SizedBox(height: 20.h),
                const BuildRow(icon: AssetsSvgs.qq, text: '快速添加QQ朋友'),
              ],
            ),
          ).clipRRect(all: AppSpace.card.r).paddingAll(AppSpace.card.w),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendController>(
      init: FriendController(),
      id: "friend",
      builder: (_) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.person_add, size: 24.sp),
              ),
            ),
            title: const Text("朋友"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, size: 24.sp),
              )
            ],
          ),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
