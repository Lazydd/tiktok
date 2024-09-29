part of comment;

class CommentController extends GetxController {
  CommentController();

  List commitlist = [];

  _getCommentData() async {
    commitlist = await TodoAPI.getComments(id: '1');
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

  showChildrenComment(dynamic item) {
    if (item['showChildren'] == null) {
      item['children'] = _sampleSize(commitlist, 3);
      item['showChildren'] = true;
    } else {
      (item['children'] as List<dynamic>).addAll(_sampleSize(commitlist, 10));
    }
    update(["comment"]);
  }

  _initData() {
    _getCommentData();
    update(["comment"]);
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
