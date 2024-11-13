part of home;

class HomeController extends GetxController with GetTickerProviderStateMixin {
  HomeController();

  PageController pageController = PageController();
  late TabController _tabController;
  final List<String> tabs = ['直播', '关注', '本地', '推荐'];

  _initData() {}

  void pageChange(int page) {
    update(['video']);
  }

  @override
  void onInit() {
    super.onInit();
    _tabController = TabController(
      length: tabs.length,
      initialIndex: tabs.length - 1,
      vsync: this,
    );
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    _tabController.dispose();
    super.onClose();
  }
}
