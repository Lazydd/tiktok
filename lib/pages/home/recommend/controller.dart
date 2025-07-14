part of 'index.dart';

class RecommendController extends GetxController {
  RecommendController();

  PageController pageController = PageController();

  List<String> list = [
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710134657219.mp4',
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710135247921.mp4',
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710135331880.mp4',
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710135628505.mp4'
  ];

  Map<int, GlobalKey<VideoPlayerWidgetState>> videoKeys = {};

  int currentIndex = 0;

  _initData() {
    update(["recommend"]);
  }

  VideoPlayerWidgetState? get currentVideoKey =>
      videoKeys[currentIndex]?.currentState;

  void pageChange(int page) {
    currentIndex = page;
    // update(['video']);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  find() {}

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
