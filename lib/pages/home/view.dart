part of home;

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  // 主视图
  Widget _buildView(HomeController controller) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: controller.pageController,
      itemCount: 4,
      onPageChanged: controller.pageChange,
      itemBuilder: (context, index) => GetBuilder<HomeController>(
          id: "video",
          builder: (_) {
            final GlobalKey<VideoPlayerWidgetState> childKey =
                GlobalKey<VideoPlayerWidgetState>();
            return Stack(
              children: [
                VideoPlayerWidget(
                  key: childKey,
                  videoUrl:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                ),
                Positioned(
                  right: 5.w,
                  bottom: 15.h,
                  child: const InteractivePage(),
                ),
                _desc(context)
              ],
            );
          }),
    );
  }

  Widget more(String name) {
    return Center(
      child: Text(name, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _desc(context) {
    return Positioned(
      left: 10.w,
      bottom: 10.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('@小橙子', style: TextStyle(color: Colors.white, fontSize: 18.sp)),
          SizedBox(height: 10.h),
          SizedBox(
            width: MediaQuery.of(context).size.width - 75.w,
            child: Text(
              '仿不来观音就仿个敦煌飞天吧~#有何不敢见观音 #敦煌壁画仿妆绝了',
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      id: "home",
      builder: (HomeController _) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
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
            title: Expanded(
              child: TabBar(
                controller: controller._tabController,
                // isScrollable: true,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                labelStyle: TextStyle(fontSize: 14.sp),
                tabs: controller.tabs.map((v) => Tab(text: v)).toList(),
              ),
            ),
          ),
          drawer: const SlidebarPage(),
          body: TabBarView(
            controller: controller._tabController,
            children: [
              ...controller.tabs
                  .sublist(0, controller.tabs.length - 1)
                  .map((v) => more(v)),
              _buildView(_),
            ],
          ),
        );
      },
    );
  }
}
