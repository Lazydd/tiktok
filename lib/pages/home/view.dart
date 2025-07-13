part of home;

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  Widget more(String name) {
    return Center(
      child: Text(name, style: const TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      id: "home",
      builder: (HomeController _) {
        final GlobalKey<RecommendPageState> childKey =
            GlobalKey<RecommendPageState>();
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
                icon: Icon(Icons.sort, size: 24.sp),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, size: 24.sp),
              )
            ],
            title: TabBar(
              labelColor: CupertinoColors.white,
              controller: controller._tabController,
              isScrollable: true,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              labelStyle: TextStyle(fontSize: 14.sp),
              indicator: const UnderlineTabIndicator(
                insets: EdgeInsets.only(bottom: 4),
              ),
              tabs: controller.tabs.map((v) => Tab(text: v)).toList(),
            ),
          ),
          drawer: const SlidebarPage(),
          body: TabBarView(
            controller: controller._tabController,
            children: [
              VisibilityDetector(
                key: const Key('video'),
                onVisibilityChanged: (VisibilityInfo info) {
                  if (info.visibleFraction < 1) {
                    childKey.currentState?.pause();
                  } else {
                    childKey.currentState?.play();
                  }
                },
                child: RecommendPage(key: childKey),
              ),
              const ShopPage(),
              more(controller.tabs[2])
            ],
          ),
        );
      },
    );
  }
}
