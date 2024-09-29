import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icebery_flutter/common/index.dart';

import 'index.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView(context) {
    return Drawer(
      backgroundColor: const Color(0xff151724),
      width: 260.w,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 20.w),
          ListTile(
            title: Text('我的订单', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.shopping_cart, size: 26.sp),
          ),
          ListTile(
            title: Text('我的钱包', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.account_balance_wallet, size: 26.sp),
          ),
          Divider(height: 1.h).marginOnly(top: 20.h, bottom: 20.h),
          ListTile(
            title: Text('我的二维码', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.qr_code, size: 26.sp),
          ),
          ListTile(
            title: Text('观看历史', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.schedule, size: 26.sp),
          ),
          ListTile(
            title: Text('离线模式', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.cloud_download, size: 26.sp),
          ),
          ListTile(
            title: Text('稍后再看', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.timelapse, size: 26.sp),
          ),
          ListTile(
            title: Text('抖音创作者中心', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.edit_square, size: 26.sp),
          ),
          Divider(height: 1.h).marginOnly(top: 20.h, bottom: 20.h),
          ListTile(
            title: Text('小程序', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.api, size: 26.sp),
          ),
          ListTile(
            title: Text('抖音工艺', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.volunteer_activism, size: 26.sp),
          ),
          ListTile(
            title: Text('青少年模式', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.nature, size: 26.sp),
          ),
          ListTile(
            title: Text('我的客服', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.support_agent, size: 26.sp),
          ),
          ListTile(
            title: Text('设置', style: TextStyle(fontSize: 18.sp)),
            textColor: Colors.white,
            iconColor: Colors.white,
            leading: Icon(Icons.settings, size: 26.sp),
          ),
          Divider(height: 1.h).marginOnly(top: 20.h, bottom: 20.h),
          ElevatedButton.icon(
            onPressed: () {},
            label: Text('更多更能', style: TextStyle(fontSize: 16.sp)),
            icon: Icon(Icons.view_cozy, size: 26.sp),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff3a3a46),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
            ),
          ).marginOnly(left: 20.w, right: 20.w),
          SizedBox(height: 20.w),
        ],
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
