part of share;

class ShareController extends GetxController {
  ShareController();

  static const List<Map<String, dynamic>> topList = [
    {"name": "aaaa", "icon": 'https://dy.ttentau.top/assets/0-DZZhXKhG.png'},
    {"name": "加微信朋友", "icon": IconFont.wechat, "type": "wechat"},
    {"name": "更多", "icon": Icons.chevron_right, "type": "more"},
  ];

  static const List<Map<String, dynamic>> bottomList = [
    {"name": "转发", "icon": Icons.cached},
    {"name": "推荐给朋友", "icon": Icons.recommend},
    {"name": "复制链接", "icon": Icons.link},
    {"name": "合拍", "icon": Icons.sentiment_satisfied},
    {"name": "帮上热门", "icon": Icons.local_fire_department},
    {"name": "举报", "icon": Icons.warning},
    {"name": "私信朋友", "icon": Icons.send},
    {"name": "建群分享", "icon": Icons.forum},
    {"name": "保存至相册", "icon": Icons.download},
    {"name": "一起看视频", "icon": Icons.chair},
    {"name": "不感兴趣", "icon": Icons.heart_broken},
    {"name": "更多分享", "icon": Icons.more_horiz},
    {"name": "赞赏视频", "icon": Icons.attach_money},
    {"name": "生成图片", "icon": Icons.image},
    {"name": "实况照片", "icon": Icons.wb_sunny},
    {"name": "播放反馈", "icon": Icons.edit_square},
  ];

  _initData() {
    update(["share"]);
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
