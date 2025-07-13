part of shop;

class ShopController extends GetxController {
  ShopController();

  RefreshController refreshController = RefreshController();

  List list = [];

  // 页码
  int _pageNum = 1;

  // 后端返回的总数
  int? _total = 30;

  // 页尺寸
  final int _pageSize = 10;

  _getListData() async {
    Map<String, dynamic> data = <String, dynamic>{};

    data["pageSize"] = _pageSize;
    data["pageNum"] = _pageNum;

    Map<String, dynamic> r = await TodoAPI.getEventListByPage3(data);
    list.addAll(r['list']);
    _total = r['total'];
    update(["shop"]);
  }

  // 下拉刷新
  void onRefresh() async {
    try {
      _pageNum = 1;
      list.clear();
      await _getListData();
      refreshController.refreshCompleted(resetFooterState: true);
    } catch (error) {
      refreshController.refreshFailed();
    }
    update(["shop"]);
  }

  // 上拉加载
  void onLoading() async {
    if (list.length < _total!) {
      try {
        _pageNum += 1;
        await _getListData();
        // 加载完成
        refreshController.loadComplete();
      } catch (e) {
        // 加载失败
        refreshController.loadFailed();
      }

      update(["shop"]);
    } else {
      // 设置无数据
      refreshController.loadNoData();
    }
  }

  _initData() {
    _getListData();
    update(["shop"]);
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

  @override
  void onClose() {
    refreshController.dispose();
    list.clear();
    super.onClose();
  }
}
