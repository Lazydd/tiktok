part of main;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const _MainViewGetX();
  }
}

class _MainViewGetX extends GetView<MainController> {
  const _MainViewGetX({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView(context) {
    DateTime? lastPressedAt;
    return WillPopScope(
        child: Scaffold(
          bottomNavigationBar: GetBuilder<MainController>(
            id: 'navigation',
            builder: (_) {
              return Stack(
                children: [
                  BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: controller.currentIndex,
                    onTap: controller.onJumpToPage,
                    items: const [
                      BottomNavigationBarItem(
                        icon: SizedBox.shrink(),
                        label: '首页',
                      ),
                      BottomNavigationBarItem(
                        icon: SizedBox.shrink(),
                        label: '朋友',
                      ),
                      BottomNavigationBarItem(
                        icon: SizedBox.shrink(),
                        label: '', // Dummy item for spacing
                      ),
                      BottomNavigationBarItem(
                        icon: SizedBox.shrink(),
                        label: '消息',
                      ),
                      BottomNavigationBarItem(
                          icon: SizedBox.shrink(), label: '我')
                    ],
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 15.w,
                    top: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () async {
                        if (controller.didAuthenticate ||
                            await controller._checkBiometric()) {
                          Get.toNamed('/publish');
                        }
                      },
                      child: Center(
                        child: Icon(
                          Icons.add_box,
                          color: Colors.white,
                          size: 32.sp,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(), // 不响应用户的滚动
            controller: controller.pageController,
            onPageChanged: controller.onIndexChanged,
            children: const [
              HomePage(),
              FriendPage(),
              SizedBox.shrink(),
              MessagePage(),
              MinePage(),
            ],
          ),
        ),
        onWillPop: () async {
          if (lastPressedAt == null ||
              DateTime.now().difference(lastPressedAt!) >
                  const Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            lastPressedAt = DateTime.now();
            Loading.toast("再点击一次退出应用");
            return false;
          }
          await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return true;
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      id: "main",
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
