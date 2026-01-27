part of 'index.dart';

class CommentController extends GetxController {
  CommentController();

  List commitlist = [];

  bool loading = false;
  Future<void> _getCommentData() async {
    loading = true;
    update(["comment"]);
    await Future.delayed(const Duration(milliseconds: 1000));
    commitlist = await TodoAPI.getComments(id: '1');
    loading = false;
    update(["comment"]);
  }

  List _sampleSize(List arr, int num) {
    List list = [];
    List<int> indexs = [];
    while (list.length != num) {
      int j = Random().nextInt(arr.length - 1);
      if (!indexs.contains(j)) {
        list.add(arr[j]);
        indexs.add(j);
      }
    }
    return list;
  }

  Future<void> showChildrenComment(dynamic item) async {
    item['loadingComment'] = true;
    update(["comment"]);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (item['showChildren'] == null) {
      item['children'] = _sampleSize(commitlist, 3);
      item['showChildren'] = true;
    } else {
      (item['children'] as List<dynamic>).addAll(_sampleSize(commitlist, 10));
    }
    item['loadingComment'] = false;
    update(["comment"]);
  }

  void _initData() {
    _getCommentData();
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
