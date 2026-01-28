import 'package:flutter/material.dart';

class HotSport extends StatefulWidget {
  const HotSport({super.key});

  @override
  State<HotSport> createState() => _HotSportState();
}

class _HotSportState extends State<HotSport>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        AnimatedBuilder(
          animation: _tabController,
          builder: (context, _) {
            final index = _tabController.index;
            return TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(),
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              labelStyle: TextStyle(fontWeight: .w700),
              unselectedLabelStyle: TextStyle(fontWeight: .normal),
              isScrollable: true,
              onTap: (i) {
                _tabController.animateTo(i);
              },
              tabs: [
                Tab(text: "猜你想看"),
                Tab(
                  child: index == 1
                      ? GradientText(
                          '抖音热榜',
                          gradient: LinearGradient(
                            colors: [Color(0xffffa547), Color(0xffda4d73)],
                          ),
                        )
                      : Text('抖音热榜'),
                ),
                Tab(text: "直播榜"),
                Tab(text: "音乐榜"),
                Tab(text: "品牌榜"),
                Tab(text: "团购榜"),
                Tab(text: "游戏榜"),
                Tab(text: "音乐榜"),
                Tab(text: "种草榜"),
                Tab(text: "短剧榜"),
              ],
            );
          },
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              Center(child: Text("猜你想看")),
              CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: ClampingScrollPhysics(),
                ),
                slivers: [
                  SliverFixedExtentList(
                    itemExtent: 30,
                    delegate: SliverChildBuilderDelegate(
                      (_, index) => ListTile(title: Text('抖音热榜项 $index')),
                      childCount: 30,
                    ),
                  ),
                ],
              ),
              Center(child: Text("直播榜")),
              Center(child: Text("音乐榜")),
              Center(child: Text("品牌榜")),
              Center(child: Text("团购榜")),
              Center(child: Text("游戏榜")),
              Center(child: Text("音乐榜")),
              Center(child: Text("种草榜")),
              Center(child: Text("短剧榜")),
            ],
          ),
        ),
      ],
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;

  const GradientText(this.text, {super.key, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) => gradient.createShader(bounds),
      blendMode: BlendMode.srcIn, // 使用BlendMode.srcIn来确保只显示渐变效果下的文本部分
      child: Text(text), // 使用白色文字确保渐变效果清晰可见
    );
  }
}
