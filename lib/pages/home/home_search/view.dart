part of 'index.dart';

class HomeSearchPage extends StatefulWidget {
  const HomeSearchPage({super.key});

  @override
  State<HomeSearchPage> createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _HomeSearchViewGetX();
  }
}

class _HomeSearchViewGetX extends GetView<HomeSearchController> {
  const _HomeSearchViewGetX();

  // 主视图
  Widget _buildHistory(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < controller.historyNum; i++) {
      list.add(
        Row(
          children: [
            SizedBox(
              width: kToolbarHeight,
              child: Center(
                child: Icon(
                  Icons.access_time_outlined,
                  color: Context(context).theme.tagTextColor,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                '历史记录$i',
                style: TextStyle(color: Context(context).theme.tagTextColor),
              ),
            ),
            SizedBox(
              width: kToolbarHeight,
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.close,
                    color: Context(context).theme.tagTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return list.toColumn();
  }

  Widget _buildMore(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '花呗分批次介入...',
                  style: TextStyle(
                    color: Context(context).theme.appBarIconColor,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '恒大集团凌晨发...',
                  style: TextStyle(
                    color: Context(context).theme.appBarIconColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return list.toColumn();
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      // 刷新控制器
      enablePullDown: true,
      // 启用加载
      enablePullUp: true,
      // 启用上拉加载
      onRefresh: controller.onRefresh,
      // 下拉刷新回调
      onLoading: controller.onLoading,
      child: Column(
        children: [
          _buildHistory(context),
          TextButton(
            onPressed: () {
              controller.changeHistoryType();
            },
            child: Text(
              '展开全部',
              style: TextStyle(color: Context(context).theme.tagTextColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  '猜你想搜',
                  style: TextStyle(color: Context(context).theme.tagTextColor),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.refresh,
                      color: Context(context).theme.tagTextColor,
                    ),
                    Text(
                      '换一批',
                      style: TextStyle(
                        color: Context(context).theme.tagTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildMore(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeSearchController>(
      init: HomeSearchController(),
      id: "home_search",
      builder: (_) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Context(context).theme.appBarIconColor,
              size: 24.sp,
            ),
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios, size: 24.sp),
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  '搜索',
                  style: TextStyle(
                    color: Context(context).theme.appBarIconColor,
                    fontSize: 16.sp,
                  ),
                ),
                onPressed: () {
                  Get.toNamed(RouteNames.homeSearchRoute);
                },
              ),
            ],
            title: FormInput(
              controller: controller.formController,
              children: [
                Input.text(
                  name: 'name2',
                  label: "",
                  placeholder: "搜索用户名字/抖音号",
                  showClear: false,
                  leftIcon: Icon(Icons.search, color: const Color(0xFFC8C8C8)),
                ),
              ],
            ),
          ),
          body: SafeArea(child: _buildView(context)),
        );
      },
    );
  }
}
