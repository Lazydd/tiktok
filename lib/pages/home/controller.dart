part of home;

class HomeController extends GetxController with GetTickerProviderStateMixin {
  HomeController();

  late TabController _tabController;
  final List<String> tabs = ['推荐', '直播', '关注'];

  @override
  void onInit() {
    super.onInit();
    _tabController = TabController(
      length: tabs.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _tabController.dispose();
    super.onClose();
  }
}
