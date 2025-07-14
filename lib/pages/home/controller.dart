part of 'index.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  HomeController();

  late TabController _tabController;
  final List<String> tabs = ['推荐', '团购', '直播'];

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
