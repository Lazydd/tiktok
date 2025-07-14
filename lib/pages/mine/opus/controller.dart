part of 'index.dart';

class OpusController extends GetxController {
  final int type;

  OpusController(this.type);

  RefreshController refreshController = RefreshController();
  List list = [];
  List<String> list2 = [];

  // 页码
  int _pageNum = 1;

  // 后端返回的总数
  int? _total = 30;

  // 页尺寸
  final int _pageSize = 20;

  _getListData() async {
    // 1-待受理，2-待执行，3-待审核，4-待复核,6-已驳回,7-错单待处理,10-已完成
    Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;

    data["pageSize"] = _pageSize * _pageNum;
    data["pageNum"] = 1;

    Map<String, dynamic> r = await TodoAPI.getEventListByPage(data);
    // List tmpList = r['list'];
    // list.addAll(tmpList);
    list = r['list'];
    for (int i = 0; i < r['list'].length; i++) {
      list2.add(
          '${Constants.imagesUrl}/images/${r['list'][i]['video']['cover']['url_list'][0]}');
    }
    _total = r['total'];
    update(["opus"]);
  }

  // 下拉刷新
  void onRefresh() async {
    try {
      _pageNum = 1;
      await _getListData();
      refreshController.refreshCompleted(resetFooterState: true);
    } catch (error) {
      refreshController.refreshFailed();
    }
    update(["opus"]);
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

      update(["opus"]);
    } else {
      // 设置无数据
      refreshController.loadNoData();
    }
  }

  _initData() {
    _getListData();
    update(["opus"]);
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
    super.onClose();
  }
}
