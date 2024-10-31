part of slidebar;

class SlidebarPage extends GetView<SlidebarController> {
  const SlidebarPage({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView(SlidebarController controller, BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff161616),
      width: 320.w,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(10.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings, color: Colors.white, size: 24.sp),
                color: const Color(0xff1d1d1d),
              ),
              CupertinoButton(
                onPressed: () async {
                  // Access.openCamera(
                  //   context,
                  //   onCameraGranted: () {
                  //     Get.back(result: AccessEnum.takePhoto);
                  //   },
                  //   isNavigatorPop: true,
                  // );
                  var result = await Get.to(() => const ScanCodePage());
                  return result;
                },
                color: const Color(0xff1d1d1d),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.crop_free, color: Colors.white, size: 24.sp),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        '扫一扫',
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageWidget(
                    AssetsImages.avatarPng,
                    width: 10.w,
                    height: 10.w,
                  ).clipRRect(all: 5.r),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      '手机充值：12元话费卷已到达账户手机充值：12元话费卷已到达账户',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '昨天 23:27',
                    style: TextStyle(
                      color: const Color(0xff808080),
                      fontSize: 12.sp,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageWidget(
                    AssetsImages.avatarPng,
                    width: 10.w,
                    height: 10.w,
                  ).clipRRect(all: 5.r),
                  SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      '钱包服务：抖音支付活动抖音支付活动抖音支付活动',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '昨天 23:27',
                    style: TextStyle(
                        color: const Color(0xff808080), fontSize: 12.sp),
                  )
                ],
              )
            ],
          ).card(
            radius: 12.r,
            color: const Color(0xff1d1d1d),
            padding: 15,
            title: _title(
              '通知消息',
              subtTitle: '有新消息',
              more: true,
              onTap: () {},
            ),
          ),
          SizedBox(height: 10.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: SlidebarController.appletList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              Map item = SlidebarController.appletList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageWidget(
                    AssetsImages.avatarPng,
                    width: 50.w,
                    height: 50.w,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item["name"],
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  )
                ],
              ).onTap(item["onTap"]);
            },
          ).card(
            radius: 12.r,
            color: const Color(0xff1d1d1d),
            title: _title('常用小程序', more: true, onTap: () {}),
          ),
          SizedBox(height: 10.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: SlidebarController.commonList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              Map item = SlidebarController.commonList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(item["icon"], color: Colors.white, size: 24.sp),
                  SizedBox(height: 8.h),
                  Text(
                    item["name"],
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  )
                ],
              ).onTap(item["onTap"]);
            },
          ).card(
            radius: 12.r,
            color: const Color(0xff1d1d1d),
            title: _title('常用功能'),
          ),
          SizedBox(height: 10.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: SlidebarController.lifeList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              Map item = SlidebarController.lifeList[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(item["icon"], color: Colors.white, size: 24.sp),
                  SizedBox(height: 8.h),
                  Text(
                    item["name"],
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  )
                ],
              ).onTap(item["onTap"]);
            },
          ).card(
            radius: 12.r,
            color: const Color(0xff1d1d1d),
            title: _title('生活动态'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SlidebarController>(
      init: SlidebarController(),
      id: "slidebar",
      builder: (_) {
        return SafeArea(
          child: _buildView(_, context),
        );
      },
    );
  }
}
