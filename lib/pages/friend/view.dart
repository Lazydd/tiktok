part of 'index.dart';

class FriendPage extends GetView<FriendController> {
  const FriendPage({super.key});

  // 主视图
  Widget _buildView(context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
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
            CupertinoButton(
              onPressed: () {},
              color: const Color.fromARGB(255, 252, 47, 86),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.button)),
              child: Align(
                child: Text(
                  '查看',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ).marginOnly(left: 50.w, right: 50.w)
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.all(AppSpace.card.w),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 67, 72, 73),
              borderRadius: BorderRadius.circular(AppSpace.card.r),
            ),
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
          ).paddingAll(AppSpace.card.w),
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
          backgroundColor: const Color(0xff161616),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: CupertinoColors.white,
              size: 24.sp,
            ),
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.person_add, size: 24.sp),
              ),
            ),
            title: const Text(
              "朋友",
              style: TextStyle(color: CupertinoColors.white),
            ),
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
