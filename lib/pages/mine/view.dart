part of mine;

const double headerOpacityThreshold = 120;

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;

  final ScrollController _scrollController = ScrollController();
  final RxDouble _headerOpacity = 0.0.obs;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      if (offset <= headerOpacityThreshold) {
        if (_headerOpacity.value != 0) {
          setState(() {
            _headerOpacity.value = 0;
          });
        }
      } else {
        if (_headerOpacity.value != 1) {
          setState(() {
            _headerOpacity.value = 1;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(child: ListView()),
      endDrawer: const SettingPage(),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 230.h,
              pinned: true, // 固定在顶部
              forceElevated: innerBoxIsScrolled,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(Icons.person_add, size: 24.sp),
                    onPressed: () {
                      Get.toNamed('/addfriend');
                    },
                  );
                },
              ),
              title: AnimatedOpacity(
                opacity: _headerOpacity.value,
                duration: const Duration(milliseconds: 500),
                child: Text(
                  '杨老虎🐯（磕穿下巴掉牙版）',
                  style: TextStyle(
                      color: Context(context).theme.textColor, fontSize: 16.sp),
                ),
              ),
              centerTitle: true,
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: Icon(Icons.menu, size: 24.sp),
                  ),
                )
              ],
              backgroundColor: Context(context).theme.themeColor,
              flexibleSpace: RepaintBoundary(
                child: FlexibleSpaceBar(background: _info()),
              ),
            ),
            SliverToBoxAdapter(
              child: RepaintBoundary(
                child: Padding(
                  padding: EdgeInsets.all(15.w),
                  child: _detail(context),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xffFFD700),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: TextStyle(
                    fontSize: 18.sp,
                  ),
                  tabs: [
                    Tab(text: '作品', height: kToolbarHeight.h),
                    Tab(text: '私密', height: kToolbarHeight.h),
                    Tab(text: '喜欢', height: kToolbarHeight.h),
                    Tab(text: '收藏', height: kToolbarHeight.h),
                  ],
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            OpusPage(1),
            OpusPage(2),
            OpusPage(3),
            OpusPage(4),
          ],
        ),
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: child,
    );
  }

  @override
  double get maxExtent => kToolbarHeight.h; //child.preferredSize.height
  @override
  double get minExtent => kToolbarHeight.h; //child.preferredSize.height

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

Widget _info() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
            '${Constants.imagesUrl}/images/aTnyHICCi-NMudWfVELeO.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100.h,
          height: 100.h,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(right: 15.w),
          decoration: BoxDecoration(
            border: Border.all(width: 2.h, color: Colors.white),
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: const ImageWidget(
              'https://p3-pc.douyinpic.com/img/aweme-avatar/tos-cn-avt-0015_f14282e10099a4b436a9ca62c0902595~c5_168x168.jpeg?from=2956013662'),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '杨老虎🐯（磕穿下巴掉牙版）',
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            Text(
              '抖音号：12345xiaolaohu',
              style: TextStyle(color: const Color(0xFFbababb), fontSize: 12.sp),
            )
          ],
        )
      ],
    ).padding(left: 20, top: 40, right: 20, bottom: 20),
  );
}

Widget _detail(BuildContext context) {
  return Column(children: [
    Row(children: [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Text(
                '124',
                style: TextStyle(
                    color: Context(context).theme.textColor, fontSize: 14.sp),
              ),
              Text('获赞',
                  style: TextStyle(
                      color: Context(context).theme.textColor, fontSize: 14.sp))
            ]),
            Column(children: [
              Text('3778',
                  style: TextStyle(
                      color: Context(context).theme.textColor,
                      fontSize: 14.sp)),
              Text('朋友',
                  style: TextStyle(
                      color: Context(context).theme.textColor, fontSize: 14.sp))
            ]),
            Column(children: [
              Text('3778',
                  style: TextStyle(
                      color: Context(context).theme.textColor,
                      fontSize: 14.sp)),
              Text('关注',
                  style: TextStyle(
                      color: Context(context).theme.textColor, fontSize: 14.sp))
            ]),
            Column(children: [
              Text('173.5万',
                  style: TextStyle(
                      color: Context(context).theme.textColor,
                      fontSize: 14.sp)),
              Text('粉丝',
                  style: TextStyle(
                      color: Context(context).theme.textColor, fontSize: 14.sp))
            ])
          ],
        ),
      ),
      SizedBox(width: 40.w),
      CupertinoButton(
        onPressed: () => Get.toNamed('/edit'),
        color: Context(context).theme.buttonBackgroundColor,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.button)),
        child: Text(
          '编辑资料',
          style: TextStyle(
              fontSize: 16.sp, color: Context(context).theme.textColor),
        ),
      )
    ]),
    SizedBox(height: 20.h),
    Text(
      '每晚12:00直播 韩舞业余，专业蹦迪！虎的小号@杨巅峰🐑🐯💜商务V：Joymedia7 💜💙这辈子人潮汹涌 遇到你  我很幸运💙',
      style:
          TextStyle(color: Context(context).theme.textColor, fontSize: 14.sp),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    ),
    SizedBox(height: 10.h),
    Row(children: [
      TagWidget(
        '27岁',
        icon: Icon(
          Icons.female,
          color: const Color.fromARGB(255, 255, 107, 236),
          size: 12.sp,
        ),
      ),
      SizedBox(width: 8.w),
      const TagWidget(
        '广东 - 珠海',
      )
    ]),
    SizedBox(height: 10.h),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(children: [
          Icon(Icons.shopping_cart,
              color: Context(context).theme.textColor, size: 24.sp),
          Text('抖音商城',
              style: TextStyle(
                  color: Context(context).theme.textColor, fontSize: 16.sp))
        ]),
        Column(children: [
          Icon(Icons.music_note,
              color: Context(context).theme.textColor, size: 24.sp),
          Text('我的音乐',
              style: TextStyle(
                  color: Context(context).theme.textColor, fontSize: 16.sp))
        ]),
        Column(children: [
          Icon(Icons.chat,
              color: Context(context).theme.textColor, size: 24.sp),
          Text('我的群聊',
              style: TextStyle(
                  color: Context(context).theme.textColor, fontSize: 16.sp))
        ]),
        Column(children: [
          Icon(Icons.widgets,
              color: Context(context).theme.textColor, size: 24.sp),
          Text('查看更多',
              style: TextStyle(
                  color: Context(context).theme.textColor, fontSize: 16.sp))
        ]),
      ],
    )
  ]);
}
