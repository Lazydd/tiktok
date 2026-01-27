part of 'index.dart';

class HomeSearchController extends GetxController {
  HomeSearchController();

  final FormController formController = FormController();
  RefreshController refreshController = RefreshController();

  // 下拉刷新
  void onRefresh() async {
    try {
      refreshController.refreshCompleted(resetFooterState: true);
    } catch (error) {
      refreshController.refreshFailed();
    }
    update(["home_search"]);
  }

  int historyNum = 2;
  bool showAllHistory = false;

  void changeHistoryType() {
    showAllHistory = !showAllHistory;
    historyNum = showAllHistory ? 10 : 2;
    update(["home_search"]);
  }

  // 上拉加载
  void onLoading() async {}

  void _initData() {
    update(["home_search"]);
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

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
