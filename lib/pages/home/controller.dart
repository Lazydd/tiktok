part of home;

class HomeController extends GetxController with GetTickerProviderStateMixin {
  HomeController();

  PageController pageController = PageController();
  late TabController _tabController;
  final List<String> tabs = ['推荐', '直播', '关注'];

  List<String> list = [
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710134657219.mp4',
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710135247921.mp4',
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710135331880.mp4',
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710135628505.mp4'
  ];

  _initData() {
    update(["video"]);
  }

  void pageChange(int page) {
    // update(['video']);
  }

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
    _initData();
  }

  @override
  void onClose() {
    _tabController.dispose();
    super.onClose();
  }
}
