part of 'index.dart';

class RecommendController extends GetxController {
  RecommendController();

  PageController pageController = PageController();

  List<String> list = [
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710135628505.mp4',
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710134657219.mp4',
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710135247921.mp4',
    'https://raw.githubusercontent.com/Lazydd/images/main/20250710135331880.mp4',
  ];

  Map<int, GlobalKey<VideoPlayerWidgetState>> videoKeys = {};

  int currentIndex = 0;

  Future<void> _getListData() async {
    list.addAll([
      'https://raw.githubusercontent.com/Lazydd/images/main/20250710135628505.mp4',
      'https://raw.githubusercontent.com/Lazydd/images/main/20250710134657219.mp4',
      'https://raw.githubusercontent.com/Lazydd/images/main/20250710135247921.mp4',
      'https://raw.githubusercontent.com/Lazydd/images/main/20250710135331880.mp4',
      'https://raw.githubusercontent.com/Lazydd/images/main/20250710135628505.mp4',
      'https://raw.githubusercontent.com/Lazydd/images/main/20250710134657219.mp4',
      'https://raw.githubusercontent.com/Lazydd/images/main/20250710135247921.mp4',
      'https://raw.githubusercontent.com/Lazydd/images/main/20250710135331880.mp4',
    ]);
    update(["recommend"]);
  }

  void _initData() {
    _getListData();
  }

  VideoPlayerWidgetState? get currentVideoKey =>
      videoKeys[currentIndex]?.currentState;

  void pageChange(int page) {
    currentIndex = page;
    if (list.length - page <= 3) {
      _getListData();
    }
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

  void find() {}

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
