import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok/common/index.dart';

import 'index.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView(context) {
    return Drawer(
      backgroundColor: const Color(0xff151724),
      width: 260.w,
      child: Theme(
        data: Theme.of(context).copyWith(
          listTileTheme: const ListTileThemeData(
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          iconTheme: IconThemeData(size: 26.sp),
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20.w),
            ListTile(
              title: Text('我的订单', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.shopping_cart),
            ),
            ListTile(
              title: Text('我的钱包', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.account_balance_wallet),
            ),
            Divider(height: 1.h).marginOnly(top: 20.h, bottom: 20.h),
            ListTile(
              title: Text('我的二维码', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.qr_code),
            ),
            ListTile(
              title: Text('观看历史', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.schedule),
            ),
            ListTile(
              title: Text('离线模式', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.cloud_download),
            ),
            ListTile(
              title: Text('稍后再看', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.timelapse),
            ),
            ListTile(
              title: Text('抖音创作者中心', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.edit_square),
            ),
            Divider(height: 1.h).marginOnly(top: 20.h, bottom: 20.h),
            ListTile(
              title: Text('小程序', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.api),
            ),
            ListTile(
              title: Text('抖音工艺', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.volunteer_activism),
            ),
            ListTile(
              title: Text('青少年模式', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.nature),
            ),
            ListTile(
              title: Text('我的客服', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.support_agent),
            ),
            ListTile(
              title: Text('设置', style: TextStyle(fontSize: 18.sp)),
              leading: const Icon(Icons.settings),
              onTap: () {
                Get.toNamed(RouteNames.systemConfigRoute);
              },
            ),
            Divider(height: 1.h).marginOnly(top: 20.h, bottom: 20.h),
            CupertinoButton(
              onPressed: () {},
              color: const Color(0xff3a3a46),
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.button)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.view_cozy, color: Colors.white),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      '更多更能',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  )
                ],
              ),
            ).marginOnly(left: 20.w, right: 20.w),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      init: SettingController(),
      id: "setting",
      builder: (_) {
        return SafeArea(
          child: _buildView(context),
        );
      },
    );
  }
}
